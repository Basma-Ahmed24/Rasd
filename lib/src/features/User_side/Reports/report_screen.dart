import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:rasd_app/src/core/utils/constants.dart';
import 'package:rasd_app/src/features/User_side/complaints_form/bloc/state.dart';

import '../../../core/localization/language_localization.dart';
import '../complaints_form/bloc/cubit.dart';
import '../drawer/drawer_screen.dart';

class ReportScreen extends StatelessWidget {
  @override
  final scaffoldkey = GlobalKey<ScaffoldState>();
var list1;
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
        create: (BuildContext context) =>
        ComplaintCubit()
          ..getComplaintsCount(),
        child: BlocConsumer<ComplaintCubit, ComplaintState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state.isLoading) {
                return Scaffold(body:
                Center(child: CircularProgressIndicator(color: green,)));}
              if (state.isSuccess) {
                list1 = ComplaintCubit
                    .get(context)
                    .data;
function();
                print(list1);
                return Scaffold(
                    backgroundColor: Primary,
                    key: scaffoldkey,
                    drawer: Navdrawer(),
                    body: Padding(
                        padding: EdgeInsets.all(22),
                        child: SingleChildScrollView(
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    scaffoldkey.currentState?.openDrawer();
                                  },
                                  icon: Icon(
                                    Icons.menu,
                                    size: 44,
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 8,
                                ),
                                Center(
                                  child: Image.asset(
                                    "assets/images/rasd 1.png",
                                    width: 128,
                                    height: 51,
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 8,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.notifications,
                                    size: 33,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 28,
                            ),
                            Row(children: [
                              SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 3,
                              )
                            ]),
                            Text("${AppLocalizations.of(context)?.translate(
                                "reports")} ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 32,
                                  color: green,
                                  fontFamily: "Montserrat",
                                )),
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 15,
                            ),
                            CircularPercentIndicator(radius: 90,
                              progressColor: green,
                              percent: 1,
                              lineWidth: 8,
                              center: Text("${ComplaintCubit.get(context).totalComplaint}", style: TextStyle(
                                  color: green,
                                  fontSize: 48,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold
                              ),),)
                            ,
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 35,
                            ),
                            Text("${AppLocalizations.of(context)?.translate(
                                "allcomplaint")}", style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold
                            )),
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 30,),
                            InkWell(onTap: () {},
                              child: Container(height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 7.5, width: MediaQuery
                                  .of(context)
                                  .size
                                  .width, decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: green,),
                                child: Center(child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [pending!=0?
                                    Text("${pending} ${AppLocalizations.of(context)
                                        ?.translate("pending")}",
                                      style: TextStyle(fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Montserrat"),):Text("${pending} ${AppLocalizations.of(context)
                                      ?.translate("pending")}",
                                    style: TextStyle(fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Montserrat"),),

                                  ],),),),
                            ),
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 15,
                            ),
                            Row(children: [SizedBox(width: 15,),pending!=0? Text(
                                "${AppLocalizations.of(context)?.translate(
                                    "progress")} ${pending}%", style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600
                            )):Text(
                                "${AppLocalizations.of(context)?.translate(
                                    "progress")} ${pending}%", style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600
                            ))
                            ]),
                            SizedBox(height: 10,),
                            LinearPercentIndicator(progressColor: green,
                              percent: pending!=0? (pending)/(ComplaintCubit.get(context).totalComplaint).toDouble():0.0,
                              lineHeight: 15,
                              barRadius: Radius.circular(10),
                              backgroundColor: Colors.white,),
                            SizedBox(height: 10,),
                            Row(crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [SizedBox(width: 15,), completed!=0 ?Text(
                                    "${completed}${AppLocalizations.of(context)?.translate(
                                        "complete")}", style: TextStyle(
                                    color: green,
                                    fontSize: 16,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w400
                                )):Text(
                                    "${completed} ${AppLocalizations.of(context)?.translate(
                                        "complete")}", style: TextStyle(
                                    color: green,
                                    fontSize: 16,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w400
                                ))
                                ])
                          ]),
                        )));
              } else if (
                 state.errorMessage != null) {
                return Center(child:
                Container(height: MediaQuery
                    .of(context)
                    .size
                    .height, width: MediaQuery
                    .of(context)
                    .size
                    .width, color: Colors.white, child:
                Column(children: [
                  Image.asset(
                    "assets/images/WhatsApp Image 2023-06-22 at 17.32.19.jpg",
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 2, width: MediaQuery
                      .of(context)
                      .size
                      .width,),
                  Text(
                    "Oops!,there are some issues occur, we are working on it .",
                    style: TextStyle(color: green,
                        fontSize: 25,
                        fontWeight: FontWeight.w700),)
                ],)),);
              } else{return Container(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,color: Colors.white,child:
              Column(children: [Image.asset("assets/images/WhatsApp Image 2023-06-22 at 17.32.19.jpg",height: MediaQuery.of(context).size.height/2,width: MediaQuery.of(context).size.width,),
                Text("No Internet, Please Open Your Network and Re Open the App",style:TextStyle(color: green,fontSize: 25,fontWeight: FontWeight.w700),)],));}}));}
int pending=0;
int completed=0;
void function(){
  for(int i=0;i<list1.length;i++){
    if (list1[i]["status"]=="completed")
      completed=list1[i]["count"];
    else if(list1[i]["status"]=="pending")
      pending=list1[i]["count"];
  }

}}