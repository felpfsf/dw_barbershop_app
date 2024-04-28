import 'package:flutter/material.dart';

enum LoginStateStatus {
  initial,
  error,
  admLogin,
  employeeLogin,
}

class LoginState {
  final LoginStateStatus status;
  final String? error;

  LoginState.initial() : this(status: LoginStateStatus.initial);

  LoginState({
    required this.status,
    this.error,
  });

  LoginState copyWith({
    LoginStateStatus? status,
    ValueGetter<String?>? error,
  }) {
    return LoginState(
      status: status ?? this.status,
      error: error != null ? error() : this.error,
    );
  }
}
