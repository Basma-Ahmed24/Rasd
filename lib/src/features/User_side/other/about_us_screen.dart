import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constants.dart';

import '../drawer/drawer_screen.dart';

class AboutUsScreen extends StatelessWidget{
  @override
  final scaffoldkey = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: scaffoldkey,
      drawer: Navdrawer(),
      backgroundColor: Primary,
      body: Padding(
        padding: EdgeInsets.all(22),
        child: SingleChildScrollView(
          child: Column(children: [
          Row(
          children: [
          IconButton(
          onPressed: () {
      scaffoldkey.currentState?.openDrawer();
      },
          icon: Icon(
            Icons.menu,
            size: 44,
          ),
      ),
      SizedBox(
          width: MediaQuery.of(context).size.width / 8,
      ),
      Center(
          child: Image.asset(
            "assets/images/rasd 1.png",
            width: 128,
            height: 51,
          ),
      ),
      SizedBox(
          width: MediaQuery.of(context).size.width / 8,
      ),
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications,
            size: 33,
          ),
      )
      ],
    ),
    SizedBox(
    height: MediaQuery.of(context).size.height / 28,
    ),
    Row(children: [
    SizedBox(
    width: MediaQuery.of(context).size.width / 3,
    )
    ]),
    Text("About Us ",
    textAlign: TextAlign.center,
    style: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 32,
    color: green,
    fontFamily: "Montserrat",
    )),
    SizedBox(
    height: MediaQuery.of(context).size.height / 25,
    ),Center(child: Image.asset("assets/images/Rectangle 22.png",height: 193,width: 324,),)

          ,  SizedBox(
              height: MediaQuery.of(context).size.height / 25,
            )  ,Center(
              child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
   ,textAlign: TextAlign.center, style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Colors.black54,
                    fontFamily: "Montserrat",
                  ) ),
            ),SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),Center(
              child: Text("Follow Us On"
                  ,textAlign: TextAlign.center, style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: "Montserrat",
                  ) ),
            ),
            Padding(padding: EdgeInsets.all(50),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              Image.asset("assets/images/facebook-app-symbol.png")
              ,Image.asset("assets/images/twitter.png"),
              Image.asset("assets/images/instagram.png")],),
            )]),
        )) );
  }

}