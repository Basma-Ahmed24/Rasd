import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rasd_app/main.dart';
import 'package:rasd_app/src/core/localization/language_state.dart';
import 'package:rasd_app/src/features/Admin_side/complaints/bloc/Updatestatus.dart';
import 'package:rasd_app/src/features/Admin_side/complaints/bloc/state.dart';
import 'package:rasd_app/src/features/Admin_side/complaints/complaint%20card.dart';
import 'package:rasd_app/src/features/Admin_side/home/home_screen.dart';
import 'package:rasd_app/src/features/User_side/complaints_form/bloc/cubit.dart';
import 'package:rasd_app/src/features/User_side/settings/settings_screen.dart';

import '../../../core/localization/bloc.dart';
import '../../../core/localization/language_localization.dart';
import '../../../core/network/shared_preferences.dart';
import '../../../core/utils/constants.dart';
import '../../User_side/complaints_form/bloc/ComplaintModel.dart';
import '../../User_side/drawer/drawer_screen.dart';

import 'bloc/cubit.dart';

class Complaints extends StatelessWidget {
  var list1,loc;
  final scaffoldkey1 = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final currentlang=Localizations.localeOf(context);

    return BlocProvider(
        create: (BuildContext context) =>
        ComplaintsCubit()..getComplaintsData(),
        child: BlocConsumer<ComplaintsCubit, ComplaintsState>(
            listener: (context, state) {},
            builder: (context, state) {
    if (state is ComplaintLoading) {
  return Scaffold(body: 
  Center(child: CircularProgressIndicator(color: green,)));}
              if (state is ComplaintLoaded) {
   list1 = ComplaintsCubit.get(context).p;
//              ComplaintsCubit.get(context).func(list1, currentlang.languageCode);
// list1=ComplaintsCubit.get(context).t;
                print(list1);
                return Scaffold(
                    key: scaffoldkey1,
                    drawer: Navdrawer(),
                    backgroundColor: Primary,
                    body: Padding(
                        padding:
                        EdgeInsets.only(top: 40, left: 20, right: 20),
                        child: SingleChildScrollView(
                            child: Column(children: [
                              Row(children: [
                                IconButton(
                                  onPressed: () {
                                    scaffoldkey1.currentState?.openDrawer();
                                  },
                                  icon: Icon(
                                    Icons.menu,
                                    size: 40,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                  MediaQuery.of(context).size.width / 5,
                                ),
                                Image.asset(
                                  "assets/images/rasd 1.png",
                                  width: 128,
                                  height: 51,
                                ),
                              ]),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 28,
                              ),
                              Center(
                                  child: Text("${AppLocalizations.of(context)?.translate("complaints")} ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 24,
                                        color: green,
                                        fontFamily: "Montserrat",
                                      ))),SizedBox(height: 10,),
Container(height: MediaQuery.of(context).size.height/1.25,width: MediaQuery.of(context).size.width,child:
list1!=null?
                                ConditionalBuilder(
                                    condition: state is! ComplaintLoading,
                                    builder: (context) =>ListView.separated(
                                      itemBuilder: (context, index) =>ComplaintCard(list1, context, index),

                                      separatorBuilder: (context, index) =>
                                          Divider(),
                                      itemCount:
                                      ComplaintsCubit.get(context).p.length,
                                    ),
                                    fallback: (context) =>
                                        Center(child: CircularProgressIndicator())):Center(
child: Container(height: MediaQuery.of(context).size.height,width:
                MediaQuery.of(context).size.width,color: Colors.white,child: Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      children:[Image.asset("assets/images/no-data.png"), Text("No Complaints Yet! ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                            color: green,
                            fontFamily: "Montserrat",
                          )),
                      ]  ),
                ),),
              ),

)]))));
              } else if (state is ComplaintsError&&state.errorMessage.contains("404")) {
                return Center(child:
                Container(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,color: Colors.white,child:
                Column(children: [Image.asset("assets/images/WhatsApp Image 2023-06-22 at 17.32.19.jpg",height: MediaQuery.of(context).size.height/2,width: MediaQuery.of(context).size.width,),
                  Text("Oops!,there are some issues occur, we are working on it .",style:TextStyle(color: green,fontSize: 25,fontWeight: FontWeight.w700),)],)),);
              }else{return Container(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,color: Colors.white,child:
              Column(children: [Image.asset("assets/images/WhatsApp Image 2023-06-22 at 17.32.19.jpg",height: MediaQuery.of(context).size.height/2,width: MediaQuery.of(context).size.width,),
              Text("No Internet, Please Open Your Network and Re Open the App",style:TextStyle(color: green,fontSize: 25,fontWeight: FontWeight.w700),)],

              ));}
            }));
  }void _onUploadPressed(BuildContext context,String status,int id) async {

    final complaint = Updatestatus(
        userId: CacheHelper.getData(key: "apiToken")
        ,complaintId: id,
        status: status
    );

    await context.read<ComplaintsCubit>().updateStatus(complaint);


  }

}
