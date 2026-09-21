class RentalItem {
  final String id;
  final String name;
  final String category; // 'Alat' atau 'Logistik'
  final int pricePerUnit;
  final String unit; // contoh: 'per hari', 'per paket'
  final String description;
  final int stock;

  RentalItem({
    required this.id,
    required this.name,
    required this.category,
    required this.pricePerUnit,
    required this.unit,
    required this.description,
    required this.stock,
  });
}

// ===== SAMPLE DATA =====
// Nanti bisa diganti dengan data dari API/database kalau sudah ada.
final List<RentalItem> sampleRentalItems = [
  RentalItem(
    id: 'r1',
    name: 'Tenda Dome 4 Orang',
    category: 'Alat',
    pricePerUnit: 50000,
    unit: 'per hari',
    description:
        'Tenda dome kapasitas 4 orang, cocok untuk pendakian kelompok kecil.',
    stock: 8,
  ),
  RentalItem(
    id: 'r2',
    name: 'Sleeping Bag',
    category: 'Alat',
    pricePerUnit: 20000,
    unit: 'per hari',
    description: 'Sleeping bag tahan suhu hingga 5°C.',
    stock: 15,
  ),
  RentalItem(
    id: 'r3',
    name: 'Kompor Portable + Gas',
    category: 'Alat',
    pricePerUnit: 15000,
    unit: 'per hari',
    description: 'Kompor portable lengkap dengan tabung gas kecil.',
    stock: 10,
  ),
  RentalItem(
    id: 'r4',
    name: 'Paket Logistik Makan 3 Hari',
    category: 'Logistik',
    pricePerUnit: 120000,
    unit: 'per paket',
    description: 'Paket makanan siap masak untuk 3 hari pendakian (1 orang).',
    stock: 20,
  ),
  RentalItem(
    id: 'r5',
    name: 'Air Mineral 1.5L (isi 6)',
    category: 'Logistik',
    pricePerUnit: 30000,
    unit: 'per paket',
    description: 'Persediaan air minum untuk perjalanan.',
    stock: 25,
  ),
];
