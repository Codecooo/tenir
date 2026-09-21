class Mountain {
  final String id;
  final String name;
  final String location;
  final int wniPrice; // WNI price (weekday)
  final int wnaPrice; // WNA price (weekday)
  final int wniWeekendPrice; // WNI price (weekend)
  final int wnaWeekendPrice; // WNA price (weekend)
  final String region;
  final String description;

  Mountain({
    required this.id,
    required this.name,
    required this.location,
    required this.wniPrice,
    required this.wnaPrice,
    required this.wniWeekendPrice,
    required this.wnaWeekendPrice,
    required this.region,
    required this.description,
  });
}

// ===== SAMPLE DATA =====
final List<Mountain> sampleMountains = [
  Mountain(
    id: '1',
    name: 'Bukit Lincing',
    location: 'Tahura Raden Soerjo',
    wniPrice: 25000,
    wnaPrice: 200000,
    wniWeekendPrice: 35000,
    wnaWeekendPrice: 250000,
    region: 'Semua Provinsi',
    description: 'Bukit Lincing adalah puncak tertinggi di Tahura Raden Soerjo dengan pemandangan yang indah.',
  ),
  Mountain(
    id: '2',
    name: 'Gunung Bekel',
    location: 'Perhutani',
    wniPrice: 15000,
    wnaPrice: 150000,
    wniWeekendPrice: 25000,
    wnaWeekendPrice: 200000,
    region: 'Semua Provinsi',
    description: 'Gunung Bekel menawarkan jalur pendakian yang mudah dan cocok untuk pemula.',
  ),
  Mountain(
    id: '3',
    name: 'Gunung Semeru',
    location: 'Jawa Timur',
    wniPrice: 50000,
    wnaPrice: 300000,
    wniWeekendPrice: 75000,
    wnaWeekendPrice: 350000,
    region: 'Jawa Timur',
    description: 'Gunung Semeru adalah gunung tertinggi di Jawa dengan pemandangan yang spektakuler.',
  ),
  Mountain(
    id: '4',
    name: 'Gunung Bromo',
    location: 'Jawa Timur',
    wniPrice: 40000,
    wnaPrice: 250000,
    wniWeekendPrice: 60000,
    wnaWeekendPrice: 300000,
    region: 'Jawa Timur',
    description: 'Gunung Bromo terkenal dengan pemandangan sunrise yang menakjubkan dari Penanjakan.',
  ),
  Mountain(
    id: '5',
    name: 'Gunung Merapi',
    location: 'Jawa Tengah',
    wniPrice: 35000,
    wnaPrice: 220000,
    wniWeekendPrice: 50000,
    wnaWeekendPrice: 280000,
    region: 'Jawa Tengah',
    description: 'Gunung Merapi adalah gunung berapi aktif dengan pemandangan yang mengesankan.',
  ),
  Mountain(
    id: '6',
    name: 'Gunung Merbabu',
    location: 'Jawa Tengah',
    wniPrice: 30000,
    wnaPrice: 180000,
    wniWeekendPrice: 45000,
    wnaWeekendPrice: 230000,
    region: 'Jawa Tengah',
    description: 'Gunung Merbabu menawarkan jalur yang cukup menantang dengan pemandangan cantik.',
  ),
];
