import 'package:equatable/equatable.dart';

sealed class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class LoginEmailChanged extends LoginEvent {
  LoginEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class LoginPasswordChanged extends LoginEvent {
  LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class LoginObscureTextChanged extends LoginEvent {
  LoginObscureTextChanged();

  @override
  List<Object> get props => [];
}

final class LoginSubmitted extends LoginEvent {
  LoginSubmitted();
}
