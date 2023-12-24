import 'dart:io';

import 'package:cleanex/core/network/api_constance.dart';
import 'package:dio/dio.dart';

class ApiService {
  static const String urlEncodedType = 'multipart/form-data';
  static const String jsonType = 'application/json';
  static const int unAuthorizedCode = 401;
  static const int internalServerErrorCode = 500;
  static const String authorizationParameter = 'Authorization';
  static const String bearer = 'Bearer';

  static Future<Response<T>?> getApi<T>(String path,Map<String, dynamic>? queryParameters,
      {bool isAuth = false}) async {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConstance.getAppBaseUrl(),
      ),
    );

    //call api

    final Response<T> response = await dio.get(
      path,
      queryParameters: queryParameters,
      options: Options(
        validateStatus: (int? status) {
          if (status != null) return status < internalServerErrorCode;
          return false;
        },
      ),
    );

    //check the status
    if (response.statusCode == unAuthorizedCode) {
     // await refreshToken();
      // return getApi(path, isAuth: isAuth);
      return null;
    } else {
      return response;
    }
  }

  static Future<Response<T>?> postApi<T>(
    String path, {
    Map<String, dynamic> body = const <String, dynamic>{},
    bool isJson = true,
    bool isAuth = false,
  }) async {
    // dio init
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConstance.getAppBaseUrl(),
      ),
    );
    //dio.interceptors
    //call api
    String token;

    final Response<T> response = await dio.post(
      path,
      data: body,
      options: Options(
        validateStatus: (int? status) {
          if (status != null) {
            return status < internalServerErrorCode;
          }
          return false;
        },
        contentType: isJson ? jsonType : urlEncodedType,
      ),
    );

    if (response.statusCode == unAuthorizedCode) {
      //await refreshToken();
      return null;
    } else {
      return response;
    }
  }


  static Future<Response<T>?> deleteApi<T>(
    String path, {
    bool isJson = true,
    bool isAuth = false,
  }) async {
    // dio init
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConstance.getAppBaseUrl(),
      ),
    );

    //call api
    // if (hasUserId) body['USER_ID'] = (await AppShared.getUser())?.id??null;

    final Response<T> response = await dio.delete(
      path,
      options: Options(
        validateStatus: (int? status) {
          if (status != null) return status < internalServerErrorCode;
          return false;
        },
        contentType: isJson ? jsonType : urlEncodedType,
      ),
    );
    if (response.statusCode == unAuthorizedCode) {
     // await refreshToken();
      // return postApi(path, body: body, isAuth: isAuth, isJson: isJson);
      return null;
    } else {
      return response;
    }
  }

  static Future<Response<T>?> patchApi<T>(
    String path, {
    Map<String, dynamic> body = const <String, dynamic>{},
    bool isJson = true,
    bool isAuth = false,
  }) async {
    // dio init
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConstance.getAppBaseUrl(),
      ),
    );

    //call api
    String token;

    final Response<T> response = await dio.patch(
      path,
      data: body,
      options: Options(
        validateStatus: (int? status) {
          if (status != null) return status < internalServerErrorCode;
          return false;
        },
        contentType: isJson ? jsonType : urlEncodedType,
      ),
    );

    // return response;
    //check the status
    if (response.statusCode == unAuthorizedCode) {
     // await refreshToken();
      // return postApi(path, body: body, isAuth: isAuth, isJson: isJson);
      return null;
    } else {
      return response;
    }
  }
}