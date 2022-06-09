// ignore_for_file: public_member_api_docs, sort_constructors_first
class Failure implements Exception {
  /** Attributes **/
  final String message;

  /** Constructor **/
  Failure({
    required this.message,
  });
}
