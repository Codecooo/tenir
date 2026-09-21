import 'package:flutter/material.dart';

import '../../../../models/rental_item.dart';

/// Halaman "Sewa Alat & Logistik".
/// Menampilkan daftar alat & logistik yang bisa disewa/dipesan,
/// dengan filter kategori dan pemilihan jumlah sederhana.
class LogistikPage extends StatefulWidget {
  const LogistikPage({super.key});

  @override
  State<LogistikPage> createState() => _LogistikPageState();
}

class _LogistikPageState extends State<LogistikPage> {
  String _selectedCategory = 'Semua';
  final Map<String, int> _quantities = {};

  List<RentalItem> get _filteredItems {
    if (_selectedCategory == 'Semua') return sampleRentalItems;
    return sampleRentalItems
        .where((item) => item.category == _selectedCategory)
        .toList();
  }

  String _formatRupiah(int value) {
    final str = value.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      final posFromRight = str.length - i;
      buffer.write(str[i]);
      if (posFromRight > 1 && posFromRight % 3 == 1) {
        buffer.write('.');
      }
    }
    return 'Rp$buffer';
  }

  void _changeQuantity(String itemId, int delta, int maxStock) {
    setState(() {
      final current = _quantities[itemId] ?? 0;
      final next = (current + delta).clamp(0, maxStock);
      _quantities[itemId] = next;
    });
  }

  void _addToOrder(RentalItem item) {
    final qty = _quantities[item.id] ?? 0;
    if (qty <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih jumlah dulu, minimal 1.')),
      );
      return;
    }

    // TODO: Ganti bagian ini dengan logika keranjang/transaksi asli project,
    // misalnya menambahkan TransactionItem ke dalam Transaction yang aktif.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.name} x$qty ditambahkan ke pesanan.'),
        duration: const Duration(seconds: 2),
      ),
    );

    setState(() {
      _quantities[item.id] = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final categories = ['Semua', 'Alat', 'Logistik'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sewa Alat & Logistik'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: Column(
        children: [
          // ===== Filter kategori =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = category == _selectedCategory;
                  return ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() => _selectedCategory = category);
                    },
                    selectedColor: colorScheme.primary,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? colorScheme.onPrimary
                          : colorScheme.onSurface,
                    ),
                  );
                },
              ),
            ),
          ),

          // ===== Daftar item =====
          Expanded(
            child: _filteredItems.isEmpty
                ? const Center(child: Text('Belum ada item di kategori ini.'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      final qty = _quantities[item.id] ?? 0;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: colorScheme.primaryContainer,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      item.category == 'Alat'
                                          ? Icons.backpack
                                          : Icons.fastfood,
                                      color: colorScheme.onPrimaryContainer,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${_formatRupiah(item.pricePerUnit)} / ${item.unit}',
                                          style: TextStyle(
                                            color: colorScheme.primary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item.description,
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Stok tersedia: ${item.stock}',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: qty > 0
                                        ? () => _changeQuantity(
                                            item.id,
                                            -1,
                                            item.stock,
                                          )
                                        : null,
                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                    ),
                                  ),
                                  Text(
                                    '$qty',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: qty < item.stock
                                        ? () => _changeQuantity(
                                            item.id,
                                            1,
                                            item.stock,
                                          )
                                        : null,
                                    icon: const Icon(Icons.add_circle_outline),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () => _addToOrder(item),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: colorScheme.primary,
                                      foregroundColor: colorScheme.onPrimary,
                                    ),
                                    child: const Text('Tambah'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
