import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningdart/services/auth/bloc/auth_bloc.dart';
import 'package:learningdart/services/auth/bloc/auth_event.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificar e-mail'),
      ),
      body: Column(children: [
        const Text('Te enviamos um e-mail de verificação'),
        const Text('se não recebeu o e-mail por favor clique no botão abaixo'),
        TextButton(
          onPressed: () {
            context
                .read<AuthBloc>()
                .add(const AuthEventSendEmailVerification());
          },
          child: const Text('Enviar e-mail de verificação'),
        ),
        TextButton(
          onPressed: () {
            context.read<AuthBloc>().add(const AuthEventLogOut());
          },
          child: const Text('Login'),
        )
      ]),
    );
  }
}
