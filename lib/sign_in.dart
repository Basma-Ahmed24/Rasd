//import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rasd/signup.dart';
import 'complains_page.dart';
import 'drawer.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String? email;
  String? password;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      drawer: Navdrawer(),
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
                  width: 10,
                ),
                Row(children: [
                  IconButton(
                      onPressed: () => scaffoldkey.currentState?.openDrawer(),
                      icon: Icon(
                        Icons.menu,
                        size: 35,
                        color: Colors.black,
                      )),
                ]),
                SizedBox(
                  height: 150,
                  width: 300,
                  child: Image.asset("assets/logo.png"),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Sign In"
                  "",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w800,
                      color: Colors.orange),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Welcome To RASD !",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    )),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: emailcontroller,
                  onChanged: (String value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "National Id must not be empty";
                    }
                    if (value.length < 14) {
                      return "Your national id must be 14 numbers";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(13)),
                    ),
                    prefixIcon: Icon(
                      Icons.credit_card,
                      color: Colors.black45,
                    ),
                    hintText: "National ID",
                  ),
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
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
                  onChanged: (String value) {
                    password = value;
                  },
                  obscureText: _showPassword,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                    hintText: "Password",
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
                  height: 20,
                ),

                // Sign In Button
                ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ComplainsScreen(),
                        ),
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
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not yet a member?',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()),
                          );
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
