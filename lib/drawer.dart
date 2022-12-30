import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rasd/additional_info.dart';
import 'package:rasd/sign_in.dart';
import 'package:rasd/signup.dart';

class Navdrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
        backgroundColor: Color(0xffFBFBFB),
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                height: 30,
                width: 10,
              ),
              Container(
                width: 270,
                height: 200,
                child: Image.asset("assets/Width-SkyCloud.png"),
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                height: 10,
                width: 10,
              ),
            ],
          ),
          Row(children: [
            SizedBox(
              height: 10,
              width: 70,
            ),
            Icon(
              Icons.login,
              size: 35,
              color: Colors.grey,
            ),
            SizedBox(
              width: 15,
            ),
            TextButton(
              child: Text("Sign In",
                  style: TextStyle(
                      color: Color(0xff274472),
                      fontSize: 21,
                      fontWeight: FontWeight.w700)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
            )
          ]),
          Row(children: [
            SizedBox(
              height: 10,
              width: 70,
            ),
            Icon(
              Icons.app_registration,
              size: 35,
              color: Colors.grey,
            ),
            SizedBox(
              width: 15,
            ),
            TextButton(
              child: Text("Sign Up",
                  style: TextStyle(
                      color: Color(0xff274472),
                      fontSize: 21,
                      fontWeight: FontWeight.w700)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
            )
          ]),
          Row(children: [
            SizedBox(
              height: 10,
              width: 70,
            ),
            Icon(
              Icons.perm_device_information,
              size: 35,
              color: Colors.grey,
            ),
            SizedBox(
              width: 15,
            ),
            TextButton(
              child: Text("Additional info",
                  style: TextStyle(
                      color: Color(0xff274472),
                      fontSize: 21,
                      fontWeight: FontWeight.w700)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdditionalInfoScreen()),
                );
              },
            )
          ]),
          Row(children: [
            SizedBox(
              height: 10,
              width: 70,
            ),
            Icon(
              Icons.settings_rounded,
              size: 35,
              color: Colors.grey,
            ),
            SizedBox(
              width: 15,
            ),
            TextButton(
              child: Text("Settings",
                  style: TextStyle(
                      color: Color(0xff274472),
                      fontSize: 21,
                      fontWeight: FontWeight.w700)),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) =>  SignInScreen()),
                // );
              },
            )
          ]),
          SizedBox(
            height: 40,
          ),
          Text("Rates",
              style: TextStyle(
                  color: Color(0xff274472),
                  fontSize: 25,
                  fontWeight: FontWeight.w700)),
          SizedBox(
            height: 40,
          ),
          Row(children: [
            SizedBox(
              width: 45,
            ),
            Icon(
              Icons.star,
              size: 40,
              color: Colors.yellow,
            ),
            Icon(
              Icons.star,
              size: 40,
              color: Colors.yellow,
            ),
            Icon(
              Icons.star,
              size: 40,
              color: Colors.yellow,
            ),
            Icon(
              Icons.star,
              size: 40,
              color: Colors.yellow,
            ),
            Icon(
              Icons.star,
              size: 40,
              color: Colors.yellow,
            ),
          ]),
          SizedBox(
            height: 40,
          ),
          Icon(
            Icons.bar_chart_rounded,
            size: 80,
            color: Color(0xff274472),
          ),
          SizedBox(
            width: 15,
          ),
        ]));
  }
}
