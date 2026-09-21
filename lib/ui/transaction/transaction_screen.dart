import 'package:flutter/material.dart';
import 'package:tenir/models/transaction.dart';
import 'package:tenir/models/transaction_item.dart';
import 'package:tenir/repositories/transaction_repository.dart';
import 'package:tenir/ui/transaction/transaction_detail_screen.dart';
import 'package:tenir/ui/widgets/screen_info.dart';
import 'package:tenir/ui/widgets/summary_card.dart';
import 'package:tenir/utils/format.dart';

/// A screen that displays the user's hiking booking transaction history.
///
/// Fetches transactions asynchronously from a [TransactionRepository], showing top summary
/// cards for total orders and active trips, followed by a list of itemized transaction cards.
class TransactionScreen extends StatefulWidget {
  /// The data source repository used to retrieve transaction history.
  final TransactionRepository repository;

  /// Creates a [TransactionScreen].
  ///
  /// If no [repository] is supplied, it defaults to using [MockTransactionRepository].
  TransactionScreen({super.key, TransactionRepository? repository})
    : repository = repository ?? MockTransactionRepository();

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  /// Holds the future result of the transaction list request to prevent refetching on rebuilds.
  late Future<List<TransactionItem>> _transactionsFuture;

  @override
  void initState() {
    super.initState();
    // Fetch transaction data once when the state is initialized.
    _transactionsFuture = widget.repository.getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isWide = ScreenInfo.of(context).isWide;

    return Scaffold(
      backgroundColor: theme.colorScheme.primaryFixed,
      body: FutureBuilder<List<TransactionItem>>(
        future: _transactionsFuture,
        builder: (context, snapshot) {
          // Handle loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Handle error state
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Gagal memuat transaksi',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            );
          }

          final items = snapshot.data ?? [];

          // Calculate active hiking bookings (paid or pending payment)
          final activeCount = items.where((item) {
            final status = item.transaction.status;
            return status == TransactionStatus.paid ||
                status == TransactionStatus.pending;
          }).length;

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            children: [
              // Screen Header
              Text(
                'Riwayat Transaksi',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),

              // Overview Metrics Section
              SizedBox(
                height: isWide ? 90 : 140,
                child: Row(
                  children: [
                    SummaryCard(
                      label: 'Total pesanan',
                      value: '${items.length}',
                      icon: Icons.receipt_long_rounded,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    SummaryCard(
                      label: 'Pendakian aktif',
                      value: '$activeCount',
                      icon: Icons.hiking_rounded,
                      color: const Color(0xFF2E7D32),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Transaction List Header
              Text(
                'Semua transaksi',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),

              // Transaction List Cards
              ...items.map((item) => _TransactionCard(item: item)),
            ],
          );
        },
      ),
    );
  }
}

/// A card widget displaying the details of a single hiking booking transaction.
///
/// Includes mountain name, status badge, route/trip details, booking date, hiker count,
/// transaction ID, and total cost.
class _TransactionCard extends StatelessWidget {
  /// The combined model containing transaction, trip, and mountain details.
  final TransactionItem item;

  const _TransactionCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final isWide = ScreenInfo.of(context).isWide;
    final theme = Theme.of(context);
    final transaction = item.transaction;
    final trip = item.trip;
    final mountain = item.mountain;

    final status = statusPresentation(transaction.status, theme.colorScheme);

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  TransactionDetailScreen(transactionItem: item),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mountain Name & Status Chip Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      mountain.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: status.color.withAlpha(24),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          status.label,
                          style: TextStyle(
                            color: status.color,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),

              // Trip Name
              Text(
                trip.name,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),

              // Date Range Detail Row
              _DetailRow(
                icon: Icons.calendar_today_rounded,
                text: dateRange(trip.startDate, trip.endDate),
              ),
              const SizedBox(height: 8),

              // Hiker Count Detail Row
              _DetailRow(
                icon: Icons.people_alt_rounded,
                text: '${transaction.tickets.length} pendaki',
              ),
              const Divider(height: 24),

              // Transaction ID & Amount Paid
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'ID: ${transaction.id}',
                      style: TextStyle(
                        fontSize: isWide ? 11 : 8,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Text(
                    rupiah(transaction.totalAmountPaid),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A compact icon-and-text row helper for displaying details inside transaction cards.
class _DetailRow extends StatelessWidget {
  /// The icon representing the line item.
  final IconData icon;

  /// The text content displayed next to the icon.
  final String text;

  const _DetailRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 17, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Text(text, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
