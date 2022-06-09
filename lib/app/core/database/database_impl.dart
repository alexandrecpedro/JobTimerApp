import 'package:isar/isar.dart';
import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_task.dart';
import 'package:path_provider/path_provider.dart';

import './database.dart';

class DatabaseImpl implements Database {
  /** Attributes **/
  Isar? _databaseInstance;

  /** Methods **/
  @override
  Future<Isar> openConnection() async {
    // It will not be opened everytime
    // Reopens the previous one, unless it was closed
    if (_databaseInstance == null) {
      final dir = await getApplicationSupportDirectory();
      _databaseInstance = await Isar.open(
        schemas: [ProjectTaskSchema, ProjectSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return _databaseInstance!;
  }
}
