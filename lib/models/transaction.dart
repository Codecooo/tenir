import 'package:tenir/models/ticket.dart';

/// Model untuk transaksi pembelian tiket pendakian gunung
class Transaction {
  final String id;
  final String userId;           
  final String destinationId;     
  final String destinationName;    
  final DateTime startDate;
  final DateTime endDate;
  final List<Ticket> tickets;      
  final double totalAmountPaid;
  final TransactionStatus status;
  final DateTime createdAt;

  Transaction({
    required this.id,
    required this.userId,
    required this.destinationId,
    required this.destinationName,
    required this.startDate,
    required this.endDate,
    required this.tickets,
    required this.totalAmountPaid,
    required this.status,
    required this.createdAt,
  });
}

enum TransactionStatus { pending, paid, cancelled, expired }