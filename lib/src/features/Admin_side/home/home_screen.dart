import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasd_app/src/features/Admin_side/add_project_news/screens/add_news.dart';
import 'package:rasd_app/src/features/Admin_side/home/widgets.dart';
import 'package:rasd_app/src/features/User_side/complaints_form/screens/complaint_screen.dart';
import 'package:rasd_app/src/features/User_side/news/news_screen.dart';

import '../../../core/localization/language_localization.dart';
import '../../../core/network/shared_preferences.dart';
import '../../../core/utils/constants.dart';
import '../../User_side/drawer/drawer_screen.dart';
import '../../User_side/profile/cubit.dart';
import '../../User_side/profile/state.dart';
import '../add_project_news/screens/add_project.dart';
import '../complaints/complaints.dart';

class AdminHome extends StatelessWidget{
  @override
  String ?error;

  final scaffoldkey1 = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
        create: (BuildContext context) => UserCubit()..getUserData(CacheHelper.getData(key: "apiToken")),
        child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {},
    builder: (context, state) {

    if (state is UserLoading) {
    return const Center(
    child: CircularProgressIndicator(color: green,),
    );
    } else if (state is UserLoaded) {
    final list1 = UserCubit.get(context).p;
    return Scaffold(
        key: scaffoldkey1,
        drawer: Navdrawer(),

    backgroundColor: Primary,
    body: Padding(
    padding: EdgeInsets.only(top: 40,left: 20,right: 20),
    child: SingleChildScrollView(
    child: Column(children: [


        Row( children: [
          IconButton(
            onPressed: () {
              scaffoldkey1.currentState?.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              size: 40,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 5,),
          Image.asset("assets/images/rasd 1.png", width: 128, height: 51,),])
    
,
    SizedBox(height: MediaQuery.of(context).size.height / 28,),

    Center(
    child: Text(
    "${AppLocalizations.of(context)?.translate("hello")} ${list1['fname'] ?? ''} ",
    textAlign: TextAlign.center,
    style: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 24,
    color: green,
    fontFamily: "Montserrat",
    )
    ),
    ), SizedBox(height: MediaQuery.of(context).size.height / 20,),

      Button("${AppLocalizations.of(context)?.translate("complaints")}", Complaints(), context),
      SizedBox(height: MediaQuery.of(context).size.height / 20,),

      Button("${AppLocalizations.of(context)?.translate("addnews")}", AddNews(), context),
      SizedBox(height: MediaQuery.of(context).size.height / 20,),

      Button("${AppLocalizations.of(context)?.translate("add Project")}", AddProjectScreen(), context),
      SizedBox(height: MediaQuery.of(context).size.height / 20,),

]))));
    } else if (state is UserError&&state.errorMessage.contains("404")) {
      return Center(child:
      Container(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,color: Colors.white,child:
      Column(children: [Image.asset("assets/images/WhatsApp Image 2023-06-22 at 17.32.19.jpg",height: MediaQuery.of(context).size.height/2,width: MediaQuery.of(context).size.width,),
      Text("Oops!,there are some issues occur, we are working on it .",style:TextStyle(color: green,fontSize: 25,fontWeight: FontWeight.w700),)],)),);
    }else{return Container(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,color: Colors.white,child:
    Column(children: [Image.asset("assets/images/WhatsApp Image 2023-06-22 at 17.32.19.jpg",height: MediaQuery.of(context).size.height/2,width: MediaQuery.of(context).size.width,),
      Text("No Internet, Please Open Your Network and Re Open the App",style:TextStyle(color: green,fontSize: 25,fontWeight: FontWeight.w700),)],));}}));}}
