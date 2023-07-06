import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasd_app/src/core/utils/constants.dart';
import '../../../core/localization/language_localization.dart';
import '../../../core/network/shared_preferences.dart';
import 'bloc/Updatestatus.dart';
import 'bloc/cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
Color c=green;
Widget ComplaintCard(lst,context,id)=>
  Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    padding: EdgeInsets.all(20),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          lst[id]["complaint_img_link"] != null
              ? Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/3,
            child: Image.network("http://18.197.86.8/image/fetch_image?file_path= ${lst[id]["complaint_img_link"]}"),

          )
              : Container(

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(Icons.image_not_supported, size: 70, color: Colors.black26,),
          ),SizedBox(height: MediaQuery.of(context).size.height/40),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: "${AppLocalizations.of(context)?.translate("name")}", style: TextStyle(color:green,fontSize: 15,fontWeight: FontWeight.w600,fontFamily: "Montserrat")),
                TextSpan(text: "${lst[id]["fname"]} ${lst[id]["lname"]}",style: TextStyle(color: Colors.black45,fontSize: 15,fontWeight: FontWeight.w600,fontFamily: "Montserrat")),
              ],
            ),
          ),
          SizedBox(height: 5),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: "${AppLocalizations.of(context)?.translate("type")}", style: TextStyle(color:green,fontSize: 15,fontWeight: FontWeight.w600,fontFamily: "Montserrat")),
                TextSpan(text: "${lst[id]["type"]}",style: TextStyle(color: Colors.black45,fontSize: 15,fontWeight: FontWeight.w600,fontFamily: "Montserrat")),
              ],
            ),
          ), SizedBox(height: 5),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: "${AppLocalizations.of(context)?.translate("location")}", style: TextStyle(color:green,fontSize: 15,fontWeight: FontWeight.w600,fontFamily: "Montserrat")),
                TextSpan(text: "${lst[id]["location"]}",style: TextStyle(color: Colors.black45,fontSize: 15,fontWeight: FontWeight.w600,fontFamily: "Montserrat")),
              ],
            ),
          ), SizedBox(height: 5),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: "${AppLocalizations.of(context)?.translate("describe")}", style: TextStyle(color:green,fontSize: 15,fontWeight: FontWeight.w600,fontFamily: "Montserrat")),
                TextSpan(text: "${lst[id]["description"]}",style: TextStyle(color: Colors.black45,fontSize: 15,fontWeight: FontWeight.w600,fontFamily: "Montserrat")),
              ],
            ),
          ), SizedBox(height: 5),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: "${AppLocalizations.of(context)?.translate("date")}", style: TextStyle(color:green,fontSize: 15,fontWeight: FontWeight.w600,fontFamily: "Montserrat")),
                TextSpan(text: "${lst[id]["complaint_date_time"]}",style: TextStyle(color: Colors.black45,fontSize: 15,fontWeight: FontWeight.w600,fontFamily: "Montserrat")),
              ],
            ),
          ), SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
            InkWell(onTap: (){_onUploadPressed(context,"completed",lst[id]["complaint_id"]); Navigator.pop(context);}, child:lst[id]["status"]=="completed"? Container(height: 30,width: 70, color: Colors.black12,child: Center(child: Text("${AppLocalizations.of(context)?.translate("done")}",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600))),)
                :Container(height: 30,width: 70, color: green,child: Center(child: Text("${AppLocalizations.of(context)?.translate("done")}",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600))),)),
            InkWell(onTap:(){_onUploadPressed(context,"pending",lst[id]["complaint_id"]); Navigator.pop(context);},child:lst[id]["status"]=="pending"? Container(height: 30,width: 70,color: Colors.black12,child: Center(child: Text("${AppLocalizations.of(context)?.translate("pending")}",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600),)),)
                :Container(height: 30,width: 70,color: green,child: Center(child: Text("${AppLocalizations.of(context)?.translate("pending")}",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600),)),)),
            InkWell(onTap:(){_onUploadPressed(context,"submitted",lst[id]["complaint_id"]); Navigator.pop(context);},child:lst[id]["status"]=="submitted"? Container(height: 30,width: 70,color: Colors.black12,child: Center(child: Text("${AppLocalizations.of(context)?.translate("submitted")}",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600))),)
                :Container(height: 30,width: 70,color: green,child: Center(child: Text("${AppLocalizations.of(context)?.translate("submitted")}",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600))),))
          ],)    ],
      ),
    ),
  );





  void _onUploadPressed(BuildContext context,String status,int id) async {

    final complaint = Updatestatus(
        userId: CacheHelper.getData(key: "apiToken")
        ,complaintId: id,
        status: status
    );
    await context.read<ComplaintsCubit>().updateStatus(complaint);


  }
