import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class ServiceConfig {

  String _url = "";
  int timeout = 8000;

  ServiceConfig(this._url, {this.timeout = 8000} );


  Dio create() {
    Dio dio = Dio(
      BaseOptions(
        connectTimeout: timeout,
        baseUrl: _url,
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions request) async {
          //request.headers["token"] = "sa09f0dfkjfkashd";
          return request;
        },
        onResponse: (Response response) async {
          // decript
          return response;
        },
        onError: (DioError error) async {
          if (error.response.statusCode == 401) {
            print('Capturando erro de falta de autorização');
          } else if (error.response.statusCode == 404) {
            print('HTTP - Recurso não encontrado');
          }
          return error;
        },
      ),
    );
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  return dio;
  }
}
