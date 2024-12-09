import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:sales_assistant/login/models/models.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginObscureTextChanged>(_onObscureTextChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email,
      isValid: Formz.validate([state.password, email]),
    ));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      isValid: Formz.validate([password, state.email]),
    ));
  }

  void _onObscureTextChanged(
    LoginObscureTextChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(isObscure: !state.isObscure));
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        if (state.email.value == "test@test.com" &&
            state.password.value == "password") {
          emit(state.copyWith(status: FormzSubmissionStatus.success));
        } else {
          emit(state.copyWith(status: FormzSubmissionStatus.failure));
        }
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
