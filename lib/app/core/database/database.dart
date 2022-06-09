import 'package:isar/isar.dart';

/** Interface **/
abstract class Database {
  Future<Isar> openConnection();
}