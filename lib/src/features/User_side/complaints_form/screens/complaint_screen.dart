import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasd_app/src/features/User_side/complaints_form/bloc/cubit.dart';
import 'package:rasd_app/src/features/User_side/complaints_form/bloc/state.dart';

import '../../../../core/localization/language_localization.dart';
import '../../../../core/network/shared_preferences.dart';
import '../../../../core/utils/constants.dart';
import '../../drawer/drawer_screen.dart';
import '../../nav_bar/navigation_bar.dart';
import '../../sign_up/component.dart';
import '../bloc/ComplaintModel.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

class ComplainsScreen extends StatefulWidget {
  @override
  State<ComplainsScreen> createState() => _ComplainsScreenState();
}

class _ComplainsScreenState extends State<ComplainsScreen> {
  String? dropdownValue;

  int? selectedValue;
  List _outputs = [];
  String? address, descripe, complainsName, imageUrl;

  var Addresscontroller = TextEditingController();

  var descriptioncontroller = TextEditingController();

  var formkey = GlobalKey<FormState>();
  bool _loading = false;
  var scaffoldkey = GlobalKey<ScaffoldState>();
  loadModel() async {
    await Tflite.loadModel(
      model: "assets/potholes_models/model_unquant.tflite",
      labels: "assets/potholes_models/model_unquant.txt",
      numThreads: 1,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.5,
        asynch: true);
    setState(() {
      _loading = false;
      _outputs = output!;
    });
  }

  void dispose() {
    Tflite.close();
    super.dispose();
  }

  String? output() {
    if (_outputs.isNotEmpty) {
      print(_outputs);
      if (_outputs[0]["label"] == "potholes") {
        dropdownValue =
            "${AppLocalizations.of(context)?.translate("potholes")}";
        return dropdownValue;
      }
      return dropdownValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ComplaintCubit(),
        child: BlocConsumer<ComplaintCubit, ComplaintState>(
            listener: (context, state) {
          if (state.isSuccess) {
            Navigator.pop(context);
            // that should occur after a successful sign-up
          } else if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("field to upload the complaint, try again"),
            ));
          }
        }, builder: (context, state) {
          return Scaffold(
              key: scaffoldkey,
              drawer: Navdrawer(),
              backgroundColor: Primary,
              body: Padding(
                padding: EdgeInsets.all(23),
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        Text(
                            "${AppLocalizations.of(context)?.translate("addnewcomplaint")}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 30,
                              color: green,
                              fontFamily: "Montserrat",
                            )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 50,
                        ),
                        if (done == 0)
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
                        else
                          Image.file(
                            File(
                              '$_imagePath',
                            ),
                          ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 50,
                        ),
                        Container(
                          height: 65,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black12, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                              ),
                            ),
                            items: [
                              "${AppLocalizations.of(context)?.translate("lighting_pole")}",
                              "${AppLocalizations.of(context)?.translate("potholes")}",
                              "${AppLocalizations.of(context)?.translate("Building violation")}",
                              "${AppLocalizations.of(context)?.translate("Garbage")}",
                              "${AppLocalizations.of(context)?.translate("Cafes")}",
                              "${AppLocalizations.of(context)?.translate("Water")}",
                              "${AppLocalizations.of(context)?.translate("Electricity")}",
                              "${AppLocalizations.of(context)?.translate("Street vendors")}",
                              "${AppLocalizations.of(context)?.translate("Infringement on street")}"
                            ].map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black54,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500),
                                  ),
                                );
                              },
                            ).toList(),
                            value: output(),
                            onChanged: (String? newValue) {},
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 50,
                        ),
                        Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: complainsTextFormField2(
                                "${AppLocalizations.of(context)?.translate("address")}",
                                Icons.location_on,
                                Addresscontroller)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 30,
                        ),
                        Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: complainsTextFormField2(
                                "${AppLocalizations.of(context)?.translate("describe")}",
                                null,
                                descriptioncontroller)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 50,
                        ),
                        ElevatedButton(
                          onPressed: state.isLoading
                              ? null
                              : () => _onUploadPressed(context),
                          child: state.isLoading
                              ? const CircularProgressIndicator(
                                  color: green,
                                )
                              : Text(
                                  "${AppLocalizations.of(context)?.translate("uploadcomplaint")}",
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
              ));
        }));
  }

  Future<void> _onUploadPressed(BuildContext context) async {
    final complaintCubit = context.read<ComplaintCubit>();
    await complaintCubit.uploadImage(_imagePath!);
    print(complaintCubit.path1);
    if (formkey.currentState!.validate()) {
      final complaint = ComplaintModel(
        userId: CacheHelper.getData(key: "apiToken") as String,
        location: Addresscontroller.text,
        description: descriptioncontroller.text,
        type: dropdownValue,
        complaintImgLink: ComplaintCubit.get(context).path1,
      );
      print(complaint.userId);
      print(complaintCubit.path1);
      complaintCubit.fileComplaint(complaint);
    }
  }

  Widget complainsTextFormField2(
      String? hintText, IconData? locathion, TextEditingController cont) {
    return TextFormField(
      controller: cont,
      keyboardType: TextInputType.name,
      onSaved: (newValue) {
        if (hintText!.trim() ==
            "${AppLocalizations.of(context)?.translate("address")}") {
          address = newValue!;
        } else if (hintText.trim() ==
            "${AppLocalizations.of(context)?.translate("describe")}") {
          descripe = newValue!;
        }
      },
      validator: (value) {
        if (hintText!.trim() ==
            "${AppLocalizations.of(context)?.translate("describe")}") {
          if (value!.isEmpty) {
            return "description must not be empty";
          }
        }
        if (hintText.trim() ==
            "${AppLocalizations.of(context)?.translate("address")}") {
          if (value!.isEmpty) {
            return "address must not be empty";
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
            fontFamily: "Montserrat"),
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
        suffixIcon: InkWell(
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
          fontFamily: "Montserrat"),
    );
  }

  String? _imagePath;
  int done = 0;

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
      setState(() {
        _imagePath = result;
        _loading = true;
        done = 1;
      });

      classifyImage(File(_imagePath!));
    }
  }
}
