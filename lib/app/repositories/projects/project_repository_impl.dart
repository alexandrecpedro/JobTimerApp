import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:job_timer/app/core/database/database.dart';
import 'package:job_timer/app/core/exceptions/failure.dart';
import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_status.dart';

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
}
