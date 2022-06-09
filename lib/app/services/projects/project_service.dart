import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/view_models/project_model.dart';

/** Interface **/
abstract class ProjectService {
  /** Methods **/
  // Creating ViewModels that will become from controller and go through service
  // Entities belongs to service and repository
  Future<void> register(ProjectModel projectModel);
  Future<List<ProjectModel>> findByStatus(ProjectStatus status);
}