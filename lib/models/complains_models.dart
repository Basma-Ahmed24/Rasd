import 'dart:io';

import 'package:rasd/models/constants.dart';

class ComplainsModels {
  final String? complainsName;
  final String? adress;
  final String? phone;
  final DateTime? complainsDate;
  final String? image;

  ComplainsModels({
    this.complainsName,
    this.adress,
    this.complainsDate,
    this.phone,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      Constants.complainsName: complainsName,
      Constants.complainsadress: adress,
      Constants.complainsDate: complainsDate,
      Constants.phoneNumber: phone,
      Constants.image: image,
    };
  }

  factory ComplainsModels.fromJson(Map<String, dynamic> map) {
    return ComplainsModels(
      complainsName: map[Constants.complainsName],
      adress: map[Constants.complainsadress],
      complainsDate: map[Constants.complainsDate],
      phone: map[Constants.phoneNumber],
      image: map[Constants.image],
    );
  }
}
