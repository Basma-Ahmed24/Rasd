import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rasd/complains_page.dart';

import 'drawer.dart';

class ViewComplaints extends StatelessWidget {
  @override
  var scaffoldkey = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        key: scaffoldkey,
        drawer: Navdrawer(),
        body: Padding(padding: EdgeInsets.all(5),
          child: Column(children: <Widget>[
            Expanded(
              child: ListView(
                  children: [ Row(children: [
                    IconButton(
                        onPressed: () => scaffoldkey.currentState?.openDrawer(),
                        icon: Icon(
                          Icons.menu,
                          size: 35,
                          color: Colors.black,
                        )),
                  ]), Container(
                height: 60,
                width: 300,
                child: Image.asset("assets/logo.png"),
              ),SizedBox(
                    height: 10,
                  ),SingleChildScrollView(
                    child: Card(color: Colors.white60,
                      child: Column(
                        children: <Widget>[

                          GestureDetector(

                            child: Row(children: [
                              Container(
                                  width: 200,
                                  height: 120,
                                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        "assets/9f9a0e4c92145852968d54a0b1626d61.png",
                                        width: 200,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ))),
                              Flexible(
                                  child: Text("Complaint type",
                                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
                            ]),
                          ), SizedBox(height: 10,),
                          Row(children:[ SizedBox(width: 10,),Text("31-12-2022",style: TextStyle(fontSize: 15.5,fontWeight: FontWeight.w500),),SizedBox(width: 30,),Text(""
                              "ID-125",style: TextStyle(fontSize: 15.5,fontWeight: FontWeight.w500)),SizedBox(width: 130,),Text("Edit",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),)
                            ,IconButton(onPressed: (){ Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ComplainsScreen()),
                            );

                          }, icon: Icon(Icons.edit,color: Colors.orange,size: 30,)) ]),

                          Divider(color: Colors.black),
                        ],
                      ),
                    ),
                  )

                  ])
              ,
            ),

          ]),
        ));
  }
}


