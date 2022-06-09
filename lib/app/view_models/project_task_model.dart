// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:job_timer/app/entities/project_task.dart';

class ProjectTaskModel {
  /** Attributes **/
  int? id;
  String name;
  int duration;

  /** Constructor **/
  ProjectTaskModel({
    this.id,
    required this.name,
    required this.duration,
  });
  
  // Converting ProjectTask into ProjectTaskModel automatically
  factory ProjectTaskModel.fromEntity(ProjectTask task) {
    return ProjectTaskModel(
      id: task.id,
      name: task.name,
      duration: task.duration,
    );
  }
}
