import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';


import '../../../../utils/logger.dart';
import 'logging_interceptor.dart';

late DioClient dioClient;

class DioClient {
  final String baseUrl;
  final LoggingInterceptor loggingInterceptor;

  late Dio dio;
  late String token;
  String? _userToken;

  DioClient(this.baseUrl, Dio? dioC, {required this.loggingInterceptor}) {
    // token = AppConstants.authorizationToken;
    // log("DioClient x-api-key Token $token");
    dio = dioC ?? Dio();
    dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(milliseconds: 30000)
      ..options.receiveTimeout = const Duration(milliseconds: 30000)
      ..httpClientAdapter
      ..options.headers = {
        Headers.contentTypeHeader: 'application/json',
        Headers.acceptHeader: 'application/json',
      }
      ..options.responseType = ResponseType.json;
    dio.interceptors.add(loggingInterceptor);
    logger.f('DioClient ${dio.options.baseUrl}',
        tag: 'DioClient', error: dio.options.headers);
  }

  void updateHeader(String? token, {String? contentType}) {
    // token = token ?? this.token;
    // this.token = token;
    dio.options.headers = {
     Headers.acceptHeader: 'application/json',
      Headers.contentTypeHeader:
          contentType ?? 'application/json; charset=UTF-8',
      if (token != null) HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    log('updateUserToken : ${dio.options.headers}');
  }

  void updateUserToken(String? userToken) {
    _userToken = userToken ?? _userToken;
    dio.options.headers.update(
        HttpHeaders.authorizationHeader, (val) => 'Bearer $_userToken',
        ifAbsent: () => 'Bearer $_userToken');
    log('updateUserToken : ${dio.options.headers}');
  }

  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    bool token = true,
  }) async {
    try {
      CancelToken cancelToken = CancelToken();
     // pl('get : ${dio.options.headers} ${appStore.token}', 'DIO CLIENT');

      var response = await dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (err) {
      throw SocketException(err.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
      String uri, {
        Object? data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        bool token = true,
      }) async {
    try {
      CancelToken cancelToken = CancelToken();

      final fullUrl = "${dio.options.baseUrl}$uri"
          "${queryParameters != null ? "?${Uri(queryParameters: queryParameters).query}" : ""}";

      var response = await dio.post(
        uri,
        data: data, // ✅ send JSON instead of FormData
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      // ✅ Print response details
      log("✅ Response (${response.statusCode}) from $fullUrl");
      log("   Data       : ${response.data}");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      var response = await dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }
}
