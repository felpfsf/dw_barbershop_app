import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/constants/local_storage_constants.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_nav_global_key.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final RequestOptions(:headers, :extra) = options;
    const authHeaderKey = 'Authorization';
    headers.remove(authHeaderKey);

    if (extra case {'DIO_AUTH': true}) {
      final sp = await SharedPreferences.getInstance();

      headers.addAll({
        authHeaderKey:
            'Bearer ${sp.getString(LocalStorageConstants.accessToken)}'
      });
    }

    handler.next(options);

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final DioException(requestOptions: RequestOptions(:extra), :response) = err;

    if (extra case {'DIO_ATH': true}) {
      if (response != null && response.statusCode == HttpStatus.forbidden) {
        // Remove token and redirect to login page
        Navigator.of(BarbershopNavGlobalKey.instance.navKey.currentContext!)
            .pushNamedAndRemoveUntil('/auth/login', (route) => false);
      }
    }

    handler.reject(err);
  }
}
