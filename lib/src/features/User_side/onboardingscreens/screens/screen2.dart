import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rasd_app/src/core/utils/constants.dart';
import 'package:rasd_app/src/features/User_side/onboardingscreens/screens/screen3.dart';


import '../../../../core/localization/language_localization.dart';
import '../../../../core/network/shared_preferences.dart';
import '../../../Admin_side/home/home_screen.dart';
import '../../nav_bar/navigation_bar.dart';
import '../widgets/onboarding widget.dart';

class Boarding2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print(CacheHelper.getData(key: "apiToken"));
    return Scaffold(
      backgroundColor: Primary, body:
    Padding(padding: EdgeInsets.all(22),
        child: OnBoarding("${AppLocalizations.of(context)?.translate("onBoarding2")}", "assets/images/rasd 1.png",
            "assets/images/Rectangle 1 (4).png",
            CacheHelper.getData(key: "apiToken") == null
                ? Boarding3()
                : CacheHelper.getData(key: "apiToken") == "29001040202477"
                ? AdminHome()
                : MyNavigationBar(), context)
    ),
    );
  }
}