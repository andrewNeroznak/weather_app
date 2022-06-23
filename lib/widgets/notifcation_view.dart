import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather_app/network/network_error_handler.dart';

class NotificationView extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Widget? subtitle;
  final IconData icon;
  final VoidCallback onRetry;

  const NotificationView({
    Key? key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.onRetry,
  }) : super(key: key);

  const NotificationView.noResults({
    Key? key,
    required this.title,
    this.subtitle,
    this.icon = Icons.filter_none,
    required this.onRetry,
  }) : super(key: key);

  const NotificationView.noInternet({
    Key? key,
    required this.title,
    this.subtitle,
    this.icon = Icons.perm_scan_wifi_rounded,
    required this.onRetry,
  }) : super(key: key);

  const NotificationView.serverError({
    Key? key,
    required this.title,
    this.subtitle,
    this.icon = Icons.error_rounded,
    required this.onRetry,
  }) : super(key: key);

  factory NotificationView.fromError(
    Object error, {
    Key? key,
    required BuildContext context,
    required VoidCallback onRetry,
  }) {
    final NetworkErrorHandler errorHandler = NetworkErrorHandler();
    if (error is SocketException) {
      return NotificationView.noInternet(
        title: Text(errorHandler.getErrorTitle(context, error)),
        subtitle: Text(errorHandler.getErrorDescription(context, error)),
        onRetry: onRetry,
      );
    } else {
      return NotificationView.serverError(
        title: Text(errorHandler.getErrorTitle(context, error)),
        subtitle: Text(errorHandler.getErrorDescription(context, error)),
        onRetry: onRetry,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final children = <Widget>[
      Flexible(
        child: Icon(
          icon,
          size: 200,
        ),
      ),
      const SizedBox(height: 20),
      DefaultTextStyle(
        style: theme.textTheme.headline6!.copyWith(fontSize: 24.0),
        textAlign: TextAlign.center,
        child: title,
      ),
    ];

    if (subtitle != null) {
      children.addAll([
        const SizedBox(height: 20),
        DefaultTextStyle(
          style: theme.textTheme.subtitle1!,
          textAlign: TextAlign.center,
          child: subtitle!,
        )
      ]);
    }

    final localizations = AppLocalizations.of(context)!;

    children.addAll([
      const SizedBox(height: 20),
      UnconstrainedBox(
        child: ElevatedButton(
          onPressed: onRetry,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(localizations.notificationRetry),
          ),
        ),
      ),
    ]);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxHeight < 200) return const SizedBox();

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: children,
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(350.0);
}
