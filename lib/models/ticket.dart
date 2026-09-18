import 'package:tenir/models/hiker.dart';

/// Tiket untuk masing-masing pendaki gunung
class Ticket {
  final String id;
  final Hiker hiker; 
  final double pricePaid;

  Ticket({
    required this.id,
    required this.hiker,
    required this.pricePaid,
  });
}