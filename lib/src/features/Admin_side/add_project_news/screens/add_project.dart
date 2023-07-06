import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasd_app/src/features/Admin_side/add_project_news/bloc/Projectnewsmodel.dart';
import 'package:rasd_app/src/features/Admin_side/add_project_news/bloc/cubit.dart';
import 'package:rasd_app/src/features/Admin_side/add_project_news/bloc/state.dart';
import 'package:rasd_app/src/features/Admin_side/home/home_screen.dart';

import '../../../../core/localization/language_localization.dart';
import '../../../../core/network/shared_preferences.dart';
import '../../../../core/utils/constants.dart';
import '../../../User_side/drawer/drawer_screen.dart';
import '../../../User_side/sign_up/component.dart';

class AddProjectScreen extends StatefulWidget {



  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {


  String? address, descripe,proName, imageUrl,s,e;
  DateTime? _selectedDate1;
  DateTime? _selectedDate2;


  var Addresscontroller = TextEditingController();
  var sDatecontroller = TextEditingController();
  var eDatecontroller = TextEditingController();
  var titlecontroller = TextEditingController();
  var descriptioncontroller = TextEditingController();
  var budgetControllrer = TextEditingController();
  var organizationController = TextEditingController();
  var districtController = TextEditingController();



  var formkey = GlobalKey<FormState>();

  var scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (context) => ProjNewsCubit(),
        child: BlocConsumer<ProjNewsCubit, ProjNewsState>(
            listener: (context, state) {
              if (state is projnewsLoaded) {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content:Text("${AppLocalizations.of(context)?.translate("project uploaded")}") ),

    );
    navigateto(context, AdminHome());
                // that should occur after a successful sign-up
              } else if (state is projnewsError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${AppLocalizations.of(context)?.translate("failerp")}")),
                );}
            },
            builder: (context, state) {


              return Scaffold(
                  key: scaffoldkey,
                  drawer: Navdrawer(),
                  backgroundColor: Primary,
                  body: Padding(
                    padding: EdgeInsets.all(23),
                    child: SingleChildScrollView(
                      child: Form(key: formkey,
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

                            ],
                          ),
                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 35,
                          ),
                          Row(children: [
                            SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 3,
                            )
                          ]),
                          Text("${AppLocalizations.of(context)?.translate("add Project")}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 30,
                                color: green,
                                fontFamily: "Montserrat",
                              )),
                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 50,
                          ),
                          if(done==0)
                            IconButton(
                              onPressed: () async {
                                _pickImage(context);
                              },
                              icon: Icon(
                                Icons.add_a_photo_outlined,
                                size: 130,
                              ),
                              iconSize: 130,
                              color: Colors.black26,
                            )

                          //     else if (id==0)InkWell(onTap: (){ _pickImage(context);},child: Image.asset("assets/images/Rectangle 3.png"))
                          // else if (id==1)InkWell(onTap: (){ _pickImage(context);},child:Image.asset("assets/images/Rectangle 6.jpg"))
                          // else if(id==2)InkWell(onTap: (){ _pickImage(context);},child:Image.asset("assets/images/Rectangle 5.png"))
                          else
                            Image.file(
                              File(
                                '$_imagePath',
                              ),
                            ),
                          SizedBox(height: MediaQuery
                              .of(context)
                              .size
                              .height / 50,),

                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 50,
                          ),
                          Container(
                              height: 60,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10))
                              ), child: complainsTextFormField2("${AppLocalizations.of(context)?.translate("location")}", Icons.location_on, Addresscontroller)), SizedBox(height: MediaQuery
                              .of(context)
                              .size
                              .height / 30,),
                          Container(
                              height: 60,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10))
                              ), child: complainsTextFormField2("${AppLocalizations.of(context)?.translate("projecttitle")}", null, titlecontroller)),  SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 50,
                          ),
                          Container(
                              height: 60,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10))
                              ), child: complainsTextFormField2("${AppLocalizations.of(context)?.translate("organization")}", null, organizationController)),  SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 50,
                          ),
                          Container(
                              height: 60,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10))
                              ), child: complainsTextFormField2("${AppLocalizations.of(context)?.translate("budget")}", null, budgetControllrer)),  SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 50,
                          ),
                          // Container(
                          //     height: 60,
                          //     width: MediaQuery
                          //         .of(context)
                          //         .size
                          //         .width,
                          //     decoration: BoxDecoration(
                          //         color: Colors.white,
                          //         borderRadius: BorderRadius.all(
                          //             Radius.circular(10))
                          //     ), child: complainsTextFormField2("${AppLocalizations.of(context)?.translate("district")}", null, districtController)),  SizedBox(
                          //   height: MediaQuery
                          //       .of(context)
                          //       .size
                          //       .height / 50,
                          // ),
                          Container(
                              height: 60,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10))
                              ), child: complainsTextFormField2("${AppLocalizations.of(context)?.translate("startdate")}", null, sDatecontroller)), SizedBox(height: MediaQuery
                              .of(context)
                              .size
                              .height / 30,),
                          Container(
                              height: 60,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10))
                              ), child: complainsTextFormField2("${AppLocalizations.of(context)?.translate("enddate")}", null, eDatecontroller)), SizedBox(height: MediaQuery
                              .of(context)
                              .size
                              .height / 30,),

                          Container(
                              height: 150,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10))
                              ), child: complainsTextFormField2("${AppLocalizations.of(context)?.translate("describe")}", null, descriptioncontroller)),
                          SizedBox(height: MediaQuery
                              .of(context)
                              .size
                              .height / 50,),
                          ElevatedButton(
                            onPressed: state is projnewsLoading ? null : () =>
                                _onUploadPressed(context),
                            child:state is projnewsLoading
                                ? const CircularProgressIndicator(color: green,)
                                :
                             Text(
                              "${AppLocalizations.of(context)?.translate("uploadp")}",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Montserrat"),
                              textAlign: TextAlign.center,
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              fixedSize: const Size(300, 49),
                              backgroundColor: green,
                            ),

                          ),
                        ],
                        ),
                      ),
                    ),
                  )
              );
            }));}

  void _onUploadPressed(BuildContext context) {
    if (formkey.currentState!.validate()) {
      if (_selectedDate1 == null||_selectedDate2==null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select a start date and end date")),
        );
        return;
      }print(_selectedDate1.toString());
      print(_selectedDate2.toString());
      final project = Projectnewsmodel(
          userId: CacheHelper.getData(key: "apiToken"),
          title: titlecontroller.text,
          description: descriptioncontroller.text,
          location: Addresscontroller.text,
          img: _imagePath,
          startDate: _selectedDate1.toString(),
          endDate: _selectedDate2.toString(),
          projOrNews: "proj",
        organization: organizationController.text,
        projBudget: int.tryParse(budgetControllrer.text),
        //districtId: districtController.value as int,
      );
      print(project.userId);
      context.read<ProjNewsCubit>().addProjNewsData(project);
    }
  }


  Widget complainsTextFormField2(String? hintText, IconData? locathion, TextEditingController cont) {
    return TextFormField(
      controller: cont,
      keyboardType: hintText == "${AppLocalizations.of(context)?.translate("budget")}"
          ? TextInputType.number
          : TextInputType.name,
      validator: (value) {
        if (hintText!.trim() == "${AppLocalizations.of(context)?.translate("describe")}") {
          if (value!.isEmpty) {
            return "description must not be empty";
          }
        } else if (hintText.trim() == "${AppLocalizations.of(context)?.translate("location")}") {
          if (value!.isEmpty) {
            return "address must not be empty";
          }
        } else if (hintText!.trim() == "${AppLocalizations.of(context)?.translate("startdate")}") {
          if (value!.isEmpty) {
            return "startDate must not be empty";
          }
        } else if (hintText!.trim() == "${AppLocalizations.of(context)?.translate("enddate")}") {
          if (value!.isEmpty) {
            return "endDate must not be empty";
          }
        } else if (hintText!.trim() == "${AppLocalizations.of(context)?.translate("budget")}") {
          if (value!.isEmpty) {
            return "budget must not be empty";
          }
        } else if (hintText!.trim() == "${AppLocalizations.of(context)?.translate("organization")}") {
          if (value!.isEmpty) {
            return "organization must not be empty";
          }
        } else if (hintText!.trim() == "${AppLocalizations.of(context)?.translate("projecttitle")}") {
          if (value!.isEmpty) {
            return "Project title must not be empty";
          }
        }
        return null;
      },
      maxLines: 10,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: Colors.black26,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: "Montserrat",
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.white,
            width: 50,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        hintText: hintText,
        suffixIcon: hintText == "${AppLocalizations.of(context)?.translate("enddate")}" ||
            hintText == "${AppLocalizations.of(context)?.translate("startdate")}"
            ? InkWell(
          onTap: () async {
            if(hintText=="${AppLocalizations.of(context)?.translate("startdate")}"){
            final selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 365)),

            );
    setState(() {
    _selectedDate1 = selectedDate;
    cont.text ='${_selectedDate1!.day}/${_selectedDate1!.month}/${_selectedDate1!.year}';

    });}else

           {
           final selectedDate = await showDatePicker(
           context: context,
           initialDate: DateTime.now(),
           firstDate: DateTime.now(),
           lastDate: DateTime.now().add(Duration(days: 365)),

           );
           setState(() {
             _selectedDate2 = selectedDate;
             cont.text='${_selectedDate2!.day}/${_selectedDate2!.month}/${_selectedDate2!.year}';
           });}}



         ,
          child: Icon(
            Icons.calendar_today_outlined,
            color: Colors.black26,
          ),
        )
            : InkWell(
          onTap: () async {
            cont.text = await getCurrentLocation();
          },
          child: Icon(
            locathion,
            color: Colors.black26,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 5,
        ),
      ),
      style: const TextStyle(
        color: Colors.black54,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: "Montserrat",
      ),
    );
  }

  String _imagePath="";
  int done =0;


  Future<void> _pickImage(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return ImagePickerDialog(
          onImageSelected: (path) {
            Navigator.of(context).pop(path);
          },
        );
      },
    );

    if (result != null) {
      _imagePath = result;
      setState(() {
        done=1;
      });




    }



  }}
