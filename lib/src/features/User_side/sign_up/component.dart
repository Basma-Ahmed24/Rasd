import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rasd_app/src/core/utils/constants.dart';

class ImagePickerDialog extends StatelessWidget {
  final ValueChanged<String> onImageSelected;

  const ImagePickerDialog({Key? key, required this.onImageSelected}) : super(key: key);

  Future<void> _showPicker(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 50,
    );

    if (pickedFile != null) {
      onImageSelected(pickedFile.path);
    }
  }
  Future<void> _showPickercamira(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 50,
    );

    if (pickedFile != null) {
      onImageSelected(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(backgroundColor: Primary,
      title: Text('Select an image'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel',style: TextStyle(color:Colors.black54),),
        ),
      ],
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                _showPicker(context);
              },
              child: Text('Select from gallery',style: TextStyle(color:Colors.white)),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fixedSize: const Size(138, 20),
                backgroundColor: green,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _showPickercamira(context);
              },
              child: Text('Take a picture',style: TextStyle(color:Colors.white)),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fixedSize: const Size(138, 20),
                backgroundColor: green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImagePreviewWidget extends StatelessWidget {
  final String? imagePath;

  const ImagePreviewWidget({Key? key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imagePath == null) {
      return Placeholder(
        fallbackHeight: 200,
      );
    }

    return Image.file(
      File(imagePath!),
      height: 200,
      fit: BoxFit.cover,
    );
  }
}
Future<String> getCurrentLocation() async {
 // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  double latitude = position.latitude;
  double longitude = position.longitude;

  print('Latitude: $latitude');
  print('Longitude: $longitude');
return getAddressFromLatLng(latitude, longitude);
}
Future<String> getAddressFromLatLng(double lat, double lng) async {
  try {

    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    if (placemarks != null && placemarks.isNotEmpty) {
      final Placemark pos = placemarks[0];
      return "${pos.name}, ${pos.thoroughfare}, ${pos.subLocality}, ${pos.locality}, ${pos.administrativeArea} ${pos.postalCode}, ${pos.country}";
    }
  } catch (e) {
    print(e);
  }
  return "";
}
