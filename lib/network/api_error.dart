enum APIError { invalidApiKey, noInternetConnection, notFound, unknown }

extension Description on APIError {
  String get descirption {
    switch (this) {
      case APIError.invalidApiKey:
        return 'Invalid API key';
      case APIError.noInternetConnection:
        return 'No Internet connection';
      case APIError.notFound:
        return 'City not found';

      case APIError.unknown:
        return 'Unexpected error occurred';
    }
  }
}
