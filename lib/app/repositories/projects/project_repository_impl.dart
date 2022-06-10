import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:job_timer/app/core/database/database.dart';
import 'package:job_timer/app/core/exceptions/failure.dart';
import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/entities/project_task.dart';

import './project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  /** Attributes **/
  final Database _database;

  /** Constructor **/
  ProjectRepositoryImpl({required Database database}) : _database = database;

  /** Methods **/
  @override
  Future<void> register(Project project) async {
    try {
      // Connecting with database
      final connection = await _database.openConnection();

      // Inserting data on DB
      await connection.writeTxn((isar) {
        return isar.projects.put(project);
      });
    } on IsarError catch (e, s) {
      log('Error while registering project', error: e, stackTrace: s);
      // throw an exception => Failure
      throw Failure(message: 'Error while registering project');
    }
  }

  @override
  Future<List<Project>> findByStatus(ProjectStatus status) async {
    final connection = await _database.openConnection();

    final projects =
        await connection.projects.filter().statusEqualTo(status).findAll();

    return projects;
  }

  @override
  Future<Project> findById(int projectId) async {
    final connection = await _database.openConnection();
    final project = await connection.projects.get(projectId);

    if (project == null) {
      throw Failure(message: 'Project not found!');
    }

    return project;
  }

  @override
  Future<Project> addTask(int projectId, ProjectTask task) async {
    final connection = await _database.openConnection();
    // Find the project by its ID
    final project = await findById(projectId);
    // Add task
    project.tasks.add(task);
    // Save task
    await connection.writeTxn((isar) => project.tasks.save());

    return project;
  }

  @override
  Future<void> finishProject(int projectId) async {
    try {
      final connection = await _database.openConnection();
      final project = await findById(projectId);
      // change status
      project.status = ProjectStatus.finished;
      await connection.writeTxn(
        (isar) => connection.projects.put(project, saveLinks: true),
      );
    } on IsarError catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      throw Failure(message: 'Error while finishing project');
    }
  }
}
