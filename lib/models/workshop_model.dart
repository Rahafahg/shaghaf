class WorkshopModel {
  WorkshopModel({
    required this.workshopGroupId,
    required this.title,
    required this.image,
    required this.description,
    required this.categoryId,
    required this.targetedAudience,
    required this.rating,
    required this.organizerId,
  });
  late final String workshopGroupId;
  late final String title;
  late final String image;
  late final String description;
  late final String categoryId;
  late final String targetedAudience;
  late final int rating;
  late final String organizerId;
  
  WorkshopModel.fromJson(Map<String, dynamic> json){
    workshopGroupId = json['workshop_group_id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    categoryId = json['category_id'];
    targetedAudience = json['targeted_audience'];
    rating = json['rating'];
    organizerId = json['organizer_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['workshop_group_id'] = workshopGroupId;
    data['title'] = title;
    data['image'] = image;
    data['description'] = description;
    data['category_id'] = categoryId;
    data['targeted_audience'] = targetedAudience;
    data['rating'] = rating;
    data['organizer_id'] = organizerId;
    return data;
  }
}