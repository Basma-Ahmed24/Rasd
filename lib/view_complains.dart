// ignore_for_file: override_on_non_overriding_member, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rasd/complains_page.dart';
import 'package:rasd/controller/user_bloc/user_cubit.dart';
import 'package:rasd/controller/user_bloc/user_state.dart';
import 'package:rasd/models/constants.dart';

import 'drawer.dart';

class ViewComplaints extends StatelessWidget {
  final scaffoldkey = GlobalKey<ScaffoldState>();

  ViewComplaints({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      drawer: Navdrawer(),
      body: BlocConsumer<UserCubit, UserStatus>(
          listener: (context, state) {},
          builder: (ctx, state) {
            final cubit = UserCubit.get(ctx);
            return StreamBuilder(
                stream: cubit.getComplains(),
                builder: (context, snapShot) {
                  if (snapShot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final List complainsData =
                      (snapShot.data as QuerySnapshot).docs;
                  if (complainsData.isEmpty) {
                    return const Center(
                      child: Text('No Complains is Add Yet',style: TextStyle(fontSize: 20),),
                    );
                  }
                  return SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              IconButton(
                                onPressed: () =>
                                    scaffoldkey.currentState?.openDrawer(),
                                icon: const Icon(
                                  Icons.menu,
                                  size: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height/15,
                            width: 300,
                            child: Image.asset("assets/logo.png"),
                          ),
                           SizedBox(
                          height:   MediaQuery.of(context).size.height/50,
                          ),
                          Expanded(
                            child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 5);
                              },
                              itemCount: complainsData.length,
                              itemBuilder: (context, index) {
                                final dates =
                                    DateTime.fromMillisecondsSinceEpoch(
                                  complainsData[index][Constants.complainsDate]
                                      .millisecondsSinceEpoch,
                                );
                                final dateFormat = DateFormat.Hm();
                                final dateString = dateFormat.format(dates);

                                return Card(
                                  color: Colors.white60,
                                  child: Column(
                                    children: <Widget>[
                                      GestureDetector(
                                        child: Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width/2,
                                              height: MediaQuery.of(context).size.height/5,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 10, 0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  complainsData[index][
                                                      Constants.complainsimage],

                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                complainsData[index]
                                                    [Constants.complainsName],
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox( height: MediaQuery.of(context).size.height/70,),
                                      Row(
                                        children: [
                                          const SizedBox(width: 5),
                                          Text(
                                            dateString,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width/20,
                                          ),
                                          Text(
                                            complainsData[index]
                                                [Constants.complainsadress],
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width/3
                                          ),
                                          const Text(
                                            "Edit",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ComplainsScreen(),
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Colors.orange,
                                              size: 30,
                                            ),
                                          )
                                        ],
                                      ),
                                      const Divider(color: Colors.black),
                                    ],
                                  ),
                                );
                              },

                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
