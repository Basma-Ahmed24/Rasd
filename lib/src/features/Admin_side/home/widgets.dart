import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:rasd_app/src/core/utils/constants.dart';

Widget Button(String text,Widget screen,context)=> ElevatedButton(
onPressed: (){navigateto(context, screen);},
child: Text(
text,
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.w700,
fontFamily: "Montserrat"),
textAlign: TextAlign.center,
),
style: ElevatedButton.styleFrom(
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(10),
),
fixedSize:  Size(MediaQuery.of(context).size.width, 54),
backgroundColor: green,
),

);