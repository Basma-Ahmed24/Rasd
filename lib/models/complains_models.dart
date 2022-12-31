import 'package:rasd/models/constants.dart';

class ComplainsModels {
  final String? complainsName;
  final String? adress;
  final String? phone;
  final DateTime? complainsDate;

  ComplainsModels(
      {this.complainsName, this.adress, this.complainsDate, this.phone});

  Map<String, dynamic> toJson() {
    return {
      Constants.complainsName: complainsName,
      Constants.complainsadress: adress,
      Constants.complainsDate: complainsDate,
      Constants.phoneNumber: phone,
    };
  }

  factory ComplainsModels.fromJson(Map<String, dynamic> map) {
    return ComplainsModels(
        complainsName: map[Constants.complainsName],
        adress: map[Constants.complainsadress],
        complainsDate: map[Constants.complainsDate],
        phone: map[Constants.phoneNumber]);
  }
}
