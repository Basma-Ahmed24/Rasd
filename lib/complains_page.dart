import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rasd/profile_page.dart';
import 'drawer.dart';

class ComplainsScreen extends StatefulWidget {
  const ComplainsScreen({super.key});

  @override
  State<ComplainsScreen> createState() => _ComplainsScreenState();
}

class _ComplainsScreenState extends State<ComplainsScreen> {
  String? dropdownValue = 'Lighting pole';
  XFile? imageFile;

  int? selectedValue;
  var phonecontroller = TextEditingController();
  var addresscontroller = TextEditingController();
  List<String> items = ['Lighting pole', 'potholes', 'Building violation'];
  final ImagePicker image = ImagePicker();
  var formkey = GlobalKey<FormState>();
  var scaffoldkey = GlobalKey<ScaffoldState>();
  final picker = ImagePicker();
<<<<<<< HEAD






  getgal()async{
    dynamic img=await ImagePicker.platform.getImageFromSource(source:ImageSource.gallery)    ;
    setState(() {
      imageFile=img ;
    });
  }
=======

  getgal() async {
    dynamic img = await ImagePicker.platform
        .getImageFromSource(source: ImageSource.gallery);
    setState(() {
      imageFile = img;
    });
  }

>>>>>>> ac4246821ab2dd8e325bf35b05ea16ce3edd9afb
  Widget build(BuildContext context) {
    // TODO: implement build

    int? selectedValue;
    var phonecontroller = TextEditingController();
    var addresscontroller = TextEditingController();
    List<String> items = ['Lighting pole', 'potholes', 'Building violation'];

    var formkey = GlobalKey<FormState>();
    var scaffoldkey = GlobalKey<ScaffoldState>();

<<<<<<< HEAD

    return Scaffold(key: scaffoldkey,
=======
    return Scaffold(
      key: scaffoldkey,
>>>>>>> ac4246821ab2dd8e325bf35b05ea16ce3edd9afb
      drawer: Navdrawer(),
      backgroundColor: Colors.white,


      body: SingleChildScrollView(
        child: Form(key: formkey,
          child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                    width: 0,
                  ),
                  Row(children: [
                    IconButton(
                        onPressed: () => scaffoldkey.currentState?.openDrawer(),
                        icon:
                        Icon(Icons.menu, size: 35, color: Colors.black)),
                  ]),
                  Container(
                    height: 70,
                    width: 250,
                    child: Image.asset("assets/logo.png"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Complains Form",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      )),
<<<<<<< HEAD


                  if (imageFile == null) IconButton(onPressed: () async {
                    getgal();
                  },
                    icon: Icon(Icons.image, size: 150,),
                    iconSize: 150,
                    color: Colors.grey,) else
                    Image.file(File(imageFile!.path))
                  ,
                  SizedBox(height: 10,),
=======
                  if (imageFile == null)
                    IconButton(
                      onPressed: () async {
                        getgal();
                      },
                      icon: Icon(
                        Icons.image,
                        size: 150,
                      ),
                      iconSize: 150,
                      color: Colors.grey,
                    )
                  else
                    Image.file(File(imageFile!.path)),
                  SizedBox(
                    height: 10,
                  ),
>>>>>>> ac4246821ab2dd8e325bf35b05ea16ce3edd9afb
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder( //<-- SEE HERE
                        borderSide: BorderSide(color: Colors.black12, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder( //<-- SEE HERE
                        borderSide: BorderSide(color: Colors.grey, width: 2,),
                      ),

                    ),
                    items: <String>[
                      'Lighting pole',
                      'potholes',
                      'Building violation'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 17),
                        ),
                      );
                    }).toList(),
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        print(dropdownValue);
                      });
                    },

                  )
                  , SizedBox(height: 10,),
                  TextFormField(
                      keyboardType: TextInputType.name,
                      controller: phonecontroller,
                      onChanged: (String value) {
                        print(value);
                      },
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(13),
                          ),
                        ),
                        hintText: "Address",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "address must not be empty";
                        }
                      },
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      keyboardType: TextInputType.name,
                      controller: phonecontroller,
                      onChanged: (String value) {
                        print(value);
                      },
                      decoration: const InputDecoration(
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.blueAccent, width: 2.0),
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
                          hintText: "Phone No",

                          contentPadding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 5)),
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w500),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "phone no must not be empty";
                        }
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        print(phonecontroller.text);
                        print(addresscontroller.text);
                        Navigator.push(
                          context,
<<<<<<< HEAD
                          MaterialPageRoute(
                              builder: (context) => Profile()),
=======
                          MaterialPageRoute(builder: (context) => Profile()),
>>>>>>> ac4246821ab2dd8e325bf35b05ea16ce3edd9afb
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        fixedSize: const Size(400, 55),
                        backgroundColor: Colors.orange),
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


              )),
        ),
      ),
    );
<<<<<<< HEAD
  }}
=======
  }
}
>>>>>>> ac4246821ab2dd8e325bf35b05ea16ce3edd9afb
