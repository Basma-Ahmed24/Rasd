import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:rasd_app/src/features/User_side/projects/project_details.dart';
import '../../../core/localization/language_localization.dart';
import '../../../core/network/shared_preferences.dart';
import '../../../core/utils/constants.dart';
import '../../Admin_side/add_project_news/bloc/cubit.dart';
import '../complaints_form/screens/complaint_screen.dart';
import '../drawer/drawer_screen.dart';
import '../news/news_details.dart';
import '../profile/cubit.dart';
import '../profile/state.dart';

class HomeScreen extends StatelessWidget {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  var p,n;
  int? id;
  SwiperController _controller = SwiperController();
  int _i = 0;
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      create: (BuildContext context) {
        final cubit = UserCubit();
        cubit.getUserData(CacheHelper.getData(key: "apiToken"));
        cubit.getNewsData(); // Call another function here
        cubit.getProjrctData(); // Call yet another function here
        return cubit;
      },

    child: BlocConsumer<UserCubit, UserState>(
    listener: (context, state) {


    },
    builder: (context, state) {

    if (state is UserLoading) {
    return const Center(
    child: CircularProgressIndicator(color: green,),
    );
    } else if (state is UserLoaded) {
    final list1 = UserCubit.get(context).p;
    p=UserCubit.get(context).projects;
    n=UserCubit.get(context).n;
   UserCubit.get(context).func1();
   UserCubit.get(context).func2();

    return Scaffold(
                    key: scaffoldkey,
                    drawer: Navdrawer(),
                    backgroundColor: Primary,
                    body: Padding(
                        padding: EdgeInsets.only(top: 27),
                        child: SingleChildScrollView(
                          child: Column(children: [
                            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                              IconButton(
                                onPressed: () {
                                  scaffoldkey.currentState?.openDrawer();
                                },
                                icon: Icon(
                                  Icons.menu,
                                  size: 44,
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width / 5,),
                              Image.asset("assets/images/rasd 1.png", width: 128, height: 51,),
                              SizedBox(width: MediaQuery.of(context).size.width / 6,),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.notifications,
                                  size: 33,
                                ),
                              )
                            ]),
                            SizedBox(height: MediaQuery.of(context).size.height / 35,),
                           
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
                              ),
                              
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                  IconButton(
                      onPressed: () {
                        _controller.move(--_i % 3);
                        if(_i==-1)
                          _i=2;
                      },
                      icon: Icon(Icons.arrow_back_ios_sharp)),
                  InkWell(onTap: (){if(_i==0 ){ navigateto(context, ComplainsScreen(0));} else if(_i==1)navigateto(context, ComplainsScreen(1));else if(_i==2) navigateto(context, ComplainsScreen(2));},
                    child: Container(
                        constraints: BoxConstraints.expand(
                            height: MediaQuery.of(context).size.height / 4.2,
                            width: MediaQuery.of(context).size.width / 1.4),
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(10)),
                        child: complimantsSlider(context)),
                  ),
                  IconButton(
                      onPressed: () {
                        _controller.move(++_i % 3);
                        if(_i%3==0)
                          _i=0;

                      },
                      icon: Icon(Icons.arrow_forward_ios_rounded))
                ]),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),

                           news(context),

