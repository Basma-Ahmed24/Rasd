// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rasd/controller/user_bloc/user_cubit.dart';
import 'package:rasd/controller/user_bloc/user_state.dart';
import 'package:rasd/models/complains_models.dart';
import 'package:rasd/models/constants.dart';
import 'package:rasd/view_complains.dart';
import 'package:uuid/uuid.dart';

import 'drawer.dart';

class ComplainsScreen extends StatefulWidget {
  const ComplainsScreen({super.key});

  @override
  State<ComplainsScreen> createState() => _ComplainsScreenState();
}

class _ComplainsScreenState extends State<ComplainsScreen> {
  String? dropdownValue = 'Lighting pole';
  File? _selectedImage;

  int? selectedValue;
  String? address, phoneNumber, complainsName, imageUrl;
  List<String> items = ['Lighting pole', 'potholes', 'Building violation'];
  // final ImagePicker image = ImagePicker();
  var formkey = GlobalKey<FormState>();
  var scaffoldkey = GlobalKey<ScaffoldState>();
  final picker = ImagePicker();

  Future pickImage(BuildContext context) async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStatus>(
      listener: (context, state) {},
      builder: (ctx, state) {
        final cubit = UserCubit.get(ctx);
        return Scaffold(
          key: scaffoldkey,
          drawer: Navdrawer(),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                      width: 0,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () =>
                              scaffoldkey.currentState?.openDrawer(),
                          icon: Icon(
                            Icons.menu,
                            size: 35,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 70,
                      width: 250,
                      child: Image.asset("assets/logo.png"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Complains Form",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    if (_selectedImage == null)
                      IconButton(
                        onPressed: () async {
                          var uuid = Uuid();

                          final imageId = uuid.v4();
                          print(imageId);

                          await pickImage(context).then(
                            (value) async {
                              final ref = FirebaseStorage.instance
                                  .ref()
                                  .child(Constants.complainsimage)
                                  .child(imageId + Constants.complainsimage);
                              await ref.putFile(_selectedImage!).whenComplete(
                                () async {
                                  imageUrl = await ref.getDownloadURL();
                                },
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.image,
                          size: 150,
                        ),
                        iconSize: 150,
                        color: Colors.grey,
                      )
                    else
                      Image.file(
                        File(
                          _selectedImage!.path,
                        ),
                      ),
                    SizedBox(height: 10),
                    DropdownButtonFormField(
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
                      items: items.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 17),
                            ),
                          );
                        },
                      ).toList(),
                      value: dropdownValue,
                      onChanged: (String? newValue) {
                        setState(
                          () {
                            dropdownValue = newValue!;
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    complainsTextFormField(Constants.address),
                    SizedBox(height: 20),
                    complainsTextFormField(Constants.phoneNumber),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate() &&
                            _selectedImage != null) {
                          formkey.currentState!.save();

                          print('image $imageUrl');
                          print(address);
                          ComplainsModels complains = ComplainsModels(
                            adress: address,
                            phone: phoneNumber,
                            complainsDate: DateTime.now(),
                            complainsName: dropdownValue,
                            image: imageUrl,
                          );
                          print(complains.phone);
                          await cubit
                              .addComplains(
                                complains: complains,
                              )
                              .then(
                                (value) => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ViewComplaints(),
                                  ),
                                ),
                              );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          fixedSize: const Size(400, 55),
                          backgroundColor: _selectedImage == null
                              ? Colors.grey
                              : Colors.orange),
                      child: Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget complainsTextFormField(String? hintText) {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) {
        if (hintText!.trim() == Constants.address) {
          address = newValue!;
        } else if (hintText.trim() == Constants.phoneNumber) {
          phoneNumber = newValue!;
        }
      },
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
        ),
        prefixIcon: Icon(
          Icons.phone,
          color: Colors.black45,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(13),
          ),
        ),
        hintText: hintText,
      ),
      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
      validator: (value) {
        if (hintText!.trim() == Constants.phoneNumber) {
          if (value!.isEmpty) {
            return "phone no must not be empty";
          }
        } else if (hintText.trim() == Constants.address.trim()) {
          if (value!.isEmpty) {
            return "address must not be empty";
          }
        }
        return null;
      },
    );
  }
}
