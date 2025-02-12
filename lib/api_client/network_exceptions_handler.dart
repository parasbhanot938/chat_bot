import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkExceptionsHandler {
  NetworkExceptionsHandler._();

  static getException(Object e, s) async {
    debugPrint("API Error -- $e  $s");

    if (e is DioException) {
      debugPrint(
          "API Data Error -- ${e.response?.data} \n${e.requestOptions.path}\n${e.requestOptions.data} ",
          wrapWidth: 1024);

      Get.snackbar(
          "${e.response?.statusCode ?? e.type ?? ""} ${e.response?.statusMessage ?? e.error ?? ""} "
              .trim(),
          "Error");

      switch (e.response?.statusCode) {
        case 400:
          // showErrorSnackBar("Bad Request",);
          break;
        case 401:
          // showErrorSnackBar("401 Unauthorised",);
          break;
        case 403:
          // showErrorSnackBar("403 Forbidden",);
          break;
        case 404:
          try {
            if (e.response?.data["message"] == "Patient not found") {
              // SharedPreferences prefs = await SharedPreferences.getInstance();
              // prefs.clear();
              // await Get.deleteAll(force: true);
              // Get.offAll(SignInView());
              // showErrorSnackBar("Patient not found",);
            } else {
              // showErrorSnackBar("404 Not Found",);
            }
          } catch (e) {}
          break;
        case 500:
          // showErrorSnackBar("Internal Server Error",);
          break;
        default:
          // showErrorSnackBar("${e.response?.statusCode} ${e.response?.statusMessage} ",);
          break;
      }
    } else {
      Get.snackbar("Unable to parse data", "Error");
    }
  }
}
