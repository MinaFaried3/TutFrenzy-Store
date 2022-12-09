import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frenzy_store/app/app_prefs.dart';
import 'package:frenzy_store/app/dependency_injection.dart';
import 'package:frenzy_store/presentation/resources/assets_manger.dart';
import 'package:frenzy_store/presentation/resources/constant_manger.dart';
import 'package:frenzy_store/presentation/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late Timer _timer;
  final AppPreferences _appPreferences = getItInstance<AppPreferences>();

  void _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  void _goNext() {
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) {
      if (isUserLoggedIn) {
        //if logged in navigate to main
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
      } else {
        _appPreferences
            .isOnBoardingScreenViewed()
            .then((isOnBoardingScreenViewed) {
          if (isOnBoardingScreenViewed) {
            //if onBoarding finished navigate to login
            Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
          } else {
            //first time use app
            Navigator.of(context).pushReplacementNamed(Routes.onBoardingRoute);
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Image.asset(ImageAssets.splashLogo),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}
