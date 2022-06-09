// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_controller.dart';

enum LoginStatus { initial, loading, failure }

class LoginState extends Equatable {

  /** Attributes **/
  final LoginStatus status;
  final String? errorMessage;

  /** Constructor **/
  const LoginState._({
    required this.status,
    this.errorMessage,
  });

  const LoginState.initial() : this._(status: LoginStatus.initial);

  /** Methods **/
  @override
  List<Object?> get props => [status, errorMessage];

  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
