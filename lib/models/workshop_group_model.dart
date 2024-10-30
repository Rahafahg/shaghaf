import 'package:shaghaf/models/organizer_model.dart';

class WorkshopGroupModel {
  final String workshopGroupId;
  final String title;
  final String image;
  final String description;
  final String categoryId;
  final String targetedAudience;
  final double rating;
  final String organizerId;
  final List<Workshop> workshops;
  final OrganizerModel organizer; // Use OrganizerModel here

  WorkshopGroupModel({
    required this.workshopGroupId,
    required this.title,
    required this.image,
    required this.description,
    required this.categoryId,
    required this.targetedAudience,
    required this.rating,
    required this.organizerId,
    required this.workshops,
    required this.organizer,
  });

  factory WorkshopGroupModel.fromJson(Map<String, dynamic> json) {
    return WorkshopGroupModel(
      workshopGroupId: json['workshop_group_id'],
      title: json['title'],
      image: json['image'],
      description: json['description'],
      categoryId: json['category_id'],
      targetedAudience: json['targeted_audience'],
      rating: (json['rating'] as num).toDouble(),
      organizerId: json['organizer_id'],
      workshops: (json['workshop'] as List<dynamic>)
          .map((e) => Workshop.fromJson(e))
          .toList(),
      organizer: OrganizerModel.fromJson(json['organizer']), // Parse OrganizerModel
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'workshop_group_id': workshopGroupId,
      'title': title,
      'image': image,
      'description': description,
      'category_id': categoryId,
      'targeted_audience': targetedAudience,
      'rating': rating,
      'organizer_id': organizerId,
      'workshop': workshops.map((e) => e.toJson()).toList(),
      'organizer': organizer.toJson(),
    };
  }
}



// Workshop Model
class Workshop {
  final String workshopId;
  final String workshopGroupId;
  final String instructorName;
  final String instructorImage;
  final String instructorDescription;
  final String date;
  final double price;
  final String? venueName;
  final String? venueAddress;
  final String? venueType;
  final String? meetingUrl;
  final String? latitude;
  final String? longitude;
  final bool isOnline;
  final String fromTime;
  final String toTime;
  final int availableSeats;
  final int numberOfSeats;

  Workshop({
    required this.workshopId,
    required this.workshopGroupId,
    required this.instructorName,
    required this.instructorImage,
    required this.instructorDescription,
    required this.date,
    required this.price,
    this.venueName,
    this.venueAddress,
    this.venueType,
    this.meetingUrl,
    this.latitude,
    this.longitude,
    required this.isOnline,
    required this.fromTime,
    required this.toTime,
    required this.availableSeats,
    required this.numberOfSeats,
  });

  factory Workshop.fromJson(Map<String, dynamic> json) {
    return Workshop(
      workshopId: json['workshop_id'],
      workshopGroupId: json['workshop_group_id'],
      instructorName: json['instructor_name'],
      instructorImage: json['instructor_image'],
      instructorDescription: json['instructor_description'],
      date: json['date'],
      price: (json['price'] as num).toDouble(),
      venueName: json['venue_name'],
      venueAddress: json['venue_address'],
      venueType: json['venue_type'],
      meetingUrl: json['meeting_url'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      isOnline: json['is_online'],
      fromTime: json['from_time'],
      toTime: json['to_time'],
      availableSeats: json['available_seats'],
      numberOfSeats: json['number_of_seats'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'workshop_id': workshopId,
      'workshop_group_id': workshopGroupId,
      'instructor_name': instructorName,
      'instructor_image': instructorImage,
      'instructor_description': instructorDescription,
      'date': date,
      'price': price,
      'venue_name': venueName,
      'venue_address': venueAddress,
      'venue_type': venueType,
      'meeting_url': meetingUrl,
      'latitude': latitude,
      'longitude': longitude,
      'is_online': isOnline,
      'from_time': fromTime,
      'to_time': toTime,
      'available_seats': availableSeats,
      'number_of_seats': numberOfSeats,
    };
  }
}