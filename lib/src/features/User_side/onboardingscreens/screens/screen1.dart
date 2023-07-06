import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/language_localization.dart';
import '../../../../core/utils/constants.dart';
import '../widgets/onboarding widget.dart';
import 'screen2.dart';
class Boarding1 extends StatelessWidget{
  @override

  Widget build(BuildContext context) {
   return Scaffold(backgroundColor: Primary,body:
     Padding(padding: EdgeInsets.all(22),
       child: OnBoarding("${AppLocalizations.of(context)?.translate("onBoarding1")}", "assets/images/rasd 1.png", "assets/images/Rectangle 1.png", Boarding2(),context)
     ),
   );
  }

}