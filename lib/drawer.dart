import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rasd/complains_page.dart';
import 'package:rasd/models/constants.dart';

import 'package:rasd/profile_page.dart';
import 'package:rasd/sign_in.dart';
import 'package:rasd/signup.dart';
import 'package:rasd/view_complains.dart';

import 'controller/user_bloc/user_cubit.dart';
import 'controller/user_bloc/user_state.dart';

class Navdrawer extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  const Navdrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStatus>(
        listener: (context, state) {},
        builder: (ctx, state) {
          final cubit = UserCubit.get(ctx);
          return FutureBuilder(
              future: cubit.getUserInfo(),
              builder: (context, data) {
                if (data.connectionState == ConnectionState.waiting) {
                  return const Center(child: SingleChildScrollView());
                }
                return data.hasError
                    ? const Center(
                        child: Text('an Error Occured'),
                      )
                    : Drawer(
                        backgroundColor: const Color(0xffFBFBFB),
                        child: Column(children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Center(
                                child: Container(
                                  width: 70,
                                  height: 70,
                                  decoration: ShapeDecoration(
                                    shape: const CircleBorder(),
                                    color: Colors.orange,
                                    image: (data.data as dynamic)[
                                                    Constants.userImage] ==
                                                null ||
                                            (data.data as dynamic)[
                                                    Constants.userImage] ==
                                                ''
                                        ? const DecorationImage(
                                            image: AssetImage(
                                                "assets/blank-profile-picture-973460_960_720.png"),
                                          )
                                        : DecorationImage(
                                            image: NetworkImage(
                                              (data.data as dynamic)[
                                                  Constants.userImage],
                                            ),
                                          ),
                                    // shape: BoxShape.circle
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              // ignore: prefer_const_literals_to_create_immutables
                              Column(children: [
                                Text(
                                  'User Name : ${(data.data as dynamic)[Constants.name]}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'national Id : ${(data.data as dynamic)[Constants.nationalId]}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15),
                                ),
                              ])
                            ],
                          ),
                          Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const SizedBox(
                                height: 10,
                                width: 10,
                              ),
                            ],
                          ),
                          Row(children: [
                            const SizedBox(
                              height: 30,
                              width: 20,
                            ),
                            const Icon(
                              Icons.login,
                              size: 35,
                              color: Colors.orange,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            TextButton(
                              child: const Text("Sign In",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w700)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInScreen()),
                                );
                              },
                            )
                          ]),
                          Row(children: [
                            const SizedBox(
                              height: 10,
                              width: 20,
                            ),
                            const Icon(
                              Icons.app_registration,
                              size: 35,
                              color: Colors.orange,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            TextButton(
                              child: const Text("Sign Up",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w700)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()),
                                );
                              },
                            )
                          ]),
                          Row(children: [
                            const SizedBox(
                              height: 10,
                              width: 20,
                            ),
                            const Icon(
                              Icons.comment_outlined,
                              size: 35,
                              color: Colors.orange,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            TextButton(
                              child: const Text("Complaints",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w700)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewComplaints()),
                                );
                              },
                            )
                          ]),
                          Row(children: [
                            const SizedBox(
                              height: 10,
                              width: 20,
                            ),
                            const Icon(
                              Icons.menu_book_sharp,
                              size: 35,
                              color: Colors.orange,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            TextButton(
                              child: const Text("Complaint Form",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w700)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ComplainsScreen()),
                                );
                              },
                            )
                          ]),
                          Row(children: [
                            const SizedBox(
                              height: 10,
                              width: 20,
                            ),
                            const Icon(
                              Icons.person_outlined,
                              size: 35,
                              color: Colors.orange,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            TextButton(
                              child: const Text("Profile",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w700)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Profile()),
                                );
                              },
                            )
                          ]),
                          const SizedBox(
                            height: 40,
                          ),
                          const Text("Rates",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(
                            height: 40,
                          ),
                          // ignore: prefer_const_literals_to_create_immutables
                          Row(children: [
                            const SizedBox(
                              width: 45,
                            ),
                            const Icon(
                              Icons.star,
                              size: 40,
                              color: Colors.yellow,
                            ),
                            const Icon(
                              Icons.star,
                              size: 40,
                              color: Colors.yellow,
                            ),
                            const Icon(
                              Icons.star,
                              size: 40,
                              color: Colors.yellow,
                            ),
                            const Icon(
                              Icons.star,
                              size: 40,
                              color: Colors.yellow,
                            ),
                            const Icon(
                              Icons.star,
                              size: 40,
                              color: Colors.yellow,
                            ),
                          ]),
                          const SizedBox(
                            height: 40,
                          ),
                          const Icon(
                            Icons.bar_chart_rounded,
                            size: 80,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                        ]));
              });
        });
  }
}
