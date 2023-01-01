// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rasd/controller/user_bloc/user_cubit.dart';
import 'package:rasd/controller/user_bloc/user_state.dart';
import 'package:rasd/mini_screen.dart';
import 'package:rasd/models/auth_models.dart';
import 'package:rasd/models/constants.dart';

import 'drawer.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  var scaffoldkey = GlobalKey<ScaffoldState>();
  final String _bio = "Personal Information";
  File? _selectedImage;
  String? newImage;
  final picker = ImagePicker();
  Future pickImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }

  Widget _buildProfileImage(UserCubit cubit, String imageurl) {
    // print('imageUrl is $imageurl');
    return Center(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: SizedBox(
              height: 180,
              width: 180,
              child: Container(
                decoration: _selectedImage == null && imageurl.isEmpty
                    ? const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/blank-profile-picture-973460_960_720.png",
                          ),
                        ),
                        shape: BoxShape.circle)
                    : _selectedImage != null
                        ? BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(
                                _selectedImage!,
                              ),
                            ),
                            shape: BoxShape.circle)
                        : BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                imageurl,
                              ),
                            ),
                            shape: BoxShape.circle,
                          ),
                margin: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 2,
                      height: 2,
                      decoration: const ShapeDecoration(
                        shape: CircleBorder(),
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await pickImage().then(
                (value) async {
                  final ref = FirebaseStorage.instance
                      .ref()
                      .child(Constants.userImage)
                      .child(
                        FirebaseAuth.instance.currentUser!.uid +
                            Constants.userImage,
                      );
                  await ref.putFile(_selectedImage!).whenComplete(
                    () async {
                      newImage = await ref.getDownloadURL();
                    },
                  );
                },
              ).whenComplete(() {
                // print('new image is $newImage');

                cubit.addUserInfo(context, AuthModels(image: newImage),
                    isUpdatePhoto: true);
              });
            },
            child: Container(
              width: 50,
              height: 40,
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: Colors.transparent,
              ),
              child: const Padding(
                padding: EdgeInsets.all(1),
                child: DecoratedBox(
                  decoration: ShapeDecoration(
                    shape: CircleBorder(),
                    color: Colors.orange,
                  ),
                  child: Center(child: Icon(Icons.add_a_photo)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = const TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w500, //try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      color: Colors.grey,
      fontSize: 20,
    );

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        _bio,
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }

  Widget _buildSeparator(BoxConstraints screenSize) {
    return Container(
      width: screenSize.maxWidth / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: const EdgeInsets.only(top: 4.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      drawer: Navdrawer(),
      body: BlocConsumer<UserCubit, UserStatus>(
        listener: (context, state) {},
        builder: (ctx, state) {
          final cubit = UserCubit.get(ctx);
          return LayoutBuilder(
            builder: (context, size) {
              return FutureBuilder(
                future: cubit.getUserInfo(),
                builder: (context, data) {
                  if (data.connectionState == ConnectionState.waiting) {
                    return const Center(child: SingleChildScrollView());
                  }

                  return data.hasError
                      ? const Center(
                          child: Text('an Error Occured'),
                        )
                      : Stack(
                          children: <Widget>[
                            Container(
                              height: size.maxHeight * 0.36,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 40),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () => scaffoldkey
                                            .currentState
                                            ?.openDrawer(),
                                        icon: const Icon(
                                          Icons.menu,
                                          size: 35,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: Text(
                                      'Name : ${(data.data as dynamic)[Constants.name]}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SafeArea(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: size.maxHeight * 0.2),
                                    _buildProfileImage(
                                        cubit,
                                        (data.data
                                            as dynamic)[Constants.userImage]),
                                    _buildBio(context),
                                    _buildSeparator(size),
                                    const SizedBox(height: 10.0),
                                    Column(
                                      children: [
                                        SizedBox(
                                            height: size.maxHeight * 0.025),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Name : ${(data.data as dynamic)[Constants.name]}',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight
                                                      .w500, //try changing weight to w500 if not thin
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    content: mini(
                                                      context,
                                                      cubit,
                                                      isName: true,
                                                    ),
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.orange,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                            height: size.maxHeight * 0.025),
                                        Text(
                                          'national Id : ${(data.data as dynamic)[Constants.nationalId]}',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight
                                                .w500, //try changing weight to w500 if not thin
                                            fontStyle: FontStyle.italic,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        SizedBox(
                                            height: size.maxHeight * 0.025),
                                        // ignore: prefer_const_literals_to_create_immutables
                                        Row(
                                          children: [
                                            SizedBox(width: 20),
                                            Text(
                                              'Phone : ${(data.data as dynamic)[Constants.phoneNumber]}',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight
                                                    .w500, //try changing weight to w500 if not thin
                                                fontStyle: FontStyle.italic,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            SizedBox(width: 50)
                                          ],
                                        ),
                                        const SizedBox(height: 30),
                                        ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                content: mini(context, cubit,
                                                    isPass: true),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            fixedSize: const Size(300, 55),
                                            backgroundColor: Colors.orange,
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "Change Password",
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
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                },
              );
            },
          );
        },
      ),
    );
  }
}
