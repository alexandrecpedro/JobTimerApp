// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/view_models/project_task_model.dart';

class ProjectModel {
  /** Attributes **/
  final int? id;
  final String name;
  final int estimate;
  final ProjectStatus status;
  final List<ProjectTaskModel> tasks;

  /** Constructor **/
  ProjectModel({
    this.id,
    required this.name,
    required this.estimate,
    required this.status,
    required this.tasks,
  });

  // Converting Project into ProjectModel
  factory ProjectModel.fromEntity(Project project) {
    // Go to the DB and bring all data synchronous
    project.tasks.loadSync();

    return ProjectModel(
      id: project.id,
      name: project.name,
      estimate: project.estimate,
      status: project.status,
      // older Flutter version
      // tasks: project.tasks.map((e) => ProjectTaskModel.fromEntity(e)).toList(),
      // Newer Flutter versions
      tasks: project.tasks.map(ProjectTaskModel.fromEntity).toList(),
    );
  }
}
