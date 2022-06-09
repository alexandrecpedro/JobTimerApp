import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/services/projects/project_service.dart';
import 'package:job_timer/app/view_models/project_model.dart';

part 'project_register_state.dart';

/** BLOC **/
class ProjectRegisterController extends Cubit<ProjectRegisterStatus> {
  /** Attributes **/
  final ProjectService _projectService;

  /** Constructor **/
  ProjectRegisterController({required ProjectService projectService})
      : _projectService = projectService,
        super(ProjectRegisterStatus.initial);

  /** Methods **/
  Future<void> register(String name, int estimate) async {
    try {
      emit(ProjectRegisterStatus.loading);
      // generate a projectModel
      final project = ProjectModel(
        name: name,
        estimate: estimate,
        status: ProjectStatus.in_progress,
        tasks: [],
      );
      await _projectService.register(project);
      emit(ProjectRegisterStatus.success);
    } catch (e, s) {
      log('Error while saving project', error: e, stackTrace: s);
      emit(ProjectRegisterStatus.failure);
    }
  }
}
