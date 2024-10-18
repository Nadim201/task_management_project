import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_management_project/Ui/Screen/onboarding/sign_in.dart';
import 'package:task_management_project/app.dart';
import 'package:task_management_project/data/controller/auth_controller.dart';

import '../model/network_response.dart';

class NetworkCaller {
  Future<NetworkResponse> getRequest(String url) async {
    final token = await AuthController.getAccessToken();
    try {
      final Uri uri = Uri.parse(url);
      debugPrint(url);
      final Response response = await get(
        uri,
        headers: {'Content-Type': 'application/json', 'token': '$token'},
      );

      if (response.statusCode == 200) {
        final decodeJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodeJson,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    final token = await AuthController.getAccessToken();
    try {
      final Uri uri = Uri.parse(url);

      Map<String, String> header = {
        'Content-Type': 'application/json',
        'token': '$token',
      };
      debugPrint(url);
      final Response response = await post(
        uri,
        headers: header,
        body: jsonEncode(body),
      );
      _statusPrint(url, response, '$token');
      dynamic decodeData;
      try {
        decodeData = jsonDecode(response.body);
      } catch (e) {
        decodeData = response.body;
      }

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodeData,
        );
      } else if (response.statusCode == 401) {
        moveToSignIn();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Unauthenticated',
        );
      } else if (decodeData is Map && decodeData['status'] == 'fail') {
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: decodeData['data']);
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  void _statusPrint(String url, Response response, String token) {
    debugPrint(
        'Url:$url,Status code:${response.statusCode}\n,Token :$token,\nbody code: ${response.body}');
  }

  Future<void> moveToSignIn() async {
    await AuthController.clearAccessToken();
    Navigator.pushAndRemoveUntil(
        TaskManagerApp.navigatorKey.currentContext!,
        MaterialPageRoute(builder: (builder) => const SignInScreen()),
        (predicate) => false);
  }
}
