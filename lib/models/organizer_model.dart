class OrganizerModel {
  late String organizerId;
  late String email;
  late String name;
  late String image;
  late String description;
  late String contactNumber;
  late String licenseNumber;

  OrganizerModel({
    required this.organizerId,
    required this.email,
    required this.name,
    required this.image,
    required this.description,
    required this.contactNumber,
    required this.licenseNumber,
  });

  // Factory constructor to create OrganizerModel from a Map (useful for database queries)
  factory OrganizerModel.fromJson(Map<String, dynamic> data) {
    return OrganizerModel(
      organizerId: data['organizer_id'],
      email: data['email'],
      name: data['name'],
      image: data['image'],
      description: data['description'],
      contactNumber: data['contact_number'],
      licenseNumber: data['license_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'organizer_id': organizerId,
      'email': email,
      'name': name,
      'image': image,
      'description': description,
      'contact_number': contactNumber,
      'license_number': licenseNumber,
    };
  }
}