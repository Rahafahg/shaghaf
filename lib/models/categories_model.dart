class CategoriesModel {
  final String categoryId;
  final String categoryName;
  final String image;
  final String icon;

  CategoriesModel({required this.categoryId,required this.categoryName,required this.image,required this.icon,});

  // Factory constructor to create a Category from a map (useful for API responses)
  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(categoryId: json['category_id'],categoryName: json['category_name'],icon: json['icon'],image: json['image']);
  }
  // Convert a Category instance to a map (useful for sending data to an API)
  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'category_name': categoryName,
      'image': image,
      'icon': icon,
    };
  }
}