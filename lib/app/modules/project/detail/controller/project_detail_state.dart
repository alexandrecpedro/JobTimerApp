// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'project_detail_controller.dart';

enum ProjectDetailStatus { initial, loading, complete, failure }

class ProjectDetailState extends Equatable {
  /** Attributes **/
  final ProjectDetailStatus status;
  // initializated as null => Modular
  final ProjectModel? projectModel;

  /** Constructor **/
  const ProjectDetailState._({
    required this.status,
    this.projectModel,
  });

  const ProjectDetailState.initial()
      : this._(status: ProjectDetailStatus.initial);

  /** Methods **/
  ProjectDetailState copyWith({
    ProjectDetailStatus? status,
    ProjectModel? projectModel,
  }) {
    return ProjectDetailState._(
      status: status ?? this.status,
      projectModel: projectModel ?? this.projectModel,
    );
  }

  @override
  List<Object?> get props => [status, projectModel];
}