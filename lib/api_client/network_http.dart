// The best way to handle network requests in Flutter
// Applications frequently need to perform POST and GET and other HTTP requests.
// Flutter provides an http package that supports making HTTP requests.

// HTTP methods: GET, POST, PATCH, PUT, DELETE

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:get/get_navigation/src/routes/get_route.dart';

class DioClient {
  static String baseURL =
      "https://api.stability.ai/v1/generation/stable-diffusion-v1-6/";

  static Future<Map<String, String>> _getHeaders() async {
    // final String? token = await getDataFromLocalStorage(
    //     dataType: LocalStorage.stringType, prefKey: LocalStorage.token);
    // final String? branchId = await getDataFromLocalStorage(
    //     dataType: LocalStorage.stringType,
    //     prefKey: LocalStorage.selectedBranchId);
    // debugPrint("Token -- '$token'");
    // debugPrint("branchId -- '$branchId'");
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      // if (token != null) 'Authorization': "Bearer $token",
      // if (branchId != null) "branchid": branchId,
      // "origin": "Mobile",
    };
  }

  static Future<Map<String, String>> _getHeadersWithToken() async {
    // SharedPreferences pref = await SharedPreferences.getInstance();
    var token = /*await pref.getString("token") ??*/ "";

    debugPrint("token----->  ${token}");

    // final String? branchId = await getDataFromLocalStorage(
    //     dataType: LocalStorage.stringType,
    //     prefKey: LocalStorage.selectedBranchId);
    // debugPrint("Token -- '$token'");
    // debugPrint("branchId -- '$branchId'");
    return {
      // 'Content-type': ''/*'application/json'*/,
    'Content-Type': 'multipart/form-data',
    'Authorization':'Bearer',
          // 'Bearer sk-Rem76eshTIObt1WgMTMWh1NNuJx4Dp7sxwy1s86lGTOyj9w4',
      'Accept': 'image/png',

      // if (token != null) 'Authorization': "Bearer $token",
      // if (branchId != null) "branchid": branchId,
      // "origin": "Mobile",
    };
  }

  static Future<Map<String, dynamic>> getMethod({
    @required String? url,
    bool isMockUrl = false,
  }) async {
    var header = await _getHeadersWithToken();
    debugPrint("${"=" * 200}\n"
        "*** Dio Get Headers : $header");
    debugPrint("*** Dio Get URL : '$baseURL$url'\n"
        "${"=" * 200}\n");

    Response response = await Dio().get(isMockUrl ? "$url" : "$baseURL$url",
        options: Options(
          headers: header,
        ));
    debugPrint("${"=" * 200}\n"
        "*** Dio Response Get Data ***\n"
        "Status Code: ${response.statusCode}\n"
        "Status Message: ${response.statusMessage}\n"
        "$response"
        "\n${"=" * 200}\n");
    var res = handlerDio(response);
    return res;
  }

  static Future<Response> getMethodTest(
      {@required String? url, bool isMockUrl = false, cancelToken}) async {
    var header = await _getHeadersWithToken();
    debugPrint("${"=" * 200}\n"
        "*** Dio Get Headers : $header");
    debugPrint(
        "*** Dio Get URL : '$baseURL$url'\n"
        "${"=" * 200}\n",
        wrapWidth: 1024);

    Response response = await Dio().get(isMockUrl ? "$url" : "$baseURL$url",
        options: Options(
          headers: header,
        ),
        cancelToken: cancelToken);
    debugPrint(
        "${"=" * 200}\n"
        "*** Dio Response Get Data ***\n"
        "Status Code: ${response.statusCode}\n"
        "Status Message: ${response.statusMessage}\n"
        "$response"
        "\n${"=" * 200}\n",
        wrapWidth: 1024);
    return response;
  }

  static Future<Map<String, dynamic>> postMethod({
    @required String? url,
    data,
    bool? asFormData,
    bool? isMockUrl=false,
  }) async {
    var header = await _getHeadersWithToken();
    debugPrint("${"=" * 200}\n"
        "*** Dio Post Headers : $header");
    debugPrint("*** Dio Post URL : $baseURL$url");
    debugPrint(
        "*** Dio Post Data : '${data.toString()}'"
        "\n${"=" * 200}\n",
        wrapWidth: 1024);
    Response response = await Dio().post(
      isMockUrl==true?"$url":
      "$baseURL$url",
      options: Options(
        headers: header,
      ),
      data: data == null
          ? null
          : asFormData == true
              ? FormData.fromMap(data)
              : jsonEncode(data),
    );
    debugPrint(
        "${"=" * 200}\n"
        "*** Dio Response Post Data ***\n"
        "Status Code: ${response.statusCode}\n"
        "Status Message: ${response.statusMessage}\n"
        "$response"
        "\n${"=" * 200}\n",
        wrapWidth: 1024);

    var res = handlerDio(response);

    return res;
  }

  static Future<Map<String, dynamic>> deleteMethod({
    @required String? url,
    data,
    bool? asFormData,
  }) async {
    var header = await _getHeadersWithToken();
    debugPrint("${"=" * 200}\n"
        "*** Dio Post Headers : $header");
    debugPrint("*** Dio Post URL : $baseURL$url");
    debugPrint(
        "*** Dio Delete Data : '${data.toString()}'"
        "\n${"=" * 200}\n",
        wrapWidth: 1024);
    Response response = await Dio().delete(
      "$baseURL$url",
      options: Options(
        headers: header,
      ),
      data: jsonEncode(data),
    );
    debugPrint(
        "${"=" * 200}\n"
        "*** Dio Response Delete Data ***\n"
        "Status Code: ${response.statusCode}\n"
        "Status Message: ${response.statusMessage}\n"
        "$response"
        "\n${"=" * 200}\n",
        wrapWidth: 1024);

    var res = handlerDio(response);

    return res;
  }

  static Future<Response> postMethodTest(
      {@required String? url, data, bool? asFormData, cancelToken}) async {
    var header = await _getHeadersWithToken();
    debugPrint("${"=" * 200}\n"
        "*** Dio Post Headers : $header");
    debugPrint("*** Dio Post URL : $baseURL$url");
    debugPrint(
        "*** Dio Post Data : '${data.toString()}'"
        "\n${"=" * 200}\n",
        wrapWidth: 1024);
    Response response = await Dio().post(
      "$baseURL$url",
      options: Options(
        headers: header,
      ),
      cancelToken: cancelToken,
      data: data == null
          ? null
          : asFormData == true
              ? FormData.fromMap(data)
              : jsonEncode(data),
    );
    debugPrint(
        "${"=" * 200}\n"
        "*** Dio Response Post Data ***\n"
        "Status Code: ${response.statusCode}\n"
        "Status Message: ${response.statusMessage}\n"
        "$response"
        "\n${"=" * 200}\n",
        wrapWidth: 1024);

    // var res = handlerDio(response);

    return response;
  }

  static Map<String, dynamic> handlerDio(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return {
        'body': response.data,
        'headers': response.headers,
        'error': null,
      };
    } else {
      if (response.statusCode == 403) {
        // Get.offAllNamed(PageRoutes.login);
        // clearBox();
        // clearLocalStorage();
      }
      return {
        'body': response.data,
        'headers': response.headers,
        'error': "${response.statusCode}",
      };
    }
  }
}
