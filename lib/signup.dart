// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:rasd/models/constants.dart';
>>>>>>> ac4246821ab2dd8e325bf35b05ea16ce3edd9afb
import 'package:rasd/sign_in.dart';

import 'drawer.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var firstnamecontroller = TextEditingController();
  var lastnamecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var confirmpasswordcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool _showPassword = true;
  var scaffoldkey = GlobalKey<ScaffoldState>();
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool _showPassword = true;
  var scaffoldkey = GlobalKey<ScaffoldState>();
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  var firstnamecontroller = TextEditingController();
  var lastnamecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var confirmpasswordcontroller = TextEditingController();
  Widget build(BuildContext context) {
<<<<<<< HEAD
    // TODO: implement build


=======
>>>>>>> ac4246821ab2dd8e325bf35b05ea16ce3edd9afb
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
                SizedBox(
                  height: 20,
                ),
                textFormField(hintText: Constants.firstName),
                SizedBox(
                  height: 20,
                ),
                textFormField(hintText: Constants.lastName),
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
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      formkey.currentState!.save();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInScreen()),
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
<<<<<<< HEAD
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      keyboardType: TextInputType.name,
                      controller: phonecontroller,
                      onChanged: (String value) {
                        print(value);
                      },
                      decoration: const InputDecoration(
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 2.0),
                          ),
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.black45,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(13),
                            ),
                          ),
                          hintText: "Phone No",
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 5)),
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordcontroller,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "password address must not be empty";
                      }
                      if (value.length < 8) {
                        return "your password is short,you must input more than 8 characters ";
                      }
                      return null;
                    },
                    onFieldSubmitted: (String value) {
                      print(value);
                    },
                    obscureText: _showPassword,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      hintText: "Password",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        child: Icon(
                          _showPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility,
                          color: Colors.black45,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: confirmpasswordcontroller,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value != passwordcontroller.text) {
                        return "not match";
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      print(value);
                    },
                    obscureText: _showPassword,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      hintText: "Confirm Password",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _togglevisibility();
                        },
                        child: Icon(
                          _showPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility,
                          color: Colors.black45,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        print(emailcontroller.text);
                        print(passwordcontroller.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()),
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
              )),
=======
                ),
              ],
            ),
          ),
>>>>>>> ac4246821ab2dd8e325bf35b05ea16ce3edd9afb
        ),
      ),
    );
  }

  Widget textFormField({String? hintText}) {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: lastnamecontroller,
      onChanged: (String value) {
        print(value);
      },
      onSaved: (newValue) {},
      validator: (value) {
        if (hintText!.trim() == Constants.nationalId.trim()) {
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
        if (hintText.trim() == Constants.conPassword.trim()) {
          if (value != passwordcontroller.text) {
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
