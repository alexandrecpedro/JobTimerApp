import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:job_timer/app/services/auth/auth_service.dart';

part 'login_state.dart';

class LoginController extends Cubit<LoginState> {
  /** Attributes **/
  final AuthService _authService;

  /** Constructor **/
  LoginController({required AuthService authService})
      : _authService = authService,
        super(const LoginState.initial());

  /** Methods **/
  Future<void> signIn() async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      // Future.delayed(Duration(seconds: 2), () {
      //   emit(state.copyWith(status: LoginStatus.initial));
      // });
      await _authService.signIn();
    } catch (e, s) {
      // StackTrace => lines where error happened
      log("Error when tried to login", error: e, stackTrace: s);
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: "Error when tried to login",
      ));
    }
  }
}
