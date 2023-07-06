import 'package:flutter/material.dart';
import 'package:rasd_app/src/core/utils/constants.dart';

import '../../../core/localization/language_localization.dart';
import '../Reports/report_screen.dart';
import '../complaints_form/screens/complaint_screen.dart';
import '../home/home_screen.dart';
import '../news/news_screen.dart';
import '../projects/project_screen.dart';

class MyNavigationBar extends StatefulWidget {
  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _pageindex = 0;

  List<Widget> _widgetOptions = [
   HomeScreen(),
  NewsScreen(),
    ProjectScreen(),
    ReportScreen(),
    ComplainsScreen(4)

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Primary,
        body: Center(
          child: _widgetOptions.elementAt(_pageindex),
        ),
        bottomNavigationBar: Container(
          height: 75,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children:[ IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      _pageindex = 0;
                    });
                  },
                  icon: _pageindex == 0
                      ? const Icon(
                    Icons.home_filled,
                    color: Colors.green,
                    size: 35,
                  )
                      : const Icon(
                    Icons.home_filled,
                    size: 35,
                    color: Colors.grey,
                  ),
                ),
                  Text("${AppLocalizations.of(context)?.translate("home")}",style: TextStyle(color: Colors.grey),) ]),
              Column(
                  children:[ IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      setState(() {
                        _pageindex = 1;
                      });
                    },
                    icon: _pageindex == 1
                        ? const Icon(
                      Icons.newspaper,
                      color: Colors.green,
                      size: 35,
                    )
                        : const Icon(
                      Icons.newspaper,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                    Text("${AppLocalizations.of(context)?.translate("news")}",style: TextStyle(color: Colors.grey),) ]),
              Column(
                  children:[ IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      setState(() {
                        _pageindex = 2;
                      });
                    },
                    icon: _pageindex == 2
                        ? const Icon(
                      Icons.build,
                      color: Colors.green,
                      size: 35,
                    )
                        : const Icon(
                      Icons.build_outlined,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                    Text("${AppLocalizations.of(context)?.translate("projects")}",style: TextStyle(color: Colors.grey),) ]),
              Column(
                  children:[ IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      setState(() {
                        _pageindex = 3;
                      });
                    },
                    icon: _pageindex == 3
                        ? const Icon(
                      Icons.report,
                      color: Colors.green,
                      size: 35,
                    )
                        : const Icon(
                      Icons.report_gmailerrorred,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                    Text("${AppLocalizations.of(context)?.translate("reports")}",style: TextStyle(color: Colors.grey),) ]),
              Column(
                  children:[ IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      setState(() {
                        _pageindex = 4;
                      });
                    },
                    icon: _pageindex == 4
                        ? const Icon(
                      Icons.comment,
                      color: Colors.green,
                      size: 35,
                    )
                        : const Icon(
                      Icons.comment_outlined,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                    Text("${AppLocalizations.of(context)?.translate("complaint")}",style: TextStyle(color: Colors.grey),) ])],
          ),
        ));
  }
}
