import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasd_app/src/core/utils/constants.dart';

import '../../Admin_side/add_project_news/bloc/cubit.dart';
import '../../Admin_side/add_project_news/bloc/state.dart';
import '../../../core/localization/language_localization.dart';
import '../sign_up/sign_up_screen.dart';
import 'Comments.dart';

class NewsDetails extends StatelessWidget {
  @override
  int? id;
  var data;
  var commentController = TextEditingController();
  NewsDetails(int id) {
    this.id = id;
  }
  Widget build(BuildContext context) {
    // TODO: implement build
    final currentlang = Localizations.localeOf(context);
    return BlocProvider(
        create: (BuildContext context) =>
            ProjNewsCubit()..getNewsDataWithId(id!, currentlang.languageCode),
        child: BlocConsumer<ProjNewsCubit, ProjNewsState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is projnewsLoading) {
                return Scaffold(
                    body: Center(
                        child: CircularProgressIndicator(
                  color: green,
                )));
              }
              if (state is projnewsLoaded) {
                data = ProjNewsCubit.get(context).news;
                converter();
                print(data);
                return Scaffold(
                  backgroundColor: Primary,
                  body: Padding(
                      padding: EdgeInsets.all(10),
                      child: SingleChildScrollView(
                          child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 15,
                          ),
                          Row(children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.arrow_back_ios_sharp))
                          ]),
                          Center(
                              child: Container(height: MediaQuery.of(context).size.height/3,width: MediaQuery.of(context).size.width/1.2,
                                child:data[0]["img"]!=null? CachedNetworkImage(imageUrl: "http://18.197.86.8/image/fetch_image?file_path=${data[0]["img"]}",fit: BoxFit.fill,
                                ):Image.asset("assets/images/Rectangle 18 (1).png"),
                              )),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 30,
                          ),
                          data[0]['title'] != null
                              ? Text(data[0]['title'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22,
                                    color: green,
                                    fontFamily: "Montserrat",
                                  ))
                              : Text("No Title",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22,
                                    color: green,
                                    fontFamily: "Montserrat",
                                  )),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                  "${AppLocalizations.of(context)?.translate("startdate")}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: green,
                                    fontFamily: "Montserrat",
                                  )),
                              Text(data[0]['start_date'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.black45,
                                    fontFamily: "Montserrat",
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 40,
                          ),
                          Text(
                              "${AppLocalizations.of(context)?.translate("location")}",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: green,
                                fontFamily: "Montserrat",
                              )),
                          Text(data[0]['location'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Colors.black45,
                                fontFamily: "Montserrat",
                              )),
                          SizedBox(height: MediaQuery.of(context).size.height/40,),
                          Text("${AppLocalizations.of(context)?.translate("district")}", style: TextStyle(

                            fontWeight: FontWeight.w700,

                            fontSize: 18,

                            color: green,

                            fontFamily: "Montserrat",

                          )

                          ),
                          data[0]['district_string']!=null?Text(data[0]['district_string'],textAlign: TextAlign.center,

                              style: TextStyle(

                                fontWeight: FontWeight.w700,

                                fontSize: 18,

                                color: Colors.black45,

                                fontFamily: "Montserrat",

                              )) :Text("No district added"),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 40,
                          ),
                          
                          Text(
                              "${AppLocalizations.of(context)?.translate("describe")}",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: green,
                                fontFamily: "Montserrat",
                              )),
                          data[0]['description'] != null
                              ? Text(data[0]['description'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.black45,
                                    fontFamily: "Montserrat",
                                  ))
                              : Text("No Description"),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  context.read<ProjNewsCubit>().PostComment(
                                      data[0]['proj_news_id'],
                                      null,
                                      commentController.text);
                                  print(commentController.text);
                                  commentController.text = "";
                                },
                                child: Center(
                                  child: Text(
                                      "${AppLocalizations.of(context)?.translate("addcomment")}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: green,
                                        fontFamily: "Montserrat",
                                      )),
                                ),
                              ),
                              Container(
                                height: 35,
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black26, // set border color
                                    width: 2, // set border width
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: TextField(
                                  controller: commentController,

                                  // align the hint text to the right
                                  textAlignVertical: TextAlignVertical.bottom,
                                  // align the hint text to the bottom
                                  decoration: InputDecoration(
                                    hintText:
                                        '${AppLocalizations.of(context)?.translate("addcomment")}',
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black26),
                                    // set the hint text

                                    contentPadding: EdgeInsets.only(
                                        bottom:
                                            10), // set content padding to move the text to the bottom
                                  ),
                                  cursorHeight:
                                      20, // set the height of the cursor to move it to the bottom
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 40,
                          ),
                          InkWell(
                            onTap: () {
                              navigateto(
                                  context, Comments(data[0]['proj_news_id']));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 20,
                              color: green,
                              child: Center(
                                child: Text(
                                    "${AppLocalizations.of(context)?.translate("showallcomments")}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontFamily: "Montserrat",
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ))),
                );
              } else if (state is projnewsError &&
                  state.errorMessage.contains("404")) {
                return Center(
                  child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/WhatsApp Image 2023-06-22 at 17.32.19.jpg",
                            height: MediaQuery.of(context).size.height / 2,
                            width: MediaQuery.of(context).size.width,
                          ),
                          Text(
                            "Oops!,there are some issues occur, we are working on it .",
                            style: TextStyle(
                                color: green,
                                fontSize: 25,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      )),
                );
              } else {
                return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/WhatsApp Image 2023-06-22 at 17.32.19.jpg",
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Text(
                          "No Internet, Please Open Your Network and Re Open the App",
                          style: TextStyle(
                              color: green,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ));
              }
            }));
  }

  void converter() {
    for (int i = 0; i < data.length; i++) {
      data[i]["start_date"] = data[i]["start_date"]?.substring(0, 10);
    }
  }
}
