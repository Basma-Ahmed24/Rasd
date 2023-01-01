//import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasd/controller/user_bloc/user_state.dart';
import 'package:rasd/signup.dart';
import 'complains_page.dart';
import 'controller/user_bloc/user_cubit.dart';
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
      body: BlocConsumer<UserCubit, UserStatus>(
        listener: (BuildContext context, state) {},
        builder: (ctx, state) {
          final cubit = UserCubit.get(ctx);
          {
            return SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height/10,
                      ),
                      SizedBox(
                        height:  MediaQuery.of(context).size.height/10,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset("assets/logo.png"),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/50,
                      ),
                      Text(
                        "Sign In"
                        "",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: Colors.orange),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/50,
                      ),
                      Text("Welcome To RASD !",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/50,),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: emailcontroller,
                        onSaved: (newValue) {
                          email = newValue;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "email must not be empty";
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
                          hintText: "email",
                        ),
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/50,
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
                        onSaved: (newValue) {
                          password = newValue;
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
                        height: MediaQuery.of(context).size.height/50,
                      ),

                      // Sign In Button
                      ElevatedButton(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            formkey.currentState!.save();

                            await cubit
                                .signInwithEmailandPass(
                                    email: email,
                                    pass: password,
                                    context: context)
                                .then(
                                  (value) => print(value.toString()),
                                );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            fixedSize: const Size(370, 50),
                            backgroundColor: Colors.orange),
                        child: Center(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height/70,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Not yet a member?',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w700),
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
            );
          }
        },
      ),
    );
  }
}