                            projects(context)
                            
                           ]),
            )));
   }else if (state is UserError&&state.errorMessage.contains("404")) {
      return Center(child:
      Container(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,color: Colors.white,child:
      Column(children: [Image.asset("assets/images/WhatsApp Image 2023-06-22 at 17.32.19.jpg",height: MediaQuery.of(context).size.height/2,width: MediaQuery.of(context).size.width,),
        Text("Oops!,there are some issues occur, we are working on it .",style:TextStyle(color: green,fontSize: 25,fontWeight: FontWeight.w700),)],)),);
    }else{return Container(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,color: Colors.white,child:
      Column(children: [Image.asset("assets/images/WhatsApp Image 2023-06-22 at 17.32.19.jpg",height: MediaQuery.of(context).size.height/2,width: MediaQuery.of(context).size.width,),
      Text("No Internet, Please Open Your Network and Re Open the App",style:TextStyle(color: green,fontSize: 25,fontWeight: FontWeight.w700),)],));}}));}
  var Images = [
    "assets/images/Rectangle 3.png",
    "assets/images/Rectangle 5.png",
    "assets/images/Rectangle 6.jpg",

  ];

  Swiper complimantsSlider(context) {
    return new Swiper(
      controller: _controller,
      fade: 0.1,
      itemCount: Images.length,
      scale: 0.6,
      viewportFraction: 0.4,
      itemBuilder: (BuildContext context, int index) {
        return new Image.asset(
          Images[index],
          fit: BoxFit.fitHeight,
        );
      },
    );
  }
  Widget news(context){
    if(n.length==1)
    return Column(children: [ Text(

        "${AppLocalizations.of(context)?.translate("latestnews")}",

        textAlign: TextAlign.center,

        style: TextStyle(

          fontWeight: FontWeight.w700,

          fontSize: 24,

          color: green,

          fontFamily: "Montserrat",

        )

    ),
      Divider(height: 10),

      InkWell(onTap: (){
        navigateto(context, NewsDetails(n[n.length-1]['proj_news_id']));
      },
        child: Container(width: MediaQuery.of(context).size.width/1.1,
          child:   Card(color: Primary,elevation: 5,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment:
          CrossAxisAlignment.center,
            children: [SizedBox(width: 10,), Column(
                children:[ Text(

                    "${n[n.length-1]['title']} ",

                    textAlign: TextAlign.center,

                    style: TextStyle(

                      fontWeight: FontWeight.w700,

                      fontSize: 18,

                      color: Colors.black45,

                      fontFamily: "Montserrat",

                    )

                ),
                  Text(

                      "${n[n.length-1]['start_date']} ",

                      textAlign: TextAlign.center,

                      style: TextStyle(

                        fontWeight: FontWeight.w700,

                        fontSize: 18,

                        color: Colors.black45,

                        fontFamily: "Montserrat",

                      )

                  ),
                ]  ),


              Container(width: MediaQuery.of(context).size.width/2, child: Container(height: 150,width: 150,child: Image.asset("assets/images/Rectangle 18 (1).png"))),
            ],
          ),),
        ),
      ),],);
    else if(n.length==2)
      return Column(children: [ Text(

          "${AppLocalizations.of(context)?.translate("latestnews")}",

          textAlign: TextAlign.center,

          style: TextStyle(

            fontWeight: FontWeight.w700,

            fontSize: 24,

            color: green,

            fontFamily: "Montserrat",

          )

      ),
        Divider(height: 10),

        InkWell(onTap: (){
          navigateto(context, NewsDetails(n[n.length-1]['proj_news_id']));

        },
          child: Container(width: MediaQuery.of(context).size.width/1.1,
            child:   Card(color: Primary,elevation: 5,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment:
            CrossAxisAlignment.center,
              children: [SizedBox(width: 10,), Column(
                  children:[ Text(

                      "${n[n.length-1]['title']} ",

                      textAlign: TextAlign.center,

                      style: TextStyle(

                        fontWeight: FontWeight.w700,

                        fontSize: 18,

                        color: Colors.black45,

                        fontFamily: "Montserrat",

                      )

                  ),
                    Text(

                        "${n[n.length-1]['start_date']} ",

                        textAlign: TextAlign.center,

                        style: TextStyle(

                          fontWeight: FontWeight.w700,

                          fontSize: 18,

                          color: Colors.black45,

                          fontFamily: "Montserrat",

                        )

                    ),
                  ]  ),


                Container(width: MediaQuery.of(context).size.width/2, child: Container(height: 150,width: 150,child: Image.asset("assets/images/Rectangle 18 (1).png"))),
              ],
            ),),
          ),
        ),
        Divider(height: 10),
        InkWell(onTap: (){        navigateto(context, NewsDetails(n[n.length-2]['proj_news_id']));
        },
          child: Container(width: MediaQuery.of(context).size.width/1.1,
            child:   Card(color: Primary,elevation: 5,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment:
            CrossAxisAlignment.center,
              children: [SizedBox(width: 10,), Column(
                  children:[ Text(

                      "${n[n.length-2]['title']} ",

                      textAlign: TextAlign.center,

                      style: TextStyle(

                        fontWeight: FontWeight.w700,

                        fontSize: 18,

                        color: Colors.black45,

                        fontFamily: "Montserrat",

                      )

                  ),
                    Text(

                        "${n[n.length-2]['start_date']} ",

                        textAlign: TextAlign.center,

                        style: TextStyle(

                          fontWeight: FontWeight.w700,

                          fontSize: 18,

                          color: Colors.black45,

                          fontFamily: "Montserrat",

                        )

                    ),
                  ]  ),


                Container(width: MediaQuery.of(context).size.width/2, child: Container(height: 150,width: 150,child: Image.asset("assets/images/Rectangle 18 (1).png"))),
              ],
            ),),
          ),
        )
      ],);
    else if(n.length==0)
      return Text("");
    else
      return Column(children: [ Text(

          "${AppLocalizations.of(context)?.translate("latestnews")}",

          textAlign: TextAlign.center,

          style: TextStyle(

            fontWeight: FontWeight.w700,

            fontSize: 22,

            color: green,

            fontFamily: "Montserrat",

          )

      ),
        Divider(height: 10),

        InkWell(onTap: (){        navigateto(context, NewsDetails(n[n.length-1]['proj_news_id']));
        },
          child: Container(width: MediaQuery.of(context).size.width/1.1,
            child:   Card(color: Primary,elevation: 5,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment:
            CrossAxisAlignment.center,
              children: [SizedBox(width: 10,), Column(
                  children:[ Text(

                      "${n[n.length-1]['title']} ",

                      textAlign: TextAlign.center,

                      style: TextStyle(

                        fontWeight: FontWeight.w700,

                        fontSize: 18,

                        color: Colors.black45,

                        fontFamily: "Montserrat",

                      )

                  ),
                    Text(

                        "${n[n.length-1]['start_date']} ",

                        textAlign: TextAlign.center,

                        style: TextStyle(

                          fontWeight: FontWeight.w700,

                          fontSize: 18,

                          color: Colors.black45,

                          fontFamily: "Montserrat",

                        )

                    ),
                  ]  ),


                Container(width: MediaQuery.of(context).size.width/2, child: Container(height: 150,width: 150,child: Image.asset("assets/images/Rectangle 18 (1).png"))),
              ],
            ),),
          ),
        ),
        Divider(height: 10),
        InkWell(onTap: (){        navigateto(context, NewsDetails(n[n.length-2]['proj_news_id']));
        },
          child: Container(width: MediaQuery.of(context).size.width/1.1,
            child:   Card(color: Primary,elevation: 5,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment:
            CrossAxisAlignment.center,
              children: [SizedBox(width: 10,), Column(
                  children:[ Text(

                      "${n[n.length-2]['title']} ",

                      textAlign: TextAlign.center,

                      style: TextStyle(

                        fontWeight: FontWeight.w700,

                        fontSize: 18,

                        color: Colors.black45,

                        fontFamily: "Montserrat",

                      )

                  ),
                    Text(

                        "${n[n.length-2]['start_date']} ",

                        textAlign: TextAlign.center,

                        style: TextStyle(

                          fontWeight: FontWeight.w700,

                          fontSize: 18,

                          color: Colors.black45,

                          fontFamily: "Montserrat",

                        )

                    ),
                  ]  ),


                Container(width: MediaQuery.of(context).size.width/2, child: Container(height: 150,width: 150,child: Image.asset("assets/images/Rectangle 18 (1).png"))),
              ],
            ),),
          ),
        ),
          Divider(height: 10),
    InkWell(onTap: (){        navigateto(context, NewsDetails(n[n.length-3]['proj_news_id']));
    },
      child: Container(width: MediaQuery.of(context).size.width/1.1,
      child:   Card(color: Primary,elevation: 5,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment:
      CrossAxisAlignment.center,
      children: [SizedBox(width: 10,), Column(
      children:[ Text(

      "${n[n.length-3]['title']} ",

      textAlign: TextAlign.center,

      style: TextStyle(

      fontWeight: FontWeight.w700,

      fontSize: 18,

      color: Colors.black45,

      fontFamily: "Montserrat",

      )

      ),
      Text(

      "${n[n.length-3]['start_date']} ",

      textAlign: TextAlign.center,

      style: TextStyle(

      fontWeight: FontWeight.w700,

      fontSize: 18,

      color: Colors.black45,

      fontFamily: "Montserrat",

      )

      ),
      ]  ),


      Container(width: MediaQuery.of(context).size.width/2,
      child: Container(height: 150,width: 150,child:
      Image.asset("assets/images/Rectangle 18 (1).png"))),
      ],
      ),),
      ),
    ),
      ],);

  }
  Widget projects(context){
    if(p.length==1)
      return Column(children: [ SizedBox(
        height: MediaQuery.of(context).size.height / 30,
      ),
        Text(

            "${AppLocalizations.of(context)?.translate("latestprojects")}",

            textAlign: TextAlign.center,

            style: TextStyle(

              fontWeight: FontWeight.w700,

              fontSize: 22,

              color: green,

              fontFamily: "Montserrat",

            )

        ),
        Divider(height: 10),
        InkWell(onTap: (){        navigateto(context, ProjectDetails(p[p.length-1]['proj_news_id']));
        },
          child: Container(width: MediaQuery.of(context).size.width/1.1,
            child:   Card(color: Primary,elevation: 5,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment:
            CrossAxisAlignment.center,
              children: [SizedBox(width: 10,), Column(
                  children:[ Text(

                      "${p[p.length-1]['title']} ",

                      textAlign: TextAlign.center,

                      style: TextStyle(

                        fontWeight: FontWeight.w700,

                        fontSize: 18,

                        color: Colors.black45,

                        fontFamily: "Montserrat",

                      )

                  ),
                    Text(

                        "${p[p.length-1]['start_date']} ",

                        textAlign: TextAlign.center,

                        style: TextStyle(

                          fontWeight: FontWeight.w700,

                          fontSize: 18,

                          color: Colors.black45,

                          fontFamily: "Montserrat",

                        )

                    ),

                  ]  ),


                Container(width: MediaQuery.of(context).size.width/2, child: Container(height: 150,width: 150,child: Image.asset("assets/images/Rectangle 25.png"))),
              ],
            ),),
          ),
        ),],); else if(p.length==0)
      return Text("");
    else if(p.length==2)
      return Column(children: [ SizedBox(
        height: MediaQuery.of(context).size.height / 30,
      ),
        Text(

            "${AppLocalizations.of(context)?.translate("latestprojects")}",

            textAlign: TextAlign.center,

            style: TextStyle(

              fontWeight: FontWeight.w700,

              fontSize: 22,

              color: green,

              fontFamily: "Montserrat",

            )

        ),
        Divider(height: 10),
        InkWell(onTap: (){   navigateto(context, ProjectDetails(p[p.length-1]['proj_news_id']));},
          child: Container(width: MediaQuery.of(context).size.width/1.1,
            child:   Card(color: Primary,elevation: 5,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment:
            CrossAxisAlignment.center,
              children: [SizedBox(width: 10,), Column(
                  children:[ Text(

                      "${p[p.length-1]['title']} ",

                      textAlign: TextAlign.center,

                      style: TextStyle(

                        fontWeight: FontWeight.w700,

                        fontSize: 18,

                        color: Colors.black45,

                        fontFamily: "Montserrat",

                      )

                  ),
                    Text(

                        "${p[p.length-1]['start_date']} ",

                        textAlign: TextAlign.center,

                        style: TextStyle(

                          fontWeight: FontWeight.w700,

                          fontSize: 18,

                          color: Colors.black45,

                          fontFamily: "Montserrat",

                        )

                    ),

                  ]  ),


                Container(width: MediaQuery.of(context).size.width/2, child: Container(height: 150,width: 150,child: Image.asset("assets/images/Rectangle 25.png"))),
              ],
            ),),
          ),
        ),
          Divider(height: 10),
    InkWell(onTap: (){
      navigateto(context, ProjectDetails(p[p.length-2]['proj_news_id']));
    },
      child: Container(width: MediaQuery.of(context).size.width/1.1,
      child:   Card(color: Primary,elevation: 5,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment:
      CrossAxisAlignment.center,
      children: [SizedBox(width: 10,), Column(
      children:[ Text(

      "${p[p.length-2]['title']} ",

      textAlign: TextAlign.center,

      style: TextStyle(

      fontWeight: FontWeight.w700,

      fontSize: 18,

      color: Colors.black45,

      fontFamily: "Montserrat",

      )

      ),
      Text(

      "${p[p.length-2]['start_date']} ",

      textAlign: TextAlign.center,

      style: TextStyle(

      fontWeight: FontWeight.w700,

      fontSize: 18,

      color: Colors.black45,

      fontFamily: "Montserrat",

      )

      ),

      ]  ),


      Container(width: MediaQuery.of(context).size.width/2, child: Container(height: 150,width: 150,child: Image.asset("assets/images/Rectangle 25.png"))),
      ],
      ),),
      ),
    ),]);
    else
      return Column(children: [ SizedBox(
        height: MediaQuery.of(context).size.height / 30,
      ),
        Text(

            "${AppLocalizations.of(context)?.translate("latestprojects")}",

            textAlign: TextAlign.center,

            style: TextStyle(

              fontWeight: FontWeight.w700,

              fontSize: 22,

              color: green,

              fontFamily: "Montserrat",

            )

        ),
        Divider(height: 10),
        InkWell(onTap: (){   navigateto(context, ProjectDetails(p[p.length-1]['proj_news_id']));},
          child: Container(width: MediaQuery.of(context).size.width/1.1,
            child:   Card(color: Primary,elevation: 5,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment:
            CrossAxisAlignment.center,
              children: [SizedBox(width: 10,), Column(
                  children:[ Text(

                      "${p[p.length-1]['title']} ",

                      textAlign: TextAlign.center,

                      style: TextStyle(

                        fontWeight: FontWeight.w700,

                        fontSize: 18,

                        color: Colors.black45,

                        fontFamily: "Montserrat",

                      )

                  ),
                    Text(

                        "${p[p.length-1]['start_date']} ",

                        textAlign: TextAlign.center,

                        style: TextStyle(

                          fontWeight: FontWeight.w700,

                          fontSize: 18,

                          color: Colors.black45,

                          fontFamily: "Montserrat",

                        )

                    ),

                  ]  ),


                Container(width: MediaQuery.of(context).size.width/2, child: Container(height: 150,width: 150,child: Image.asset("assets/images/Rectangle 25.png"))),
              ],
            ),),
          ),
        ),
        Divider(height: 10),
        InkWell(onTap: (){   navigateto(context, ProjectDetails(p[p.length-2]['proj_news_id']));},
          child: Container(width: MediaQuery.of(context).size.width/1.1,
            child:   Card(color: Primary,elevation: 5,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment:
            CrossAxisAlignment.center,
              children: [SizedBox(width: 10,), Column(
                  children:[ Text(

                      "${p[p.length-2]['title']} ",

                      textAlign: TextAlign.center,

                      style: TextStyle(

                        fontWeight: FontWeight.w700,

                        fontSize: 18,

                        color: Colors.black45,

                        fontFamily: "Montserrat",

                      )

                  ),
                    Text(

                        "${p[p.length-2]['start_date']} ",

                        textAlign: TextAlign.center,

                        style: TextStyle(

                          fontWeight: FontWeight.w700,

                          fontSize: 18,

                          color: Colors.black45,

                          fontFamily: "Montserrat",

                        )

                    ),
                  ]  ),


                Container(width: MediaQuery.of(context).size.width/2, child: Container(height: 150,width: 150,child: Image.asset("assets/images/Rectangle 25.png"))),
              ],
            ),),
          ),
        ),
        Divider(height: 10),
        InkWell(onTap: (){   navigateto(context, ProjectDetails(p[p.length-3]['proj_news_id']));},
          child: Container(width: MediaQuery.of(context).size.width/1.1,
            child:   Card(color: Primary,elevation: 5,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment:
            CrossAxisAlignment.center,
              children: [SizedBox(width: 10,), Column(
                  children:[ Text(

                      "${p[p.length-3]['title']} ",

                      textAlign: TextAlign.center,

                      style: TextStyle(

                        fontWeight: FontWeight.w700,

                        fontSize: 18,

                        color: Colors.black45,

                        fontFamily: "Montserrat",

                      )

                  ),
                    Text(

                        "${p[p.length-3]['start_date']} ",

                        textAlign: TextAlign.center,

                        style: TextStyle(

                          fontWeight: FontWeight.w700,

                          fontSize: 18,

                          color: Colors.black45,

                          fontFamily: "Montserrat",

                        )

                    ),

                  ]  ),


                Container(width: MediaQuery.of(context).size.width/2, child: Container(height: 150,width: 150,child: Image.asset("assets/images/Rectangle 25.png"))),
              ],
            ),),
          ),
        )
      ]);

  }

}
