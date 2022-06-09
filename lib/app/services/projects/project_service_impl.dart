// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/repositories/projects/project_repository.dart';
import 'package:job_timer/app/view_models/project_model.dart';

import './project_service.dart';

class ProjectServiceImpl implements ProjectService {
  /** Attributes **/
  final ProjectRepository _projectRepository;

  /** Constructor **/
  ProjectServiceImpl({
    required ProjectRepository projectRepository,
  }) : _projectRepository = projectRepository;

  /** Methods **/
  @override
  Future<void> register(ProjectModel projectModel) async {
    // Transform our project into an entity
    final project = Project()
      // Cascade Notation (Dart) => ex: project.id = projectModel.id >>> ..id = projectModel.id
      // It remembers spreadOperator combined with destructuring
      ..id = projectModel.id
      ..name = projectModel.name
      ..status = projectModel.status
      ..estimate = projectModel.estimate;

    await _projectRepository.register(project);

    // Obs.: The exceptions will be treated at controller
  }

  @override
  Future<List<ProjectModel>> findByStatus(ProjectStatus status) async {
    final projects = await _projectRepository.findByStatus(status);
    // Model Transform automatically
    return projects.map(ProjectModel.fromEntity).toList();
  }
}
