import 'package:flutter/material.dart';


  const Color Primary = Color(0xfff4f4f4);
  const Color green=Color(0xff6dc592);
 const Color darkgray=Color(0xffE3E3E3);
 const Color Blackff=Color(0xff252525);
void navigateto(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));
class Constants {
  static const String fname = 'First Name';
  static const String lname = 'Last Name';
  static const String email = 'email';
  static const String Description = 'Description';
  static const String phoneNumber = 'Phone NO';
  static const String nationalId = 'National ID';
  static const String complainsName = 'complainsName';
  static const String complainsadress = 'complainsDetails';
  static const String complainsDate = 'complainsDate';
  static const String password = 'Password';
  static const String conPassword = 'Confirm Password';
  static const String user = 'user';
  static const String uid = 'userId';
  static const String complains = 'complains';
  static const String address = 'address';
  static const String complainsimage = 'complainsImage';
  static const String userImage = 'image';
  static const String proname = 'Project Title';
  static const String news = 'News Title';
  static const String startdate = 'Start Date';
  static const String enddate = 'End Date';

  static const IconData person1=Icons.person;
  static const IconData person2=Icons.person_outline;
  static const IconData pass=Icons.lock;
  static const IconData card=Icons.credit_card;
  static const IconData phone=Icons.phone;
  static const IconData lock=Icons.visibility;
  static const IconData unlock=Icons.visibility_off;
  static const IconData emaill=Icons.email;
}