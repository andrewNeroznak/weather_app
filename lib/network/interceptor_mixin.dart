import 'dart:io';

import 'package:http/http.dart' as http;

import 'api_error.dart';

mixin Interceptor {
  http.Response interceptor(http.Response response) {
    final int statusCode = response.statusCode;

    try {
      switch (statusCode) {
        case 200:
          return response;
        case 401:
          throw APIError.invalidApiKey;
        case 404:
          throw APIError.notFound;
        default:
          throw APIError.unknown;
      }
    } on SocketException catch (_) {
      throw APIError.noInternetConnection;
    }
  }
}
