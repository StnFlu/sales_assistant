import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:sales_assistant/login/models/models.dart';

final class LoginState extends Equatable {
  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final bool isValid;
  final bool isObscure;

  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
    this.isObscure = true,
  });

  LoginState copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    Password? password,
    bool? isValid,
    bool? isObscure,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      isObscure: isObscure ?? this.isObscure,
    );
  }

  @override
  List<Object> get props => [status, email, password, isObscure];
}
