import 'package:tenir/models/hiker.dart';
import 'package:tenir/models/mountain.dart';
import 'package:tenir/models/ticket.dart';
import 'package:tenir/models/transaction.dart';
import 'package:tenir/models/transaction_item.dart';
import 'package:tenir/models/trip.dart';

abstract class TransactionRepository {
  Future<List<TransactionItem>> getTransactions();
}

class MockTransactionRepository implements TransactionRepository {
  static final _mountains = <String, Mountain>{
    'rinjani': Mountain(
      id: 'rinjani',
      name: 'Gunung Rinjani',
      location: 'Lombok, Nusa Tenggara Barat',
      height: 3726,
      mainImageUrl: '',
      description: '',
      images: [],
      basePrice: 350000,
    ),
    'semeru': Mountain(
      id: 'semeru',
      name: 'Gunung Semeru',
      location: 'Lumajang, Jawa Timur',
      height: 3676,
      mainImageUrl: '',
      description: '',
      images: [],
      basePrice: 250000,
    ),
    'gede-pangrango': Mountain(
      id: 'gede-pangrango',
      name: 'Gunung Gede Pangrango',
      location: 'Cianjur, Jawa Barat',
      height: 2958,
      mainImageUrl: '',
      description: '',
      images: [],
      basePrice: 175000,
    ),
  };

  static final _trips = <String, Trip>{
    'trip-rinjani': Trip(
      id: 'trip-rinjani',
      name: 'Pendakian Rinjani via Senaru',
      startDate: DateTime(2026, 8, 14),
      endDate: DateTime(2026, 8, 17),
      mountainId: 'rinjani',
      participantCount: 2,
    ),
    'trip-semeru': Trip(
      id: 'trip-semeru',
      name: 'Pendakian Semeru via Ranu Pani',
      startDate: DateTime(2026, 7, 4),
      endDate: DateTime(2026, 7, 6),
      mountainId: 'semeru',
      participantCount: 1,
    ),
    'trip-gede': Trip(
      id: 'trip-gede',
      name: 'Pendakian Gede via Putri',
      startDate: DateTime(2026, 10, 21),
      endDate: DateTime(2026, 10, 22),
      mountainId: 'gede-pangrango',
      participantCount: 3,
    ),
  };

  static final _transactions = <Transaction>[
    Transaction(
      id: 'TRX-20260801-01',
      userId: 'user-001',
      tripId: 'trip-rinjani',
      tickets: [
        Ticket(
          id: 'ticket-001',
          hiker: _hiker('Alya', 'Putri', '321001'),
          pricePaid: 700000,
        ),
        Ticket(
          id: 'ticket-002',
          hiker: _hiker('Raka', 'Pratama', '321002'),
          pricePaid: 700000,
        ),
      ],
      totalAmountPaid: 1400000,
      status: TransactionStatus.paid,
    ),
    Transaction(
      id: 'TRX-20260618-02',
      userId: 'user-001',
      tripId: 'trip-semeru',
      tickets: [
        Ticket(
          id: 'ticket-003',
          hiker: _hiker('Alya', 'Putri', '321001'),
          pricePaid: 250000,
        ),
      ],
      totalAmountPaid: 250000,
      status: TransactionStatus.cancelled,
    ),
    Transaction(
      id: 'TRX-20260905-03',
      userId: 'user-001',
      tripId: 'trip-gede',
      tickets: [
        Ticket(
          id: 'ticket-004',
          hiker: _hiker('Alya', 'Putri', '321001'),
          pricePaid: 525000,
        ),
        Ticket(
          id: 'ticket-005',
          hiker: _hiker('Raka', 'Pratama', '321002'),
          pricePaid: 525000,
        ),
        Ticket(
          id: 'ticket-006',
          hiker: _hiker('Dimas', 'Saputra', '321003'),
          pricePaid: 525000,
        ),
      ],
      totalAmountPaid: 1575000,
      status: TransactionStatus.pending,
    ),
  ];

  static Hiker _hiker(String firstName, String lastName, String id) {
    return Hiker(
      id: 'hiker-$id',
      firstName: firstName,
      lastName: lastName,
      identityNumber: id,
      phoneNumber: '081234567890',
      emergencyContactPhone: '081298765432',
    );
  }

  @override
  Future<List<TransactionItem>> getTransactions() async {
    await Future.delayed(const Duration(milliseconds: 600));

    return _transactions.map((transaction) {
      final trip = _trips[transaction.tripId]!;
      final mountain = _mountains[trip.mountainId]!;
      return TransactionItem(
        transaction: transaction,
        trip: trip,
        mountain: mountain,
      );
    }).toList();
  }
}