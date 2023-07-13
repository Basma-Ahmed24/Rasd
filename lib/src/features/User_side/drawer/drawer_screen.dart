import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasd_app/src/core/utils/constants.dart';
import 'package:rasd_app/src/features/Admin_side/home/home_screen.dart';
import 'package:rasd_app/src/features/User_side/nav_bar/navigation_bar.dart';
import '../../../core/localization/language_localization.dart';
import '../../../core/network/shared_preferences.dart';
import '../onboardingscreens/screens/screen3.dart';
import '../other/about_us_screen.dart';
import '../other/contact_us.dart';
import '../profile/cubit.dart';
import '../profile/state.dart';
import '../settings/settings_screen.dart';

class Navdrawer extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  UserCubit user = UserCubit();
  dynamic list1;
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: const Color(0xff5B5B5B),
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 70,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,


                  // ignore: prefer_const_literals_to_create_immutables
                child:  BlocProvider(
                      create: (BuildContext context) => user
                        ..getUserData(CacheHelper.getData(key: "apiToken")),
                      child: BlocConsumer<UserCubit, UserState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            if (state is UserLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: green,
                                ),
                              );
                            } else if (state is UserLoaded) {
                              final list1 = UserCubit.get(context).p;
                              return Row(
                                children:[ Center(
                              child: Container(
                                child:
                                ClipOval(
                                  child:list1["profile_img"]!=null? Image.network("http://18.197.86.8/image/fetch_image?file_path=${ list1["profile_img"]}",
                                    fit: BoxFit.cover,
                                  ):ClipOval(
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.black26,
                                      size: 100,
                                    ),
                                  ),
                                ),
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.black12),
                                ),
                              ),
                            ),
                            const SizedBox(
                            width: 10,
                            ),Column(children: [
                                  Text(
                                    '${list1['fname']} ${list1["lname"]}',
                                    style: const TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        fontSize: 17),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${CacheHelper.getData(key: "apiToken")}',
                                    style: const TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontSize: 14),
                                  ),
                                ]),
                             ] );
                            } else {
                              return Text(
                                "No Data Available",
                                style: const TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontSize: 14),
                              );
                            }
                          }))
            )  ,


            Divider(
              color: Colors.white,
              endIndent: 70,
              indent: 20,
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
              TextButton(
                child: Text(
                    "${AppLocalizations.of(context)?.translate("home")}",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                onPressed: () {
                  navigateto(
                      context,
                      CacheHelper.getData(key: "apiToken") == "29001040202477"
                          ? AdminHome()
                          : MyNavigationBar());
                },
              )
            ]),
            Row(children: [
              const SizedBox(
                height: 20,
                width: 20,
              ),
              TextButton(
                child: Text(
                    "${AppLocalizations.of(context)?.translate("about us")}",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                onPressed: () {
                  navigateto(context, AboutUsScreen());
                },
              )
            ]),
            Row(children: [
              const SizedBox(
                height: 20,
                width: 20,
              ),
              TextButton(
                child: Text(
                    "${AppLocalizations.of(context)?.translate("t_and_c")}",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                onPressed: () {},
              )
            ]),
            Row(children: [
              const SizedBox(
                height: 20,
                width: 20,
              ),
              TextButton(
                child: Text(
                    "${AppLocalizations.of(context)?.translate("c_us")}",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                onPressed: () {
                  navigateto(context, ContactUSScreen());
                },
              )
            ]),
            Row(children: [
              const SizedBox(
                height: 20,
                width: 20,
              ),
              TextButton(
                child: Text(
                    "${AppLocalizations.of(context)?.translate("sign_or_signup")}",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                onPressed: () {
                  navigateto(context, Boarding3());
                },
              )
            ]),

            const SizedBox(
              height: 110,
            ),
            Divider(
              color: Colors.white,
              endIndent: 70,
              indent: 20,
            ),

            // ignore: prefer_const_literals_to_create_immutables
            Row(children: [
              const SizedBox(
                width: 20,
              ),
              TextButton(
                child: Text(
                    "${AppLocalizations.of(context)?.translate("settings")}",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                onPressed: () {
                  navigateto(context, Settings());
                },
              )
            ]),
            Row(children: [
              const SizedBox(
                height: 20,
                width: 20,
              ),
              TextButton(
                child: Text(
                    "${AppLocalizations.of(context)?.translate("logout")}",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                onPressed: () {
                  user.deleteUser(CacheHelper.getData(key: "apiToken"));
                  navigateto(context, Boarding3());
                },
              )
            ]),
            Row(children: [
              const SizedBox(
                height: 40,
                width: 30,
              ),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.west,
                    color: Colors.white,
                    size: 25,
                  ))
            ])

      ])  ));
  }
}
