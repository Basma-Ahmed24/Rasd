// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasd/controller/user_bloc/user_cubit.dart';
import 'package:rasd/controller/user_bloc/user_state.dart';
import 'package:rasd/models/auth_models.dart';
import 'package:rasd/models/constants.dart';
import 'package:rasd/models/local_data_base/local_data_source.dart';
import 'package:rasd/sign_in.dart';

import 'drawer.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? name, email, phone, password, confirmPass, nationalId;
  var formkey = GlobalKey<FormState>();
  bool _showPassword = true;
  var scaffoldkey = GlobalKey<ScaffoldState>();
  // var nationalIdController = TextEditingController();
  var passwordcontroller = TextEditingController();
  // var firstnamecontroller = TextEditingController();
  // var lastnamecontroller = TextEditingController();
  // var phonecontroller = TextEditingController();
  //var confirmpasswordcontroller = TextEditingController();
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  // AuthModels? localUser;
  // Future<AuthModels> localUserData() async {
  //   // var db = LocalDataBase.db;

  //   await LocalDataBaseHelper().getUserData().then((value) {
  //     // print(value);
  //     localUser = value;
  //     return localUser;
  //   });
  //   return localUser!;
  // }

  // @override
  // void initState() {
  //   LocalDataBaseHelper().initDB();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStatus>(
      listener: (BuildContext context, state) {},
      builder: (ctx, state) {
        final cubit = UserCubit.get(ctx);
        return Scaffold(
          key: scaffoldkey,
          drawer: Navdrawer(),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Form(
              key: formkey,
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
                        onPressed: () => scaffoldkey.currentState?.openDrawer(),
                        icon: Icon(Icons.menu, size: 35, color: Colors.black),
                      ),
                    ]),
                    Container(
                      height: 70,
                      width: 250,
                      child: Image.asset("assets/logo.png"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Welcome To RASD !",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    textFormField(hintText: Constants.name),
                    SizedBox(height: 20),
                    textFormField(hintText: Constants.email),
                    SizedBox(height: 20),
                    textFormField(hintText: Constants.nationalId),
                    SizedBox(height: 20),
                    textFormField(hintText: Constants.phoneNumber),
                    SizedBox(height: 20),
                    textFormField(hintText: Constants.password),
                    SizedBox(height: 20),
                    textFormField(hintText: Constants.conPassword),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          formkey.currentState!.save();

                          await cubit
                              .authWithEmail(
                            email,
                            password,
                            context,
                          )
                              .then(
                            (value) async {
                              // await LocalDataBaseHelper().insertData(
                              //   AuthModels(
                              //     name: name,
                              //     email: email,
                              //     phone: phone,
                              //     nationalId: nationalId,
                              //     userId: value!.user!.uid,
                              //   ),
                              // );
                              //  await localUserData();
                              //  print("localUser!.name is ${localUser!.name}");
                              AuthModels user = AuthModels(
                                email: email,
                                phone: phone,
                                name: name,
                                nationalId: nationalId,
                                userId: value!.user!.uid,
                              );
                              await cubit.addUserInfo(context, user);
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          fixedSize: const Size(400, 55),
                          backgroundColor: Colors.orange),
                      child: Center(
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget textFormField({
    required String? hintText,
  }) {
    return TextFormField(
      keyboardType: hintText!.trim() == Constants.phoneNumber ||
              hintText.trim() == Constants.nationalId
          ? TextInputType.phone
          : TextInputType.name,
      controller:
          hintText.trim() == Constants.password ? passwordcontroller : null,
      // onChanged: (newValue) {
      //   if (hintText.trim() == Constants.name) {
      //     firstnamecontroller.text = newValue;
      //   } else if (hintText.trim() == Constants.email) {
      //     lastnamecontroller.text = newValue;
      //   } else if (hintText.trim() == Constants.nationalId) {
      //     nationalIdController.text = newValue;
      //   } else if (hintText.trim() == Constants.phoneNumber) {
      //     passwordcontroller.text = newValue;
      //   } else if (hintText.trim() == Constants.password) {
      //     passwordcontroller.text = newValue;
      //   } else if (hintText.trim() == Constants.conPassword) {
      //     confirmpasswordcontroller.text = newValue;
      //   }
      // },
      onSaved: (newValue) {
        if (hintText.trim() == Constants.name) {
          name = newValue!;
        } else if (hintText.trim() == Constants.email) {
          email = newValue!;
        } else if (hintText.trim() == Constants.nationalId) {
          nationalId = newValue!;
        } else if (hintText.trim() == Constants.phoneNumber) {
          phone = newValue!;
        } else if (hintText.trim() == Constants.password) {
          password = newValue!;
          passwordcontroller.text = newValue;
        } else if (hintText.trim() == Constants.conPassword) {
          confirmPass = newValue!;
        }
      },
      validator: (value) {
        if (hintText.trim() == Constants.name.trim()) {
          if (value!.isEmpty) {
            return "name must not be empty";
          }
        }
        if (hintText.trim() == Constants.email.trim()) {
          if (value!.isEmpty) {
            return "email must not be empty";
          }
        }
        if (hintText.trim() == Constants.nationalId.trim()) {
          if (value!.isEmpty) {
            return "National Id must not be empty";
          }
          if (value.length != 14) {
            return "Your national id must be 14 numbers";
          }
        }
        if (hintText.trim() == Constants.password.trim()) {
          if (value!.isEmpty) {
            return "password address must not be empty";
          }
          if (value.length < 8) {
            return "your password is short,you must input more than 8 characters ";
          }
        }
        if (hintText.trim() == Constants.phoneNumber.trim()) {
          if (value!.isEmpty) {
            return "phoneNumber  must not be empty";
          }
          if (value.length < 11) {
            return "your phoneNumber is short,you must input more than 11number ";
          }
        }
        if (hintText.trim() == Constants.conPassword.trim()) {
          if (value != passwordcontroller.text) {
            print(passwordcontroller.text);
            return "not match";
          }
        }
        return null;
      },
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueAccent,
            width: 2.0,
          ),
        ),
        prefixIcon: Icon(
          Icons.person_outlined,
          color: Colors.black45,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(13),
          ),
        ),
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 5,
        ),
      ),
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
