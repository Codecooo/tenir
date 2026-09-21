import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tenir/models/transaction_item.dart';
import 'package:tenir/utils/format.dart';

class TransactionDetailScreen extends StatelessWidget {
  final TransactionItem transactionItem;

  const TransactionDetailScreen({super.key, required this.transactionItem});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final status = statusPresentation(
      transactionItem.transaction.status,
      theme.colorScheme,
    );

    return Scaffold(
      backgroundColor: theme.colorScheme.primaryFixed,
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: theme.colorScheme.primaryFixedDim,
          ),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  transactionItem.trip.name,
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(transactionItem.mountain.name, style: theme.textTheme.bodyLarge,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Divider(height: 10, color: Colors.black),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd MMM yyyy')
                          .format(transactionItem.transaction.createdAt),
                    ),
                    SizedBox(
                    width: 100,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: status.color.withAlpha(50),
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
              ),
              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Data Transaksi", style: TextStyle(fontWeight: FontWeight.bold),),
                    _TransactionDetailCard(theme: theme, transactionItem: transactionItem)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _TransactionDetailCard extends StatelessWidget {
  const _TransactionDetailCard({
    required this.theme,
    required this.transactionItem,
  });

  final ThemeData theme;
  final TransactionItem transactionItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: theme.colorScheme.secondaryContainer,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(20),
      
      child: Column(
        children: [
          // Start date
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 8.5,
                  children: [
                    Icon(Icons.calendar_month, color: Colors.blueAccent,),
                    Text("Tanggal Mulai"),
                  ],
                ),
                Text(DateFormat("dd MMM yyyy").format(transactionItem.trip.startDate))
              ],
            ),
          ),

          // End date
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 8.5,
                  children: [
                    Icon(Icons.event_busy, color: Colors.blueAccent,),
                    Text("Tanggal Selesai"),
                  ],
                ),
                Text(DateFormat("dd MMM yyyy").format(transactionItem.trip.endDate))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
