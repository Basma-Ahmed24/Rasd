import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:rasd/complains_page.dart';
=======
>>>>>>> ac4246821ab2dd8e325bf35b05ea16ce3edd9afb
import 'package:rasd/profile_page.dart';
import 'package:rasd/sign_in.dart';
import 'package:rasd/signup.dart';
import 'package:rasd/view_complains.dart';

class Navdrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
        backgroundColor: Color(0xffFBFBFB),
        child: Column(children: [
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              SizedBox(

                width: 10,
              ),
              Center(
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: ShapeDecoration(
                    shape: CircleBorder(),
                    color: Colors.orange,
                    image:  DecorationImage(
                        image: AssetImage(
                            "assets/blank-profile-picture-973460_960_720.png"),
                    // shape: BoxShape.circle
                      )
                  ),
                ),
              ),SizedBox(width: 10,),Column(children:[ Text("User name:",style: TextStyle(
                fontWeight: FontWeight.w700,fontSize: 17
              ),),SizedBox(height: 10,), Text("Natiomal ID:",style: TextStyle(
                  fontWeight: FontWeight.w700,fontSize: 15
              ),),])],
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
              height: 30,
              width: 20,
            ),
            Icon(
              Icons.login,
              size: 35,
              color: Colors.orange,
            ),
            SizedBox(
              width: 15,
            ),
            TextButton(
              child: Text("Sign In",
                  style: TextStyle(
                      color: Colors.black,
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
              width: 20,
            ),
            Icon(
              Icons.app_registration,
              size: 35,
              color: Colors.orange,
            ),
            SizedBox(
              width: 15,
            ),
            TextButton(
              child: Text("Sign Up",
                  style: TextStyle(
                      color: Colors.black,
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


<<<<<<< HEAD
          Row(children: [
            SizedBox(
              height: 10,
              width: 20,
            ),
            Icon(
              Icons.comment_outlined,
              size: 35,
              color: Colors.orange,
            ),
            SizedBox(
              width: 15,
            ),
            TextButton(
              child: Text("Complaints",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontWeight: FontWeight.w700)),
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  ViewComplaints()),
                 );
              },
            )
          ]), Row(children: [
            SizedBox(
              height: 10,
              width: 20,
            ),
            Icon(
              Icons.menu_book_sharp,
              size: 35,
              color: Colors.orange,
            ),
            SizedBox(
              width: 15,
            ),
            TextButton(
              child: Text("Complaint Form",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontWeight: FontWeight.w700)),
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>ComplainsScreen() ),
                 );
              },
            )
          ]),
=======
>>>>>>> ac4246821ab2dd8e325bf35b05ea16ce3edd9afb
          Row(children: [
      SizedBox(
        height: 10,
        width: 20,
      ),
      Icon(
        Icons.person_outlined,
        size: 35,
        color: Colors.orange,
      ),
      SizedBox(
        width: 15,
      ),
      TextButton(
        child: Text("Profile",
            style: TextStyle(
                color: Colors.black,
                fontSize: 21,
                fontWeight: FontWeight.w700)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  Profile()),
          );
        },
      )]),
          SizedBox(
            height: 40,
          ),
          Text("Rates",
              style: TextStyle(
                  color: Colors.black,
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
            color: Colors.red,
          ),
          SizedBox(
            width: 15,
          ),
        ]));
  }
}
