import 'package:flutter/material.dart';
import 'package:learningdart/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Sair',
    content: 'Tem certeza que deseja sair?',
    optionsBuilder: () => {
      'Não': false,
      'Sim': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
