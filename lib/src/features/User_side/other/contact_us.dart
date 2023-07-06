import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constants.dart';
import '../drawer/drawer_screen.dart';
import '../nav_bar/navigation_bar.dart';
import '../sign_up/sign_up_screen.dart';

class ContactUSScreen extends StatelessWidget{
  @override
  late String mailText;
  var formkey = GlobalKey<FormState>();

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
          child:
          Form(key: formkey,
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
    Text("Contact Us ",
    textAlign: TextAlign.center,
    style: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 32,
    color: green,
    fontFamily: "Montserrat",
    )),
    SizedBox(
    height: MediaQuery.of(context).size.height / 25,
    ),
              Row(
                children:[Text("Tel: +201234567890",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Color(0xff5B5B5B),

                      fontFamily: "Montserrat",
                    )),
            ]  ),SizedBox(height: 30,),Row(
                  children:[Text("Sample Text",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Color(0xff5B5B5B),

                        fontFamily: "Montserrat",
                      )),
                  ]  )
    ,SizedBox(height: 30,),Row(
    children:[Text("Sample Text",
    textAlign: TextAlign.start,
    style: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 20,
    color: Color(0xff5B5B5B),

    fontFamily: "Montserrat",
    )),
    ]  ),SizedBox(height: 50,),
              Text("Send Us an Email",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Color(0xff252525),

                    fontFamily: "Montserrat",
                  )),SizedBox(height: 10,),
              Container(
                  height: 150,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),child: complainsTextFormField(Constants.Description,)),
              SizedBox( height: MediaQuery.of(context).size.height/20,),
              ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    navigateto(context, MyNavigationBar());
                  }
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fixedSize: const Size(130, 49),
                    backgroundColor: green),
                child: Center(
                  child: Text(
                    "Send",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Montserrat"),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 8,
              ),
              InkWell(onTap: ()=>navigateto(context, SignUp()),
                child: Center(child: Text("Don’t have an account ? Create  ",textAlign: TextAlign.center,style: TextStyle(fontFamily:
                "Montserrat",fontWeight: FontWeight.w400,fontSize: 15,color: Color(0xff252525)),),),
              )]
            ),
          ),
        )));
  }Widget complainsTextFormField(String? hintText) {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) {
        if (hintText!.trim() == Constants.address) {
          mailText = newValue!;
        }
      },
      validator: (value) {
        if (hintText!.trim() == Constants.Description) {
          if (value!.isEmpty) {
            return "Text must not be empty";
          }

        }
        return null;
      },
      maxLines: 10,
      decoration: InputDecoration(
        hintStyle: TextStyle(
            color: Colors.black26,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: "Montserrat"),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.white,
            width: 50,
          ),
        ),

        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        hintText: hintText,

        contentPadding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 5,
        ),
      ),
      style: const TextStyle(
          color: Colors.black54,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: "Montserrat"),

    );}}