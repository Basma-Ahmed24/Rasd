import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasd_app/src/core/localization/bloc.dart';
import 'package:rasd_app/src/core/localization/language_event.dart';
import 'package:rasd_app/src/core/localization/language_localization.dart';

import '../../../core/localization/language_state.dart';
import '../../../core/network/shared_preferences.dart';
import '../../../core/utils/constants.dart';
import '../drawer/drawer_screen.dart';
import '../profile/cubit.dart';
import '../profile/state.dart';
import '../sign_up/component.dart';
import 'mini_creen.dart';

class Settings extends StatelessWidget{
  @override
int done =0;

var lang="English";

List languages=["English","Arabic"];

  TextEditingController t =TextEditingController();

UserCubit c=UserCubit();

  Widget build(BuildContext context) {
    // TODO: implement build
    var list1;
    return BlocProvider(
        create: (BuildContext context) => c..getUserData(CacheHelper.getData(key: "apiToken")),
        child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {},
    builder: (context, state) {
      if (state is UserLoading) {
        return Scaffold(body:
        Center(child: CircularProgressIndicator(color: green,)));} else if (state is UserLoaded) {
       list1 = UserCubit.get(context).p;
    return Scaffold(
    backgroundColor: Primary,
    body: Padding(
    padding: EdgeInsets.only(top: 27),
    child: SingleChildScrollView(
    child: Column(children: [
    Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
    IconButton(
    onPressed: () {
      Navigator.pop(context);
    },
    icon: Icon(
    Icons.arrow_back,
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
    SizedBox(height: MediaQuery.of(context).size.height / 28,),
   Center(
     child: Text(
      "${AppLocalizations.of(context)?.translate("settings")} ",
      textAlign: TextAlign.center,
      style: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 28,
      color: green,
      fontFamily: "Montserrat",
      )
      ),
   ),SizedBox(height: 20,),
      Center(
        child: InkWell(onTap: (){_pickImage(context);},
          child: Container(child:done==0? Icon(Icons.add_a_photo,color:
          Colors.black26,size: 100,):
          ClipOval(
            child: Image.file(
              File(
                '$_imagePath',
              ),fit: BoxFit.cover,
            ),

          ),width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
color:Colors.black12

              ),
            ),
          ),
        ),
      )
       ,     // shape: BoxShape.circle

      SizedBox(height:MediaQuery.of(context).size.height/20 ,),
    Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children:
    [Text("${AppLocalizations.of(context)?.translate("phone")}",style: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 17,
      color: green,
      fontFamily: "Montserrat",
    )),Text("${list1["mobile_number"]}",style: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 17,
      color: Colors.grey,
      fontFamily: "Montserrat",
    )),InkWell(onTap: () { showDialog(
        context: context,
        builder:  (context) {
          return AlertDialog(
            content: mini(
              context,
              c,
             IsPhone: true,
            ),
          );
        });},child: Icon(Icons.edit))],),
      SizedBox(height:MediaQuery.of(context).size.height/20 ,),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children:
      [Text(
          "${AppLocalizations.of(context)?.translate("email")}"
          ,style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 20,
        color: green,
        fontFamily: "Montserrat",
      )),Text("${list1['email']}",style: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 17,
      color: Colors.grey,
      fontFamily: "Montserrat",
    )),InkWell(onTap: (){showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: mini(
                context,
                c,
                isEmail: true,
              ),
            );
          });
        },child: Icon(Icons.edit))],),SizedBox(height: 10,),
    Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [Text("${AppLocalizations.of(context)?.translate("applang")} ",style: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 19,
      color: green,
      fontFamily: "Montserrat",
    )),
      BlocConsumer<LocaleCubit, ChangeLocaleState>(
    listener: (context, state) {
    Navigator.of(context).pop();
    },
    builder: (context, state) {
      lang=state.locale.languageCode;
    return DropdownButton<String>(
    value: state.locale.languageCode,
    icon: const Icon(Icons.keyboard_arrow_down),
    items: ['ar', 'en'].map((String items) {
    return DropdownMenuItem<String>(
    value: items,
    child: Text(items),
    );
    }).toList(),
    onChanged: (String? newValue) {
    if (newValue != null) {
    context.read<LocaleCubit>().changeLanguage(newValue);
    }
    },


   ); })],)]))));}else if (state is UserError&&state.errorMessage.contains("404")) {
      return Center(child:
      Container(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,color: Colors.white,child:
      Column(children: [Image.asset("assets/images/WhatsApp Image 2023-06-22 at 17.32.19.jpg",height: MediaQuery.of(context).size.height/2,width: MediaQuery.of(context).size.width,),
        Text("Oops!,there are some issues occur, we are working on it .",style:TextStyle(color: green,fontSize: 25,fontWeight: FontWeight.w700),)],)),);
    }else{return Container(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,color: Colors.white,child:
      Column(children: [Image.asset("assets/images/WhatsApp Image 2023-06-22 at 17.32.19.jpg",height: MediaQuery.of(context).size.height/2,width: MediaQuery.of(context).size.width,),
      Text("No Internet, Please Open Your Network and Re Open the App",style:TextStyle(color: green,fontSize: 25,fontWeight: FontWeight.w700),)],));}}));}

  String? _imagePath;

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

        done=1;


    }

  }}

