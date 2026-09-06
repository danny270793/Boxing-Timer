import 'package:flutter/material.dart';

import '../../../../l10n/generated/app_localizations.dart';

Future<bool> showStopConfirmDialog(BuildContext context) async {
  final loc = AppLocalizations.of(context)!;
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(loc.stopDialogTitle),
      content: Text(loc.stopDialogBody),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(loc.cancelButton),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(loc.stopButton),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}
