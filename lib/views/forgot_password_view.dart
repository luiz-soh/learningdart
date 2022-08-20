import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningdart/services/auth/bloc/auth_bloc.dart';
import 'package:learningdart/services/auth/bloc/auth_event.dart';
import 'package:learningdart/services/auth/bloc/auth_state.dart';
import 'package:learningdart/utilities/dialogs/error_dialog.dart';
import 'package:learningdart/utilities/dialogs/password_reset_email_sent_dialog.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.hasSentEmail) {
            _controller.clear();
            await showPasswordResetDialog(context);
          }
          if (state.exception != null) {
            _controller.clear();
            if (!mounted) return;
            await showErrorDialog(context,
                'Ocorreu um erro ao solicitar a sua solicitação ou não encontramos seu usuario');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Esqueci a senha'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                  'Preencha seu e-mail e nós enviaremos as instruções para recuperar a senha'),
              TextField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                autofocus: true,
                controller: _controller,
                decoration: const InputDecoration(hintText: 'E-mail'),
              ),
              TextButton(
                onPressed: () {
                  final email = _controller.text;
                  context
                      .read<AuthBloc>()
                      .add(AuthEventForgotPassword(email: email));
                },
                child: const Text('Enviar link para redefinir senha'),
              ),
              TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEventLogOut());
                },
                child: const Text('Voltar para tela de login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
