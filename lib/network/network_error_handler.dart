import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'server_exception.dart';

class NetworkErrorHandler {
  String getErrorTitle(BuildContext context, Object error) {
    final localizations = AppLocalizations.of(context)!;

    if (error is SocketException) {
      return localizations.notificationNoInternetTitle;
    } else {
      return localizations.notificationServerErrorTitle;
    }
  }

  String getErrorDescription(BuildContext context, Object error) {
    final localizations = AppLocalizations.of(context)!;

    if (error is SocketException) {
      return localizations.notificationNoInternetDescription;
    } else {
      return error is ServerException
          ? error.toString()
          : localizations.notificationServerErrorDescription;
    }
  }
}
