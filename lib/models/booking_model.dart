class BookingModel {
  final String bookingId;
  final String userId;
  final String workshopId;
  final DateTime bookingDate; // Includes date, time, and time zone
  final int numberOfTickets;
  final double totalPrice;
  final bool isAttended;
  final String qrCode;

  BookingModel({
    required this.bookingId,
    required this.userId,
    required this.workshopId,
    required this.bookingDate,
    required this.numberOfTickets,
    required this.totalPrice,
    this.isAttended = false,
    required this.qrCode,
  }); // Generates a UUID if not provided

  // Convert Booking object to JSON for storage or API
  Map<String, dynamic> toJson() {
    return {
      'booking_id': bookingId,
      'user_id': userId,
      'workshop_id': workshopId,
      'booking_date':
          bookingDate.toIso8601String(), // Converts to ISO 8601 with time zone
      'number_of_tickets': numberOfTickets,
      'total_price': totalPrice,
      'is_attended': isAttended,
      'qr_code': qrCode,
    };
  }

  // Create a Booking object from JSON (e.g., from database)
  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingId: json['booking_id'],
      userId: json['user_id'],
      workshopId: json['workshop_id'],
      bookingDate: DateTime.parse(
          json['booking_date']), // Parses ISO 8601 format with time zone
      numberOfTickets: json['number_of_tickets'],
      totalPrice: json['total_price'],
      isAttended: json['is_attended'] ?? false,
      qrCode: json['qr_code'],
    );
  }
}
