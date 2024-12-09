import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:sales_assistant/login/bloc/login_bloc.dart';
import 'package:sales_assistant/login/bloc/login_event.dart';
import 'package:sales_assistant/login/bloc/login_state.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Login Failure')),
              );
          } else if (state.status.isSuccess) {
            Navigator.of(context).pushReplacementNamed('/home');
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(8)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/logo.png'),
              ),
              const Padding(padding: EdgeInsets.all(16)),
              const _EmailInput(),
              const Padding(padding: EdgeInsets.all(8)),
              const _PasswordInput(),
              const Padding(padding: EdgeInsets.all(8)),
              const _LoginButton(),
            ],
          ),
        ));
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    final displayError =
        context.select((LoginBloc bloc) => bloc.state.email.displayError);
    return TextField(
      key: const Key('loginForm_emailInput_textField'),
      onChanged: (email) =>
          context.read<LoginBloc>().add(LoginEmailChanged(email)),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'Email',
        helperText: '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorText: displayError != null ? 'invalid email' : null,
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    final displayError =
        context.select((LoginBloc bloc) => bloc.state.password.displayError);
    return TextField(
      key: const Key('loginForm_passwordInput_textField'),
      onChanged: (password) =>
          context.read<LoginBloc>().add(LoginPasswordChanged(password)),
      obscureText: context.select((LoginBloc bloc) => bloc.state.isObscure),
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        helperText: '',
        errorText: displayError != null ? 'invalid password' : null,
        suffixIcon: IconButton(
          key: const Key('loginForm_passwordInput_obscureIcon'),
          onPressed: () =>
              context.read<LoginBloc>().add(LoginObscureTextChanged()),
          icon: Icon(context.select((LoginBloc bloc) => bloc.state.isObscure)
              ? Icons.visibility
              : Icons.visibility_off),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    final isInProgressOrSuccess = context.select(
      (LoginBloc bloc) => bloc.state.status.isInProgressOrSuccess,
    );

    if (isInProgressOrSuccess) return const CircularProgressIndicator();

    final isValid = context.select((LoginBloc bloc) => bloc.state.isValid);

    return ElevatedButton(
      key: const Key('loginForm_continue_raisedButton'),
      onPressed: isValid
          ? () => context.read<LoginBloc>().add(LoginSubmitted())
          : null,
      child: const Text('Login'),
    );
  }
}
