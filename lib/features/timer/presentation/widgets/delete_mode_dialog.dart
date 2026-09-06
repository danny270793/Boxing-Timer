import 'package:flutter/material.dart';

import '../../../../l10n/generated/app_localizations.dart';

Future<bool> showDeleteModeDialog(BuildContext context, String modeName) async {
  final loc = AppLocalizations.of(context)!;
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(loc.deleteModeDialogTitle),
      content: Text(loc.deleteModeDialogBody(modeName)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(loc.cancelButton),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
          ),
          child: Text(loc.deleteButton),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}
