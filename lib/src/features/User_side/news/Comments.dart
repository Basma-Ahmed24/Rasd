import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasd_app/src/core/utils/constants.dart';

import '../../Admin_side/add_project_news/bloc/cubit.dart';
import '../../Admin_side/add_project_news/bloc/state.dart';
import '../../../core/localization/language_localization.dart';
import '../sign_up/sign_up_screen.dart';
class Comments extends StatelessWidget{
  @override
  int? id ;
  var data;
  Comments(int id){
    this.id=id;
  }
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
        create: (BuildContext context) =>
        ProjNewsCubit()..getAllComments(id!),
        child: BlocConsumer<ProjNewsCubit, ProjNewsState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is projnewsLoading) {
                return Scaffold(body:
                Center(child: CircularProgressIndicator(color: green,)));}
              if (state is projnewsLoaded) {

                data = ProjNewsCubit.get(context).comments;
date();
                print(data);return Scaffold(
                  backgroundColor: Primary,
                  body:
                  Padding(padding: EdgeInsets.all(10),child:
                  Column(children: [
                    SizedBox(height: MediaQuery.of(context).size.height/15,),
                    Row(children:[ IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_sharp))]),

                    Text("${AppLocalizations.of(context)?.translate("Comments")}", style: TextStyle(

                      fontWeight: FontWeight.w700,
                      fontSize: 22,

                      color: green,

                      fontFamily: "Montserrat",

                    )

                    ), ConditionalBuilder(
                        condition: state is! projnewsLoading,
                        builder: (context) =>data!=null?Expanded(
                          child: ListView.separated(
                     itemBuilder: (context, index) => Card(
                      color: Colors.white,
                      child: 
                      Column(
                        children:[ Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "${data[index]["fname"]} ${data[index]["lname"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: green,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                              Text(
                                "${data[index]["date_time"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Colors.black26,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ],
                        ),
                          data[index]["comment_body"]!=null?
                          Text(
                            "${data[index]["comment_body"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Colors.black45,
                              fontFamily: "Montserrat",
                            ),
                          ):Text("no comments") ] ),
                    ),


                    separatorBuilder: (context, index) =>
                                Divider(),
                            itemCount:
                           data.length,
                          ),
                        ):Column(children:[SizedBox(height: MediaQuery.of(context).size.height/4,), Image.asset("assets/images/no-data.png")]),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()))
                    ],)),
                );
              }else if (state is projnewsError&&state.errorMessage.contains("404")) {
                return Center(child:
                Container(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,color: Colors.white,child:
                Column(children: [Image.asset("assets/images/WhatsApp Image 2023-06-22 at 17.32.19.jpg",height: MediaQuery.of(context).size.height/2,width: MediaQuery.of(context).size.width,),
                  Text("Oops!,there are some issues occur, we are working on it .",style:TextStyle(color: green,fontSize: 25,fontWeight: FontWeight.w700),)],)),);
              }else{return Container(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,color: Colors.white,child:
              Column(children: [Image.asset("assets/images/WhatsApp Image 2023-06-22 at 17.32.19.jpg",height: MediaQuery.of(context).size.height/2,width: MediaQuery.of(context).size.width,),
                Text("No Internet, Please Open Your Network and Re Open the App",style:TextStyle(color: green,fontSize: 25,fontWeight: FontWeight.w700),)],));}}));
  }void date(){
    if(data!=null){
    for(int i=0;i<data.length;i++){
      data[i]["date_time"]=data[i]["date_time"].substring(0,10);
    }
  }}
}