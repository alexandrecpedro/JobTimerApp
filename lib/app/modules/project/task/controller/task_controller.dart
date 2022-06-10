import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:job_timer/app/services/projects/project_service.dart';
import 'package:job_timer/app/view_models/project_model.dart';
import 'package:job_timer/app/view_models/project_task_model.dart';

part 'task_state.dart';

/** VIEW MODEL on MVVM Design Pattern **/
class TaskController extends Cubit<TaskStatus> {
  /** Attributes **/
  late final ProjectModel _projectModel;
  final ProjectService _projectService;

  /** Constructor **/
  TaskController({required ProjectService projectService})
      : _projectService = projectService,
        super(TaskStatus.initial);

  /** Methods **/
  void setProject(ProjectModel projectModel) => projectModel = _projectModel;

  Future<void> register(String name, int duration) async {
    try {
      emit(TaskStatus.loading);
      final task = ProjectTaskModel(name: name, duration: duration);
      // force _projectModel.id => it cannot be null
      await _projectService.addTask(_projectModel.id!, task);
      emit(TaskStatus.success);
    } catch (e, s) {
      log('Error while saving task', error: e, stackTrace: s);
      emit(TaskStatus.failure);
    }
  }
}
