
class ComplaintModel {
  ComplaintModel({
      this.userId,
      this.location,
      this.description,
      this.complaintImgLink,
      this.type,});

  ComplaintModel.fromJson(dynamic json) {
    userId = json['user_id'];
    location = json['location'];
    description = json['description'];
    complaintImgLink = json['complaint_img_link'];
    type = json['type'];
  }
  String? userId;
  String? location;
  String? description;
  dynamic complaintImgLink;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['location'] = location;
    map['description'] = description;
    map['complaint_img_link'] = complaintImgLink;
    map['type'] = type;
    return map;
  }


}