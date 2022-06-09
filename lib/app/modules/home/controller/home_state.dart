// ignore_for_file: public_member_api_docs, sort_constructors_first
/* States:
(1) Intitial
(2) Loading - saving entered data
(3) Success
(4) Failure
*/

part of 'home_controller.dart';

enum HomeStatus {
  initial,
  loading,
  complete,
  failure;
}

class HomeState extends Equatable {
  /** Attributes **/
  final List<ProjectModel> projects;
  final HomeStatus status;
  final ProjectStatus projectFilter;

  /** Constructor **/
  const HomeState._({
    required this.projects,
    required this.status,
    required this.projectFilter,
  });

  // Initial State
  HomeState.initial()
      : this._(
          projects: [],
          projectFilter: ProjectStatus.in_progress,
          status: HomeStatus.initial,
        );

  /** Methods **/
  @override
  List<Object?> get props => [projects, status, projectFilter];

  HomeState copyWith({
    List<ProjectModel>? projects,
    HomeStatus? status,
    ProjectStatus? projectFilter,
  }) {
    return HomeState._(
      projects: projects ?? this.projects,
      status: status ?? this.status,
      projectFilter: projectFilter ?? this.projectFilter,
    );
  }
}
