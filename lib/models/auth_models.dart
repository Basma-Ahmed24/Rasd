import 'package:rasd/models/constants.dart';

class AuthModels {
  final String? name;
  final String? email;
  final String? phone;
  final String? nationalId;
  final String? userId;

  AuthModels({this.name, this.email, this.phone, this.nationalId, this.userId});

  Map<String, dynamic> toJson() {
    return {
      Constants.name: name,
      Constants.email: email,
      Constants.phoneNumber: phone,
      Constants.nationalId: nationalId,
      Constants.uid: userId,
    };
  }

  factory AuthModels.fromJson(Map<String, dynamic> map) {
    return AuthModels(
        name: map[Constants.name],
        email: map[Constants.email],
        phone: map[Constants.phoneNumber],
        nationalId: map[Constants.nationalId],
        userId: map[Constants.uid]);
  }
}
