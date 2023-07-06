class ProfileModel {
  ProfileModel({
    this.fname,
    this.lname,
    this.idCardImg,
    this.email,
    this.mobileNumber,
    this.address,
    this.isAdmin,
  });

  ProfileModel.fromJson(dynamic json) {
    fname = json['fname'];
    lname = json['lname'];
    idCardImg = json['id_card_img'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    address = json['address'];
    isAdmin = int.parse(json['is_admin']); // Updated line
  }

  String? fname;
  String? lname;
  String? idCardImg;
  String? email;
  String? mobileNumber;
  String? address;
  int? isAdmin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fname'] = fname;
    map['lname'] = lname;
    map['id_card_img'] = idCardImg;
    map['email'] = email;
    map['mobile_number'] = mobileNumber;
    map['address'] = address;
    map['is_admin'] = isAdmin;
    return map;
  }
}
