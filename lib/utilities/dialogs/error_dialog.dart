import 'package:flutter/material.dart';
import 'package:learningdart/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog(
    context: context,
    title: 'Ocorreu um erro',
    content: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
