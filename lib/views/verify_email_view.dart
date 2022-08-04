import 'package:flutter/material.dart';
import 'package:learningdart/constants/routes.dart';
import 'package:learningdart/services/auth/auth_service.dart';

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
          onPressed: () async {
            await AuthService.firebase().sendEmailVerification();
          },
          child: const Text('Enviar e-mail de verificação'),
        ),
        TextButton(
          onPressed: () {
            if (!mounted) return;
            Navigator.of(context).pushNamedAndRemoveUntil(
              loginRoute,
              (_) => false,
            );
          },
          child: const Text('Login'),
        )
      ]),
    );
  }
}
