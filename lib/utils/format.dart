import 'package:flutter/material.dart';
import 'package:tenir/models/transaction.dart';

/// Formats numeric currency values to Indonesian Rupiah string (e.g., `Rp 1.400.000`).
String rupiah(double amount) =>
    'Rp ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => '.')}';

/// Maps [TransactionStatus] enum values to localized UI display labels and theme colors.
({String label, Color color}) statusPresentation(
  TransactionStatus value,
  ColorScheme colors,
) {
  return switch (value) {
    TransactionStatus.paid => (
      label: 'Berhasil',
      color: const Color(0xFF2E7D32),
    ),
    TransactionStatus.pending => (
      label: 'Menunggu pembayaran',
      color: const Color(0xFFB26A00),
    ),
    TransactionStatus.cancelled => (label: 'Dibatalkan', color: colors.error),
    TransactionStatus.expired => (
      label: 'Kedaluwarsa',
      color: colors.onSurfaceVariant,
    ),
  };
}

/// Formats start and end dates into `DD/MM/YYYY - DD/MM/YYYY`.
String dateRange(DateTime start, DateTime end) {
  String format(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  return '${format(start)} -${format(end)}';
}
