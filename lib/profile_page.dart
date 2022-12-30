import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rasd/mini_screen.dart';

import 'drawer.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  final String _fullName = "Basma Ahmed";
  var scaffoldkey = GlobalKey<ScaffoldState>();
  final String _bio = "Personal Information";
  XFile? imageFile;

  final ImagePicker image = ImagePicker();
  getgal() async {
    dynamic img = await ImagePicker.platform
        .getImageFromSource(source: ImageSource.gallery);
    setState(() {
      imageFile = img;
    });
  }

  Widget _buildProfileImage() {
    return Center(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: SizedBox(
              height: 180,
              width: 180,
              child: Container(
                decoration: imageFile == null
                    ? BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/blank-profile-picture-973460_960_720.png")),
                        shape: BoxShape.circle)
                    : BoxDecoration(
                        image:
                            DecorationImage(image: AssetImage(imageFile!.path)),
                        shape: BoxShape.circle),
                margin: EdgeInsets.all(
                  16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 2,
                      height: 2,
                      decoration: ShapeDecoration(
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
            onTap: getgal,
            child: Container(
              width: 50,
              height: 40,
              decoration: ShapeDecoration(
                shape: CircleBorder(),
                color: Colors.transparent,
              ),
              child: Padding(
                padding: EdgeInsets.all(1),
                child: DecoratedBox(
                  child: Center(child: Icon(Icons.add_a_photo)),
                  decoration: ShapeDecoration(
                    shape: CircleBorder(),
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w500, //try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      color: Colors.grey,
      fontSize: 20,
    );

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(8.0),
      child: Text(
        _bio,
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold( key: scaffoldkey,
        drawer: Navdrawer(),
      body: Stack(
        children: <Widget>[
          Container(
            height: screenSize.height / 3.5,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Column(
                children:[SizedBox(height: 40,) , Row(
                    children:[  IconButton(
                        onPressed: () =>
                            scaffoldkey.currentState?.openDrawer(),
                        icon: Icon(
                          Icons.menu,
                          size: 35,
                          color: Colors.black,
                        )),
                    ]),Center(
                  child: Text(
                    "Name: Basma Ahmed",
                    style: TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w800, color: Colors.white),
                  ),
                ),
                ]),
          ),
          SafeArea(
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              SizedBox(height: screenSize.height / 6.4),
              _buildProfileImage(),
              _buildBio(context),
              _buildSeparator(screenSize),
              SizedBox(height: 10.0),
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Name: Basma Ahmed",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight
                                .w500, //try changing weight to w500 if not thin
                            fontStyle: FontStyle.italic,
                            color: Colors.black54),
                      ),
                      SizedBox(
                        width: 120,
                      ),
                   IconButton(onPressed: (){
                     showDialog(
                         context: context,
                         builder: (context) => AlertDialog(content: Mini()));
                   }, icon: Icon(Icons.edit,color: Colors.orange,)) ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "National Id:12358795412635",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight
                                .w500, //try changing weight to w500 if not thin
                            fontStyle: FontStyle.italic,
                            color: Colors.black54),
                      ),
                      SizedBox(
                        width: 50,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Phone: 011458792698",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight
                              .w500, //try changing weight to w500 if not thin
                          fontStyle: FontStyle.italic,
                          color: Colors.black54),
                    ),
                    SizedBox(
                      width: 50,
                    )
                  ]),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(content: Mini()));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        fixedSize: const Size(300, 55),
                        backgroundColor: Colors.orange),
                    child: Center(
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
            ])),
          ),
        ],
      ),
    );
  }
}
