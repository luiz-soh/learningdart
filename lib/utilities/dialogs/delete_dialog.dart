import 'package:flutter/material.dart';
import 'package:learningdart/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Excluir',
    content: 'Tem certeza que deseja exluir?',
    optionsBuilder: () => {
      'Não': false,
      'Sim': true,
    },
  ).then(
    (value) => value ?? false,
  );
}