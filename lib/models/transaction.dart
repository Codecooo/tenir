import 'package:tenir/models/ticket.dart';

/// Model untuk transaksi pembelian tiket pendakian gunung
class Transaction {
  final String id;
  final String userId;
  final String tripId;
  final List<Ticket> tickets;
  final double totalAmountPaid;
  final TransactionStatus status;
  final DateTime createdAt = DateTime.now();

  Transaction({
    required this.id,
    required this.userId,
    required this.tripId,
    required this.tickets,
    required this.totalAmountPaid,
    required this.status,
  });
}

enum TransactionStatus { pending, paid, cancelled, expired }