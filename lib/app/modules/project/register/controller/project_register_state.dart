/* States:
(1) Intitial
(2) Loading - saving entered data
(3) Success
(4) Failure
*/

part of 'project_register_controller.dart';

enum ProjectRegisterStatus {
  initial,
  loading,
  success,
  failure;
}
