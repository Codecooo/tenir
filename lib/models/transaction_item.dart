import 'package:tenir/models/mountain.dart';
import 'package:tenir/models/transaction.dart';
import 'package:tenir/models/trip.dart';

class TransactionItem {
  final Transaction transaction;
  final Trip trip;
  final Mountain mountain;

  const TransactionItem({
    required this.transaction,
    required this.trip,
    required this.mountain,
  });
}