import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../constants/error_messages.dart';

@Singleton()
class CustomHttpClient extends http.BaseClient {
  final http.Client _client;

  CustomHttpClient(this._client);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request);
  }

  Future<Either<String, Map<String, dynamic>>> getJson(Uri url) async {
    try {
      final response = await get(url);

      return _processResponse(response);
    } on SocketException {
      return left(ErrorMessages.networkError);
    } on FormatException {
      return left(ErrorMessages.formatError);
    } catch (e) {
      return left('${ErrorMessages.unexpectedError}$e');
    }
  }

  Either<String, Map<String, dynamic>> _processResponse(
      http.Response response) {
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return right(data);
    } else if (response.statusCode == 404) {
      return left(ErrorMessages.productsNotFound);
    } else {
      return left(
          '${ErrorMessages.failedToLoadProducts} (Error ${response.statusCode})');
    }
  }
}
