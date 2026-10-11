class TravelPackage {
  final String id;
  final String title;
  final String startLocation;
  final String durationText;
  final double basePrice;
  final TravelTripType type;
  final String description;
  final String facilitiesDescription;
  final List<TravelTripTimeline> timeline;
  final List<DateTime> availableDates;
  final int totalQuota;
  final int remainingQuota;

  TravelPackage({
    required this.id,
    required this.title,
    required this.startLocation,
    required this.durationText,
    required this.basePrice,
    required this.type,
    required this.description,
    required this.facilitiesDescription,
    required this.timeline,
    required this.availableDates,
    required this.totalQuota,
    required this.remainingQuota,
  });
}

class TravelTripTimeline {
  final String date;
  final String description;

  TravelTripTimeline({
    required this.date,
    required this.description,
  });
}

enum TravelTripStatus {
  upcoming,
  ongoing,
  completed,
  cancelled,
}

enum TravelTripType {
  openTrip,
  private,
}