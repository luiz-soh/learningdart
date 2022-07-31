import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'dart:developer' as devtools show log;
import 'package:learningdart/constants/routes.dart';
import 'package:learningdart/utilities/show_error_dialog.dart';

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
    return Scaffold(
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
              try {
                final email = _email.text;
                final password = _password.text;
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();

                if (!mounted) return;
                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  await showErrorDialog(context, 'senha muito fraca');
                } else if (e.code == 'email-already-in-use') {
                  await showErrorDialog(context, 'e-mail ja está em uso');
                } else if (e.code == 'invalid-email') {
                  await showErrorDialog(context, 'e-mail inválido');
                } else {
                  await showErrorDialog(context, e.code);
                }
              } catch (e) {
                await showErrorDialog(context, e.toString());
              }
            },
            child: const Text("Cadastrar"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text('Ja tenho uma conta'),
          )
        ],
      ),
    );
  }
}
