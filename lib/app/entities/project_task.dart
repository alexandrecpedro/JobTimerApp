import 'package:isar/isar.dart';

part 'project_task.g.dart';

@Collection()
class ProjectTask {
  // Attributes
  @Id()
  int? id;
  late String name;
  late int duration; // in hours
  late DateTime created = DateTime.now();
}
