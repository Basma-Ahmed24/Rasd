
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
      num? isAdmin,
    String?profile_img,
  String?id_back_img}){
    _googleId = googleId;
    _fname = fname;
    _lname = lname;
    _idCardImg = idCardImg;
    _email = email;
    _mobileNumber = mobileNumber;
    _address = address;
    _passHash = passHash;
    _isAdmin = isAdmin;
    _id_back_img= id_back_img;
    _profile_img=profile_img;
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
    _id_back_img=json["id_card_img"];
    _profile_img=json["profile_img"];
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
  String? _id_back_img;
  String?_profile_img;
SignUpModel copyWith({  String? googleId,
  String? fname,
  String? lname,
  String? idCardImg,
  String? email,
  String? mobileNumber,
  String? address,
  String? passHash,
  num? isAdmin,
  String?id_back_img,
  String?profile_img
}) => SignUpModel(  googleId: googleId ?? _googleId,
  fname: fname ?? _fname,
  lname: lname ?? _lname,
  idCardImg: idCardImg ?? _idCardImg,
  email: email ?? _email,
  mobileNumber: mobileNumber ?? _mobileNumber,
  address: address ?? _address,
  passHash: passHash ?? _passHash,
  isAdmin: isAdmin ?? _isAdmin,
    id_back_img:id_back_img?? _id_back_img,
    profile_img: profile_img??_profile_img
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
  String? get id_back_img =>_id_back_img;
String?get profile_img=>_profile_img;
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
    map["id_back_img"]=_id_back_img;
    map["profile_img"]=_profile_img;
    return map;
  }

}
