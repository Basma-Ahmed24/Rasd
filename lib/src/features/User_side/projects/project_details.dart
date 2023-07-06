import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasd_app/src/core/utils/constants.dart';

import '../../Admin_side/add_project_news/bloc/cubit.dart';
import '../../Admin_side/add_project_news/bloc/state.dart';
import '../../../core/localization/language_localization.dart';
class ProjectDetails extends StatelessWidget{
  @override
  int? id ;
  var data;
  ProjectDetails(int id){
    this.id=id;
  }
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
        create: (BuildContext context) =>
        ProjNewsCubit()..getProjrctDataWithId(id!),
        child: BlocConsumer<ProjNewsCubit, ProjNewsState>(
        listener: (context, state) {},
    builder: (context, state) {
      if (state is projnewsLoading) {
        return Scaffold(body:
        Center(child: CircularProgressIndicator(color: green,)));}
    if (state is projnewsLoaded) {
    data = ProjNewsCubit.get(context).project;
    converter();
    print(data);return Scaffold(
      backgroundColor: Primary,
      body:
      Padding(padding: EdgeInsets.all(10),child: SingleChildScrollView(child: Column(children: [
        SizedBox(height: MediaQuery.of(context).size.height/15,),
        Row(children:[ IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_sharp))]),

        Center(child: Image.asset("assets/images/Rectangle 25.png")),
        SizedBox(height: MediaQuery.of(context).size.height/30,),
        Text(data[0]['title'],textAlign: TextAlign.center,

            style: TextStyle(

              fontWeight: FontWeight.w700,

              fontSize: 22,

              color: green,

              fontFamily: "Montserrat",

            )),
        SizedBox(height: MediaQuery.of(context).size.height/40,),

        Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children:
        [Text("${AppLocalizations.of(context)?.translate("startdate")}", style: TextStyle(

            fontWeight: FontWeight.w700,

            fontSize: 18,

            color: green,

            fontFamily: "Montserrat",

          )

      ),
          Text(data[0]['start_date'],textAlign: TextAlign.center,

              style: TextStyle(

                fontWeight: FontWeight.w700,

                fontSize: 18,

                color: Colors.black45,

                fontFamily: "Montserrat",

              )),  ],),
        SizedBox(height: MediaQuery.of(context).size.height/40,),

        Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children:
        [Text("${AppLocalizations.of(context)?.translate("enddate")}", style: TextStyle(

          fontWeight: FontWeight.w700,

          fontSize: 18,

          color: green,

          fontFamily: "Montserrat",

        )

        ),
          Text(data[0]['end_date'],textAlign: TextAlign.center,

              style: TextStyle(

                fontWeight: FontWeight.w700,

                fontSize: 18,

                color: Colors.black45,

                fontFamily: "Montserrat",

              )),  ]) ,        SizedBox(height: MediaQuery.of(context).size.height/40,),

          Text("${AppLocalizations.of(context)?.translate("location")}", style: TextStyle(

            fontWeight: FontWeight.w700,

            fontSize: 18,

            color: green,

            fontFamily: "Montserrat",

          )

          ),
            Text(data[0]['location'],textAlign: TextAlign.center,

                style: TextStyle(

                  fontWeight: FontWeight.w700,

                  fontSize: 18,

                  color: Colors.black45,

                  fontFamily: "Montserrat",

                )) ,
       // SizedBox(height: MediaQuery.of(context).size.height/40,),
        // Text("${AppLocalizations.of(context)?.translate("organization")}", style: TextStyle(
        //
        //   fontWeight: FontWeight.w700,
        //
        //   fontSize: 18,
        //
        //   color: green,
        //
        //   fontFamily: "Montserrat",
        //
        // )
        //
        // ),
        // Text(data[0]['organization'],textAlign: TextAlign.center,
        //
        //     style: TextStyle(
        //
        //       fontWeight: FontWeight.w700,
        //
        //       fontSize: 18,
        //
        //       color: Colors.black45,
        //
        //       fontFamily: "Montserrat",
        //
        //     )) ,
        // SizedBox(height: MediaQuery.of(context).size.height/40,),
        // Text("${AppLocalizations.of(context)?.translate("budget")}", style: TextStyle(
        //
        //   fontWeight: FontWeight.w700,
        //
        //   fontSize: 18,
        //
        //   color: green,
        //
        //   fontFamily: "Montserrat",
        //
        // )
        //
        // ),
        // Text(data[0]['proj_budget'],textAlign: TextAlign.center,
        //
        //     style: TextStyle(
        //
        //       fontWeight: FontWeight.w700,
        //
        //       fontSize: 18,
        //
        //       color: Colors.black45,
        //
        //       fontFamily: "Montserrat",
        //
        //     )) ,
        SizedBox(height: MediaQuery.of(context).size.height/40,),

        Text("${AppLocalizations.of(context)?.translate("describe")}", style: TextStyle(

          fontWeight: FontWeight.w700,

          fontSize: 18,

          color: green,

          fontFamily: "Montserrat",

        )

        ),
        Text(data[0]['description'],textAlign: TextAlign.center,

            style: TextStyle(

              fontWeight: FontWeight.w700,

              fontSize: 18,

              color: Colors.black45,

              fontFamily: "Montserrat",

            )) ,
      ],))),
    );
  }else if (state is projnewsError&&state.errorMessage.contains("404")) {
      return Center(child:
      Container(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,color: Colors.white,child:
      Column(children: [Image.asset("assets/images/WhatsApp Image 2023-06-22 at 17.32.19.jpg",height: MediaQuery.of(context).size.height/2,width: MediaQuery.of(context).size.width,),
        Text("Oops!,there are some issues occur, we are working on it .",style:TextStyle(color: green,fontSize: 25,fontWeight: FontWeight.w700),)],)),);
    }else{return Container(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,color: Colors.white,child:
    Column(children: [Image.asset("assets/images/WhatsApp Image 2023-06-22 at 17.32.19.jpg",height: MediaQuery.of(context).size.height/2,width: MediaQuery.of(context).size.width,),
      Text("No Internet, Please Open Your Network and Re Open the App",style:TextStyle(color: green,fontSize: 25,fontWeight: FontWeight.w700),)],));}}));}
  void converter(){
    for(int i=0;i<data.length;i++){

      data[i]["start_date"]=data[i]["start_date"]?.substring(0,10);
      data[i]["end_date"]=data[i]["end_date"]?.substring(0,10);
    }}
}