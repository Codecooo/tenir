/// Model untuk merepresentasikan trip yang akan dilakukan oleh hiker
class Trip {
  final String id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String mountainId;
  final int participantCount;

  Trip({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.mountainId,
    required this.participantCount,
  });
}