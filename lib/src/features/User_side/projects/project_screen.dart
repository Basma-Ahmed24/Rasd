import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:rasd_app/src/features/User_side/projects/project_details.dart';

import '../../../core/localization/language_localization.dart';
import '../../../core/utils/constants.dart';
import '../../Admin_side/add_project_news/bloc/cubit.dart';
import '../../Admin_side/add_project_news/bloc/state.dart';
import '../drawer/drawer_screen.dart';

class ProjectScreen extends StatelessWidget {
  @override
  final scaffoldkey = GlobalKey<ScaffoldState>();
  SwiperController _controller = SwiperController();
var list1;
  int _i = 0;
  Widget build(BuildContext context) {
    // TODO: implement build
    final currentlang=Localizations.localeOf(context);

    return  BlocProvider(
        create: (BuildContext context) =>
        ProjNewsCubit()..getProjrctData(currentlang.languageCode),
        child: BlocConsumer<ProjNewsCubit, ProjNewsState>(
        listener: (context, state) {},
    builder: (context, state) {
      if (state is projnewsLoading) {
        return Scaffold(body:
        Center(child: CircularProgressIndicator(color: green,)));}
    if (state is projnewsLoaded) {
    list1 = ProjNewsCubit.get(context).projects;
    func();
    print(list1);
    return Scaffold(
        key: scaffoldkey,
        drawer: Navdrawer(),
        backgroundColor: Primary,
        body: Padding(
            padding: EdgeInsets.all(22),
            child: SingleChildScrollView(
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      width: MediaQuery.of(context).size.width / 8,
                    ),
                    Center(
                      child: Image.asset(
                        "assets/images/rasd 1.png",
                        width: 128,
                        height: 51,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 8,
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
                  height: MediaQuery.of(context).size.height / 28,
                ),
                Row(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                  )
                ]),
                Text("${AppLocalizations.of(context)?.translate("cprojects")}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                      color: green,
                      fontFamily: "Montserrat",
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                ),
                SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/1.5 ,
                    child:list1!=null? Stack(
                        children: [

                          detailsSlider(context),
                          Positioned(
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                              IconButton(
                                  onPressed: () {
                                    _controller.move(--_i %  list1.length as int);
                                  },
                                  icon: Icon(Icons.arrow_back_ios_sharp)), Container(

                                  height: MediaQuery.of(context).size.height / 5,
                                  width: MediaQuery.of(context).size.width / 1.65,
                                  decoration:
                                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                  child: complimantsSlider(context)),
                              IconButton(
                                  onPressed: () {
                                    _controller.move(++_i %  list1.length as int);
                                  },
                                  icon: Icon(Icons.arrow_forward_ios_rounded))]
                            ),
                          ),
                        ]):Image.asset("assets/images/no-data.png"),
                  ),
                ),SizedBox(height: MediaQuery.of(context).size.height/30,),
              ]),
            )));
  }else if (state is projnewsError&&state.errorMessage.contains("404")) {
      return Center(child:
      Container(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,color: Colors.white,child:
      Column(children: [Image.asset("assets/images/WhatsApp Image 2023-06-22 at 17.32.19.jpg",height: MediaQuery.of(context).size.height/2,width: MediaQuery.of(context).size.width,),
        Text("Oops!,there are some issues occur, we are working on it .",style:TextStyle(color: green,fontSize: 25,fontWeight: FontWeight.w700),)],)),);
    }else{return Container(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,color: Colors.white,child:
    Column(children: [Image.asset("assets/images/WhatsApp Image 2023-06-22 at 17.32.19.jpg",height: MediaQuery.of(context).size.height/2,width: MediaQuery.of(context).size.width,),
      Text("No Internet, Please Open Your Network and Re Open the App",style:TextStyle(color: green,fontSize: 25,fontWeight: FontWeight.w700),)],));}}));}
  Swiper complimantsSlider(BuildContext context) {
    return Swiper(
      controller: _controller,
      fade: 0.1,
      itemCount: list1.length,
      scale: 0,
      viewportFraction: 1,
      itemBuilder: (BuildContext context, int index) {
        if (list1[index]["img"] != null) {
          return CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl:
            "http://18.197.86.8/image/fetch_image?file_path=${list1[index]["img"]}",
          );
        } else {
          return Image.asset("assets/images/Rectangle 25.png");
        }
      },
    );
  }
  Swiper detailsSlider(context) {
    return new Swiper(
      controller: _controller,
      fade: 0.1,
      itemCount: list1.length,
      scale: 0,
      viewportFraction: 1,
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: [
            Positioned(
              top: 100,
              left: 8,
              child: Align(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.height / 2,
                  child:
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffD9D9D9),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 8,
                          ),
                          Center(
                            child:list1[index]["title"]!=null? Text(
                              "${list1[index]["title"]}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Montserrat",
                              ),
                            ):Text("No Title"),
                          ),
                          Divider(
                            color: Colors.white,
                            endIndent: 34,
                            indent: 34,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${AppLocalizations.of(context)?.translate("reporton")}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    fontFamily: "Montserrat",
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text("${list1[index]["start_date"]}"),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 30,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${AppLocalizations.of(context)?.translate("location")}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    fontFamily: "Montserrat",
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      "${list1[index]["location"]}",
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height/20,),
                          ElevatedButton(
                            onPressed: () {
                              navigateto(context, ProjectDetails(list1[index]['proj_news_id']));
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                fixedSize: const Size(200, 49),
                                backgroundColor: green),
                            child: Center(
                              child: Text(
                                "${AppLocalizations.of(context)?.translate("clicktoview")}",
                                style: TextStyle(color: Colors.black54,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Montserrat"),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ), ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],


        );
      },
    );
  }
String? date;
void func(){
  for(int i=0;i<list1.length;i++){

    list1[i]["start_date"]=list1[i]["start_date"]?.substring(0,10);
  }
}}