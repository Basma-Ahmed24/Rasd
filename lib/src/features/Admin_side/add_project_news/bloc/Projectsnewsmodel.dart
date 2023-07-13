class Projectsnewsmodel {
  Projectsnewsmodel({
      this.userId, 
      this.title, 
      this.description, 
      this.img, 
      this.location, 
      this.startDate, 
      this.endDate, 
      this.projOrNews, 
      this.districtId, 
      this.districtString, 
      this.organization, 
      this.projBudget, 
      this.allowComments,});

  Projectsnewsmodel.fromJson(dynamic json) {
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
    img = json['img'];
    location = json['location'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    projOrNews = json['proj_or_news'];
    districtId = json['district_id'];
    districtString = json['district_string'];
    organization = json['organization'];
    projBudget = json['proj_budget'];
    allowComments = json['allow_comments'];
  }
  String? userId;
  String? title;
  String? description;
  String? img;
  String? location;
  String? startDate;
  String? endDate;
  String? projOrNews;
  int? districtId;
  String? districtString;
  String? organization;
  int? projBudget;
  int? allowComments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['title'] = title;
    map['description'] = description;
    map['img'] = img;
    map['location'] = location;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['proj_or_news'] = projOrNews;
    map['district_id'] = districtId;
    map['district_string'] = districtString;
    map['organization'] = organization;
    map['proj_budget'] = projBudget;
    map['allow_comments'] = allowComments;
    return map;
  }

}