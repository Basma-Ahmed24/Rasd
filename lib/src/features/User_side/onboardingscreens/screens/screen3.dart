import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rasd_app/src/core/utils/constants.dart';

import '../../../../core/localization/language_localization.dart';
import '../../sign_in/sign_in_screen.dart';
import '../../sign_up/sign_up_screen.dart';


class Boarding3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Primary,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 9,
          ),
          Center(
            child: Text(
              "${AppLocalizations.of(context)?.translate("onBoarding3")}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 32,
                color: green,
                fontFamily: "Montserrat",
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 20,
          ),
          Center(
            child: Image.asset("assets/images/rasd 1.png"),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 20,
          ),
          Center(
            child: Image.asset("assets/images/Rectangle 1 (5).png"),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 15,
          ),
          InkWell(
              onTap: () {
                navigateto(context, SignUp());
              },
              child: Container(
                height: 49,
                width: 138,
                decoration: BoxDecoration(
                    color: darkgray, borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Text(
                    "${AppLocalizations.of(context)?.translate("Sign_up")}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: green),
                  ),
                ),
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          InkWell(onTap: ()=>navigateto(context,SignIn()),
              child: Center(
            child: Text(
              "${AppLocalizations.of(context)?.translate("member")} ",
              style: TextStyle(
                  color: Blackff,
                  fontFamily: "Montserrat",
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
            ),
          ))
        ],
      ),
    );
  }
}
