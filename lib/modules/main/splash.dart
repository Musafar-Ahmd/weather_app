import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weather_app/constants/asset_path.dart';
import 'package:weather_app/extension/extension.dart';
import '../../constants/app_colors.dart';
import '../home/view/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _setUpSDK();
  }

  void _setUpSDK() async {
    Timer(const Duration(seconds: 2), () {});
    _startApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("cloudy.png".getPath(AssetPaths.image),
                height: 173, width: 260),
          ],
        ),
      ),
    );
  }

  void _startApp() async {
    var delayDuration = const Duration(seconds: 1);
    Timer(delayDuration, () {
      _navigateToHomeScreen();
    });
  }

  void _navigateToHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }
}
