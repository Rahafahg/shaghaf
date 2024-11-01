class UserReviewModel {
  late final String workshopGroupId;
  late final String userFName;
  late final String userLName;
  late final String comment;
  late final double rate;

  UserReviewModel(
      {required this.workshopGroupId,
      required this.userFName,
      required this.userLName,
      required this.comment,
      required this.rate});

  UserReviewModel.fromJson(Map<String, dynamic> json) {
    workshopGroupId = json['workshop_group_id'];
    userFName = json['users']['first_name'];
    userLName = json['users']['last_name'];
    comment = json['comments'];
    rate = (json['rating'] as num).toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['workshop_group_id'] = workshopGroupId;
    data['first_name'] = userFName;
    data['last_name'] = userLName;
    data['comments'] = comment;
    data['rating'] = rate;
    return data;
  }
}
