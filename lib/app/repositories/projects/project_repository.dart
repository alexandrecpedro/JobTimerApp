import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_status.dart';

/** Interface **/
abstract class ProjectRepository {
  // Methods
  Future<void> register(Project project);
  Future<List<Project>> findByStatus(ProjectStatus status);
}
