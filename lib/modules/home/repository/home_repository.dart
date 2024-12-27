import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:weather_app/common/flushbar.dart';
import 'package:weather_app/constants/app_urls.dart';
import 'package:weather_app/modules/home/model/weather_model.dart';

class HomeRepository {
  Future<WetherModel?> getWeatherDetail(String place, BuildContext context) async {
    try {
      EasyLoading.show();

      var dio = Dio();
      var response = await dio.get(
        '${AppUrls.baseUrl}weather',
        queryParameters: {
          'q': place,
          'appid': AppUrls.appId,
          'units': 'metric',
        },
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();

        // Parse the JSON object directly into WetherModel
        return WetherModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      EasyLoading.dismiss();

      // Handle specific status codes and display appropriate error messages
      if (e.response?.statusCode == 404) {
        CommonFlushBar.showFlushbar(
          context: context,
          color: Colors.red,
          icon: Icons.circle_notifications_outlined,
          message: "City Not Found",
        );
      } else {
        CommonFlushBar.showFlushbar(
          context: context,
          color: Colors.red,
          icon: Icons.circle_notifications_outlined,
          message: e.response?.data.toString() ?? "An error occurred",
        );
      }
    } catch (e) {
      EasyLoading.dismiss();
      print("Error: $e");
    }
    return null;
  }
}
