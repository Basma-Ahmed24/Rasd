class Updatestatus {
  Updatestatus({
      required this.complaintId,
      required this.userId,
      required this.status,});

  Updatestatus.fromJson(dynamic json) {
    complaintId = json['complaint_id'];
    userId = json['user_id'];
    status = json['status'];
  }
  int? complaintId;
  String? userId;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['complaint_id'] = complaintId;
    map['user_id'] = userId;
    map['status'] = status;
    return map;
  }

}