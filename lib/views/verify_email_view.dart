import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learningdart/constants/routes.dart';

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
            final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
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
