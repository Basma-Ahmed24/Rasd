import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rasd/sign_in.dart';
import 'package:rasd/signup.dart';

import 'drawer.dart';

class AdditionalInfoScreen extends StatefulWidget {
  @override
  State<AdditionalInfoScreen> createState() => _AdditionalInfoScreenState();
}

class _AdditionalInfoScreenState extends State<AdditionalInfoScreen> {
  @override
  DateTime? dateTime;
  int? age;
  var scaffoldkey = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(

        key: scaffoldkey,
        drawer: Navdrawer(),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 0,
                      ),
                      Row(children: [
                        IconButton(
                            onPressed: () =>
                                scaffoldkey.currentState?.openDrawer(),
                            icon: Icon(
                              Icons.menu,
                              size: 35,
                              color: Colors.black,
                            )),
                      ]),
                      Container(
                        height: 150,
                        width: 250,
                        child: Image.asset("assets/logo.png"),
                      ),
                      Text(
                        "Additional Information",
                        style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 20,
                      )
                      // ,Text(dateTime ==null? "Nothing has been picked yet !": dateTime,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black45),),
                      ,
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1940),
                                  lastDate: DateTime(2023))
                              .then((date) {
                            setState(() {
                              dateTime = date;
                            });
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            fixedSize: const Size(400, 55),
                            backgroundColor: Colors.orange),
                        child: Center(
                          child: Text(
                            "Pick Your Birthdate",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          age = (DateTime.now().year) - (dateTime!.year);
                          setState(() {
                            age;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            fixedSize: const Size(400, 55),
                            backgroundColor: Colors.orange),
                        child: Center(
                          child: Text(
                            "Calculate",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        age == null
                            ? "Please Pick your birthdate and Tab on calculate "
                            : "Your age is : ${age.toString()} Years old",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black45),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            side:
                                BorderSide(width: 3, color: Colors.orange),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            fixedSize: const Size(400, 55),
                            backgroundColor: Colors.white),
                        child: Center(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ]))));
  }
}
// booodyyyy
