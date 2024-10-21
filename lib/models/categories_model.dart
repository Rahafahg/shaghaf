class CategoriesModel {
  final String categoryId;
  final String categoryName;
  final String image;

  CategoriesModel({
    required this.categoryId,
    required this.categoryName,
    required this.image,
  });

  // Factory constructor to create a Category from a map (useful for API responses)
  factory CategoriesModel.fromJson(Map<String, dynamic> map) {
    return CategoriesModel(
        categoryId: map['category_id'],
        categoryName: map['category_name'],
        image: map['image']);
  }

  // Convert a Category instance to a map (useful for sending data to an API)
  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'category_name': categoryName,
      'image': image,
    };
  }
}
