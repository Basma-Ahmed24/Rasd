
import 'package:equatable/equatable.dart';

class SignUpModel {
  SignUpModel({
      String? googleId, 
      String? fname, 
      String? lname, 
      String? idCardImg, 
      String? email, 
      String? mobileNumber, 
      String? address, 
      String? passHash, 
      num? isAdmin,}){
    _googleId = googleId;
    _fname = fname;
    _lname = lname;
    _idCardImg = idCardImg;
    _email = email;
    _mobileNumber = mobileNumber;
    _address = address;
    _passHash = passHash;
    _isAdmin = isAdmin;
}

  SignUpModel.fromJson(dynamic json) {
    _googleId = json['google_id'];
    _fname = json['fname'];
    _lname = json['lname'];
    _idCardImg = json['id_card_img'];
    _email = json['email'];
    _mobileNumber = json['mobile_number'];
    _address = json['address'];
    _passHash = json['pass_hash'];
    _isAdmin = json['is_admin'];
  }
  String? _googleId;
  String? _fname;
  String? _lname;
  String? _idCardImg;
  String? _email;
  String? _mobileNumber;
  String? _address;
  String? _passHash;
  num? _isAdmin;
SignUpModel copyWith({  String? googleId,
  String? fname,
  String? lname,
  String? idCardImg,
  String? email,
  String? mobileNumber,
  String? address,
  String? passHash,
  num? isAdmin,
}) => SignUpModel(  googleId: googleId ?? _googleId,
  fname: fname ?? _fname,
  lname: lname ?? _lname,
  idCardImg: idCardImg ?? _idCardImg,
  email: email ?? _email,
  mobileNumber: mobileNumber ?? _mobileNumber,
  address: address ?? _address,
  passHash: passHash ?? _passHash,
  isAdmin: isAdmin ?? _isAdmin,
);
  String? get googleId => _googleId;
  String? get fname => _fname;
  String? get lname => _lname;
  String? get idCardImg => _idCardImg;
  String? get email => _email;
  String? get mobileNumber => _mobileNumber;
  String? get address => _address;
  String? get passHash => _passHash;
  num? get isAdmin => _isAdmin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['google_id'] = _googleId;
    map['fname'] = _fname;
    map['lname'] = _lname;
    map['id_card_img'] = _idCardImg;
    map['email'] = _email;
    map['mobile_number'] = _mobileNumber;
    map['address'] = _address;
    map['pass_hash'] = _passHash;
    map['is_admin'] = _isAdmin;
    return map;
  }

}
