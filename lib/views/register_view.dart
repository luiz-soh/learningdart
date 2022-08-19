import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'dart:developer' as devtools show log;
import 'package:learningdart/services/auth/auth_exceptions.dart';
import 'package:learningdart/services/auth/bloc/auth_bloc.dart';
import 'package:learningdart/services/auth/bloc/auth_event.dart';
import 'package:learningdart/services/auth/bloc/auth_state.dart';
import 'package:learningdart/utilities/dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          if (state is WeakPasswordAuthException) {
            await showErrorDialog(context, 'senha muito fraca');
          } else if (state is EmailAlreadyInUseAuthException) {
            await showErrorDialog(context, 'e-mail ja está em uso');
          } else if (state is InvalidEmailAuthException) {
            await showErrorDialog(context, 'e-mail inválido');
          } else if (state is GenericAuthException) {
            await showErrorDialog(context, 'ocorreu um erro no cadastro');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro'),
        ),
        body: Column(
          children: [
            TextField(
              controller: _email,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: 'E-mail'),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(hintText: 'Senha'),
            ),
            TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;

                context
                    .read<AuthBloc>()
                    .add(AuthEventRegister(email, password));
              },
              child: const Text("Cadastrar"),
            ),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEventLogOut());
              },
              child: const Text('Ja tenho uma conta'),
            )
          ],
        ),
      ),
    );
  }
}
