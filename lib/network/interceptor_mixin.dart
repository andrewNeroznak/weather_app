import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'server_exception.dart';

mixin Interceptor {
  http.Response interceptor(http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode >= 200 && statusCode < 300) {
      return response;
    } else {
      try {
        final result = json.decode(response.body);
        debugPrint(result.toString());
        final message = result['message'];

        throw ServerException(
          message,
          statusCode,
        );
      } on FormatException catch (e) {
        debugPrint('Cannot format error: $e');
        throw ServerException(
          'Internal server error',
          statusCode,
        );
      }
    }
  }
}
