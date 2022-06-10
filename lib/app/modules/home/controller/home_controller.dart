import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/services/projects/project_service.dart';
import 'package:job_timer/app/view_models/project_model.dart';

part 'home_state.dart';

/** BLOC **/
class HomeController extends Cubit<HomeState> {
  /** Attributes **/
  final ProjectService _projectService;

  /** Constructor **/
  HomeController({required ProjectService projectService})
      : _projectService = projectService,
        super(HomeState.initial());

  /** Methods **/
  Future<void> loadProjects() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      final projects = await _projectService.findByStatus(state.projectFilter);
      emit(state.copyWith(status: HomeStatus.complete, projects: projects));
    } catch (e, s) {
      log('Error while searching projects', error: e, stackTrace: s);
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> filter(ProjectStatus status) async {
    emit(state.copyWith(status: HomeStatus.loading, projects: []));
    // searching projects
    final projects = await _projectService.findByStatus(status);
    // change screen state
    emit(
      state.copyWith(
        status: HomeStatus.complete,
        projects: projects,
        projectFilter: status,
      ),
    );
  }

  void updateList() => filter(state.projectFilter);
}
