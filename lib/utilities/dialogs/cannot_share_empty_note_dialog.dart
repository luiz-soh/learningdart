import 'package:flutter/material.dart';
import 'package:learningdart/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'compartilhando',
    content: 'Você não pode compartilhar uma nota vazia',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
