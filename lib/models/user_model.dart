class UserModel {
  UserModel({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.favoriteCategories,
    required this.externalId
  });
  late final String userId;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String phoneNumber;
  late final String favoriteCategories;
  late final String externalId;
  
  UserModel.fromJson(Map<String, dynamic> json){
    userId = json['user_id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    favoriteCategories = json['favorite_categories'];
    externalId = json['external_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_id'] = userId;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone_number'] = phoneNumber;
    data['favorite_categories'] = favoriteCategories;
    data['external_id'] = externalId;
    return data;
  }
}