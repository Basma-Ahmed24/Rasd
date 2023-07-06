
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rasd_app/src/core/utils/constants.dart';
import 'package:rasd_app/src/features/User_side/sign_up/bloc/cubit.dart';
import 'package:rasd_app/src/features/User_side/sign_up/bloc/state.dart';


import '../../../core/localization/language_localization.dart';
import '../../../core/network/shared_preferences.dart';
import '../nav_bar/navigation_bar.dart';
import 'bloc/SignUpModel.dart';
import 'component.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  String? name, email, phone, password, confirmPass, address, nationalId,loc;

  var formkey = GlobalKey<FormState>();

  bool showPassword = true;

  var scaffoldkey = GlobalKey<ScaffoldState>();

  var nationalIdController = TextEditingController();

  var passwordcontroller = TextEditingController();

  var firstnamecontroller = TextEditingController();

  var lastnamecontroller = TextEditingController();

  var phonecontroller = TextEditingController();

  var addersscontroller = TextEditingController();

  var confirmpasswordcontroller = TextEditingController();

  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SignUpCubit(),
        child: BlocConsumer<SignUpCubit, SignUpState>(
            listener: (context, state) {
              if (state.isSuccess) {
                navigateto(context,MyNavigationBar());
                // that should occur after a successful sign-up
              } else if (state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage!)),
                );}
            },
            builder: (context, state) {
              return Scaffold(
                backgroundColor: Primary,
                body: Padding(
                  padding: EdgeInsets.all(32),
                  child: SingleChildScrollView(
                      child: Form(
                        key: formkey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 15,
                            ),
                            Center(
                              child: Text(
                                "${AppLocalizations.of(context)?.translate("Sign_up")}",
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
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 13,
                            ),
                            Container(
                                height: 53,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: textFormField(show: false,
                                    hintText:  "${AppLocalizations.of(context)?.translate("fname")}", icon: Constants
                                        .person1)),
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 28,
                            ),
                            Container(
                                height: 53,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: textFormField(show: false,
                                    hintText:  "${AppLocalizations.of(context)?.translate("lname")}", icon: Constants
                                        .person2)),
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 28,
                            ),
                            Container(
                                height: 53,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: textFormField(show: false,
                                    hintText:  "${AppLocalizations.of(context)?.translate("id")}",
                                    icon: Constants.card)),

                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 40,
                            ),
                            Row(children: [
                              InkWell( onTap:(){ _pickImage(context);} ,
                                child: Container(width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 3,
                                    height: 120,
                                    child: Column(children: [
                                      Text("${AppLocalizations.of(context)?.translate("fimage")} ",
                                        style: TextStyle(
                                            color: Colors.black26,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Montserrat"),),
                                      done==false?
                                      Icon(Icons.add_a_photo, size: 50,
                                        color: Colors.black26,): Icon(Icons.done, size: 50,
                                        color: Colors.green,)

                                    ])),
                              ),
                              SizedBox(width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 13,),
                           GestureDetector( onTap:()=> _pickImage(context),
                                child: Container(width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 3,
                                    height: 120,
                                    child: Column(children: [
                                      Text("${AppLocalizations.of(context)?.translate("limage")}",
                                        style: TextStyle(
                                            color: Colors.black26,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Montserrat"),),
                                      done==false?
                                      Icon(Icons.add_a_photo, size: 50,
                                        color: Colors.black26,): Icon(Icons.done, size: 50,
                                        color: Colors.green,)
                                    ])),
                              ),
                            ]),
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 60,
                            ),
                            Container(
                                height: 53,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: textFormField(show: false,
                                    hintText:  "${AppLocalizations.of(context)?.translate("phone")}",
                                    icon: Constants.phone)),
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 28,
                            ),
                            Container(
                                height: 53,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: textFormField(show: false,
                                    hintText:  "${AppLocalizations.of(context)?.translate("address")}", icon: Icons
                                        .home,locathion: Icons.location_on)),
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 28,
                            ),
                            Container(
                                height: 53,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: textFormField(show: true,
                                  hintText:  "${AppLocalizations.of(context)?.translate("pass")}",
                                  icon: Constants.pass,

                                )),
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 28,
                            ),
                            Container(
                                height: 53,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: textFormField(show: true,
                                  hintText:  "${AppLocalizations.of(context)?.translate("cpass")}",
                                  icon: Constants.pass,

                                )),
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 15,
                            ),

                            ElevatedButton(
                              onPressed: state.isLoading ? null : () =>
                                  _onSignUpPressed(context),
                              child: state.isLoading
                                  ? const CircularProgressIndicator(color: green,)
                                  :  Text(
                                "${AppLocalizations.of(context)?.translate("enter")}",
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
                                fixedSize: const Size(138, 49),
                                backgroundColor: green,
                              ),

                            ),
                          ],
                        ),
                      )),
                ),

              );
            }));
  }

  void _onSignUpPressed(BuildContext context) {
    if (formkey.currentState!.validate()) {
      final signUpModel = SignUpModel(
        googleId: nationalIdController.text,
        fname: firstnamecontroller.text,
        lname: lastnamecontroller.text,
        idCardImg: _imagePath,
        email: 'No Email Added',
        mobileNumber: phonecontroller.text,
        address: addersscontroller.text,
        passHash: passwordcontroller.text,
        isAdmin: 0
      );
      CacheHelper.savedata(key: "apiToken", value: nationalIdController.text,);
      context.read<SignUpCubit>().signUp(signUpModel);
    }
  }

    Widget textFormField({
    required String? hintText,
    required bool show,
    IconData? icon,
    IconData? lock,
    IconData? locathion,
    Function(String)? onchange,
    }) {
    late TextEditingController controller;

    if(hintText==
     "${AppLocalizations.of(context)?.translate("fname")}")
    controller = firstnamecontroller;

    if(hintText==
        "${AppLocalizations.of(context)?.translate("lname")}")
    controller = lastnamecontroller;
    if(hintText==
        "${AppLocalizations.of(context)?.translate("id")}")
    controller = nationalIdController;
    if(hintText==
        "${AppLocalizations.of(context)?.translate("phone")}")
    controller = phonecontroller;
    if(hintText==
        "${AppLocalizations.of(context)?.translate("address")}")
    controller = addersscontroller;
    if(hintText==
        "${AppLocalizations.of(context)?.translate("pass")}")
    controller = passwordcontroller;
    if(hintText==
        "${AppLocalizations.of(context)?.translate("cpass")}")
    controller = confirmpasswordcontroller;



    return TextFormField(
    keyboardType: hintText!.trim() ==  "${AppLocalizations.of(context)?.translate("id")}" ||
    hintText.trim() ==  "${AppLocalizations.of(context)?.translate("phone")}"
    ? TextInputType.phone
        : TextInputType.name,
    controller: hintText.trim() == "${AppLocalizations.of(context)?.translate("pass")}" ? passwordcontroller : controller,
    onSaved: (newValue) {
    if (hintText.trim() ==  "${AppLocalizations.of(context)?.translate("fname")}") {
    name = newValue!;
    } else if (hintText.trim() ==  "${AppLocalizations.of(context)?.translate("id")}") {
    nationalId = newValue!;
    } else if (hintText.trim() ==  "${AppLocalizations.of(context)?.translate("phone")}") {
    phone = newValue!;
    } else if (hintText.trim() ==  "${AppLocalizations.of(context)?.translate("address")}") {
    address = newValue!;
    } else if (hintText.trim() ==  "${AppLocalizations.of(context)?.translate("pass")}") {
    password = newValue!;
    passwordcontroller.text = newValue;
    } else if (hintText.trim() ==  "${AppLocalizations.of(context)?.translate("cpass")}") {
    confirmPass = newValue!;
    }
    },
    obscureText: show,
    validator: (value) {
    if (hintText.trim() ==  "${AppLocalizations.of(context)?.translate("fname")}".trim()) {
    if (value!.isEmpty) {
    return "your name must not be empty";
    }
    }
    if (hintText.trim() ==  "${AppLocalizations.of(context)?.translate("lname")}".trim()) {
    if (value!.isEmpty) {
    return "your name must not be empty";
    }
    }
    if (hintText.trim() ==  "${AppLocalizations.of(context)?.translate("id")}".trim()) {
    if (value!.isEmpty) {
    return "National Id must not be empty";
    }
    if (value.length < 14) {
    return "Your national id must be 14 numbers";
    }
    }
    if (hintText.trim() ==  "${AppLocalizations.of(context)?.translate("pass")}".trim()) {
    if (value!.isEmpty) {
    return "password must not be empty";
    }
    if (value.length < 4 || value.length > 4) {
    return "your password must be 4 numbers ";
    }
    }
    if (hintText.trim() ==  "${AppLocalizations.of(context)?.translate("phone")}".trim()) {
    if (value!.isEmpty) {
    return "phoneNumber must not be empty";
    }
    if (hintText.trim() ==  "${AppLocalizations.of(context)?.translate("address")}".trim()) {
    if (value!.isEmpty) {
    return "address must not be empty";
    }
    if (value.length < 11) {
    return "your phoneNumber is short,you must input more than 11number ";
    }
    }
    if (hintText.trim() ==  "${AppLocalizations.of(context)?.translate("cpass")}".trim()) {
    if (value != passwordcontroller.text) {
    print(passwordcontroller.text);
    return "your password not match";
    }
    }
    return null;
    }
    },

    decoration: InputDecoration(
    hintStyle: TextStyle(
    color: Colors.black26,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: "Montserrat",
    ),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(
    color: Colors.white,
    width: 50,
    ),
    ),
    prefixIcon: Icon(
    icon,
    color: Colors.black54,
    ),

    border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(
    Radius.circular(10),
    ),
    ),
    hintText: hintText,
    suffixIcon: InkWell(
    onTap: ()async {
      addersscontroller.text= await getCurrentLocation() ;
   print(address);

    },

          child: Icon(
            locathion,
            color: Colors.black26,
          ),
        ),
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
    );
  }

  String? _imagePath;

bool done=false;

  Future<void> _pickImage(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return ImagePickerDialog(
          onImageSelected: (path) {
            Navigator.of(context).pop(path);
          },
        );
      },
    );

    if (result != null) {
      _imagePath = result;
      setState(() {
        done=true;
      });

    }

  }
}
