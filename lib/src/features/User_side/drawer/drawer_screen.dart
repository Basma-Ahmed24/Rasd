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
UserCubit user=UserCubit();
dynamic list1;
  @override
  Widget build(BuildContext context) {
  return BlocProvider(
      create: (BuildContext context) => user..getUserData(CacheHelper.getData(key: "apiToken")),
      child: BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
    builder: (context, state) {
    if (state is UserLoading) {
    return const Center(
    child: CircularProgressIndicator(color: green,),
    );
    } else if (state is UserLoaded) {
    final list1 = UserCubit.get(context).p;
              return Drawer(
                    backgroundColor: const Color(0xff5B5B5B),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        const SizedBox(
                          height: 70,
                        ),
                        SingleChildScrollView(scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Center(
                                child: Container(
                                  width: 85,
                                  height: 85,
                                  decoration: ShapeDecoration(
                                    shape: const CircleBorder(),

                                    image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/Rectangle 1.png"),
                                    )

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
                                  '${list1['fname']} ${list1["lname"]}',
                                  style: const TextStyle(fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 17),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${CacheHelper.getData(key: "apiToken")}',
                                  style: const TextStyle(fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      fontSize: 14),
                                ),
                              ])
                            ],
                          ),
                        ),
                        Divider(color: Colors.white,endIndent: 70,indent: 20,),
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
                            child:  Text("${AppLocalizations.of(context)?.translate("home")}",

                                style: TextStyle(fontFamily: "Montserrat",
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600)),
                            onPressed: () {
navigateto(context, CacheHelper.getData(key: "apiToken")=="29001040202477"?AdminHome():MyNavigationBar());
                            },
                          )
                        ]),
                        Row(children: [
                          const SizedBox(
                            height: 40,
                            width: 20,
                          ),

                          TextButton(
                            child:  Text("${AppLocalizations.of(context)?.translate("about us")}",

                                style: TextStyle(fontFamily: "Montserrat",
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600)),
                            onPressed: () {navigateto(context, AboutUsScreen());

                            },
                          )
                        ]),
                        Row(children: [
                          const SizedBox(
                            height: 30,
                            width: 20,
                          ),

                          TextButton(
                            child:  Text("${AppLocalizations.of(context)?.translate("t_and_c")}",

                                style: TextStyle(fontFamily: "Montserrat",
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600)),
                            onPressed: () {

                            },
                          )
                        ]),
                        Row(children: [
                          const SizedBox(
                            height: 30,
                            width: 20,
                          ),

                          TextButton(
                            child:  Text("${AppLocalizations.of(context)?.translate("c_us")}",

                                style: TextStyle(fontFamily: "Montserrat",
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600)),
                            onPressed: () {navigateto(context, ContactUSScreen());

                            },
                          )
                        ]),
                        Row(children: [
                          const SizedBox(
                            height: 30,
                            width: 20,
                          ),

                          TextButton(
                            child:  Text("${AppLocalizations.of(context)?.translate("sign_or_signup")}",

                                style: TextStyle(fontFamily: "Montserrat",
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600)),
                            onPressed: () {navigateto(context, Boarding3());

                            },
                          )
                        ]),

                        const SizedBox(
                          height: 181,
                        ),
                        Divider(color: Colors.white,endIndent: 70,indent: 20,),

                        // ignore: prefer_const_literals_to_create_immutables
                        Row(children: [
                          const SizedBox(

                            width: 20,
                          ),

                          TextButton(
                            child:  Text("${AppLocalizations.of(context)?.translate("settings")}",

                                style: TextStyle(fontFamily: "Montserrat",
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600)),
                            onPressed: () {
navigateto(context, Settings());
                            },
                          )
                        ]),
                        Row(children: [
                          const SizedBox(
                            height: 40,
                            width: 20,
                          ),

                          TextButton(
                            child:  Text("${AppLocalizations.of(context)?.translate("logout")}",

                                style: TextStyle(fontFamily: "Montserrat",
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600)),
                            onPressed: () {user.deleteUser(CacheHelper.getData(key:"apiToken"));
navigateto(context, Boarding3());
                            },
                          )
                        ]),
                 Row(children:[  const SizedBox(
                   height: 40,
                   width: 30,
                 ),  InkWell(onTap: (){
                   Navigator.pop(context);
                 }, child: Icon( Icons.west,color: Colors.white,size: 25,))])
  ]),
                    ));
   }else if (state is UserError&&state.errorMessage.contains("404")) {
      return Center(child:
      Container(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,color: Colors.white,child:
      Column(children: [Image.asset("assets/images/WhatsApp Image 2023-06-22 at 17.32.19.jpg",height: MediaQuery.of(context).size.height/2,width: MediaQuery.of(context).size.width,),
        Text("Oops!,there are some issues occur, we are working on it .",style:TextStyle(color: green,fontSize: 25,fontWeight: FontWeight.w700),)],)),);
    }else{return Container(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,color: Colors.white,child:
      Column(children: [Image.asset("assets/images/WhatsApp Image 2023-06-22 at 17.32.19.jpg",height: MediaQuery.of(context).size.height/2,width: MediaQuery.of(context).size.width,),
      Text("No Internet, Please Open Your Network and Re Open the App",style:TextStyle(color: green,fontSize: 25,fontWeight: FontWeight.w700),)],));}}));} }
