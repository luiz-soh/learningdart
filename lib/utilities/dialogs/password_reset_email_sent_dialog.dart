import 'package:flutter/material.dart';
import 'package:learningdart/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Esqueci a senha',
    content: 'Te enviamos um e-mail com as instruções para resetar sua senha',
    optionsBuilder: () => {
      'OK': null
    }
  );
}
