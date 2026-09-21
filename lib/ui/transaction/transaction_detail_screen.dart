import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tenir/models/hiker.dart';
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
      appBar: AppBar(
        title: const Text("Detail Transaksi"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: theme.colorScheme.primaryFixedDim,
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Text(
              transactionItem.trip.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              transactionItem.mountain.name,
              style: theme.textTheme.bodyLarge,
            ),
            const Divider(height: 20, color: Colors.black26),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('dd MMM yyyy')
                      .format(transactionItem.transaction.createdAt),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: status.color.withAlpha(50),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status.label,
                    style: TextStyle(
                      color: status.color,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // Start & End dates
            Column(
              children: [
                _buildDateTile(
                  theme: theme,
                  icon: Icons.calendar_month,
                  label: "Tanggal Mulai",
                  date: transactionItem.trip.startDate,
                ),
                const SizedBox(height: 6),
                _buildDateTile(
                  theme: theme,
                  icon: Icons.event_busy,
                  label: "Tanggal Selesai",
                  date: transactionItem.trip.endDate,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Data Transaksi
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.receipt, color: theme.colorScheme.primary),
                    const SizedBox(width: 10),
                    const Text(
                      "Data Transaksi",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                const Divider(color: Colors.black26),
                _TransactionDetailCard(
                  theme: theme,
                  transactionItem: transactionItem,
                ),
              ],
            ),
            SizedBox(height: 15,),

            // Detail pendaki
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.hiking, color: theme.colorScheme.primary),
                    const SizedBox(width: 10),
                    const Text(
                      "Data Pendaki",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                const Divider(color: Colors.black26),
                Row(
                  children: [
                    Text("Total Pendaki: "),
                    Text(transactionItem.transaction.tickets.length.toString())
                  ],
                ),
                SizedBox(height: 8,),

                ...transactionItem.transaction.tickets.map((ticket) => 
                  _HikerDetailCard(theme: theme, hiker: ticket.hiker,)
                )
              ],
            )
          ],
        ),
      ),

      // Bottom button
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: theme.colorScheme.secondaryContainer,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text("Kembali"),
          ),
        ),
      ),
    );
  }

  Widget _buildDateTile({
    required ThemeData theme,
    required IconData icon,
    required String label,
    required DateTime date,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text(label),
            ],
          ),
          Text(DateFormat("dd MMMM yyyy").format(date)),
        ],
      ),
    );
  }
}

class _HikerDetailCard extends StatelessWidget {
  const new({
    required this.theme,
    required this.hiker,
  });

  final ThemeData theme;
  final Hiker hiker;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: theme.colorScheme.secondaryContainer,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("${hiker.firstName} ${hiker.lastName}", style: TextStyle(fontSize: 14),),

            // Nomor hp
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Nomor HP"),
                Text(hiker.phoneNumber),
              ],
            ),

            // Catatan medis
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Catatan Medis"),
                Text(hiker.medicalNotes ?? "Tidak ada"),
              ],
            ),
            
            // Kontak Darurat
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Nomor Darurat"),
                Text(hiker.emergencyContactPhone),
              ],
            ),
          ],
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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),

      child: Column(
        children: [
          // Ticket
          ...transactionItem.transaction.tickets.map(
            (ticket) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tiket ${ticket.hiker.firstName}"),
                  const SizedBox(width: 10),
                  Text(rupiah(ticket.pricePaid)),
                ],
              ),
            ),
          ),

          // Admin
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Biaya Admin"),
                SizedBox(width: 10),
                Text("Rp 0"),
              ],
            ),
          ),

          // Total Bayar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Bayar"),
                SizedBox(width: 10),
                Text(
                  rupiah(transactionItem.transaction.totalAmountPaid),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
