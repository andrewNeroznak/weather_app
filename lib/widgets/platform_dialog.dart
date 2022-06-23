import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformDialog extends StatelessWidget {
  final Widget title;
  final Widget content;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const PlatformDialog({
    Key? key,
    required this.title,
    required this.content,
    this.onConfirm,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: title,
        content: content,
        actions: <Widget>[
          if (onCancel != null)
            CupertinoDialogAction(
              onPressed: onCancel,
              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
            ),
          if (onConfirm != null)
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: onConfirm,
              child: Text(MaterialLocalizations.of(context).okButtonLabel),
            ),
        ],
      );
    } else {
      return AlertDialog(
        title: title,
        content: content,
        actions: <Widget>[
          if (onCancel != null)
            ElevatedButton(
              onPressed: onCancel,
              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
            ),
          if (onConfirm != null)
            ElevatedButton(
              onPressed: onConfirm,
              child: Text(MaterialLocalizations.of(context).okButtonLabel),
            ),
        ],
      );
    }
  }
}
