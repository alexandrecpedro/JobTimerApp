import 'package:isar/isar.dart';
import 'package:job_timer/app/entities/project_status.dart';

class ProjectStatusConverter extends TypeConverter<ProjectStatus, int> {
  /** Constructor **/
  const ProjectStatusConverter();

  /** Methods **/
  @override
  ProjectStatus fromIsar(int statusIndex) {
    // Convert Isar value to ProjectStatus value
    return ProjectStatus.values[statusIndex];
  }

  @override
  int toIsar(ProjectStatus object) {
    return object.index;
  }
}
