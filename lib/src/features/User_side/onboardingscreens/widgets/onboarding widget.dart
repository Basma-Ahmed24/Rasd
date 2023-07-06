import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rasd_app/src/core/utils/constants.dart';

Widget OnBoarding(String title,String Path1,String Path2 ,Widget screen,context)=>
  SingleChildScrollView(
    child: Column(children: [SizedBox(height: MediaQuery.of(context).size.height/8,),
      Center(child: Text(title,textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w700,fontSize: 32,color: green,fontFamily: "Montserrat",),),),

      SizedBox(height: MediaQuery.of(context).size.height/20,),
      Center(child:  Image.asset(Path1),),
      SizedBox(height: MediaQuery.of(context).size.height/20,),
      Center(child: Image.asset(Path2),),
      SizedBox(height: MediaQuery.of(context).size.height/35,),
      InkWell(onTap:(){ navigateto(context, screen);},child: Container(height: 77,width: 77,decoration: BoxDecoration(color: darkgray,borderRadius: BorderRadius.circular(50)),child: Icon(Icons.east_outlined,color: green,size: 41,),))
    ],


    ),
  );
