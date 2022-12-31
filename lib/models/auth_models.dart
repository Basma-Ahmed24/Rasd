import 'package:rasd/models/constants.dart';

class AuthModels {
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? nationalId;

  AuthModels({this.firstName, this.lastName, this.phone, this.nationalId});

  Map<String, dynamic> toJson() {
    return {
      Constants.firstName: firstName,
      Constants.lastName: lastName,
      Constants.phoneNumber: phone,
      Constants.nationalId: nationalId,
    };
  }

  factory AuthModels.fromJson(Map<String, dynamic> map) {
    return AuthModels(
      firstName: map[Constants.firstName],
      lastName: map[Constants.lastName],
      phone: map[Constants.phoneNumber],
      nationalId: map[Constants.nationalId],
    );
  }
}
