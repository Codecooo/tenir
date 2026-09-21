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
  final String imageUrl; // URL gambar gunung (network image)

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
    required this.imageUrl,
  });
}

// ===== SAMPLE DATA =====
final List<Mountain> sampleMountains = [
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
    imageUrl: 'https://1.bp.blogspot.com/-6kHIjLW-Mco/YD23fWHy8AI/AAAAAAAACZQ/IkRTzJZjLT4JwglY6dtjjUx52Jcvzb77wCLcBGAsYHQ/s2048/P_20200803_161002.jpg',
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
    imageUrl: 'https://images.unsplash.com/photo-1568023871295-465dc5ff748a?q=80&w=1331&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3Dhttps://picsum.photos/seed/semeru/800/500',
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
    imageUrl: 'https://images.unsplash.com/photo-1602154663343-89fe0bf541ab?q=80&w=1331&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3Dhttps://images.unsplash.com/photo-1628421326877-ae193c09d48c?q=80&w=538&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3Dhttps://picsum.photos/seed/bromo/800/500',
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
    imageUrl: 'https://images.unsplash.com/photo-1628421326877-ae193c09d48c?q=80&w=538&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3Dhttps://picsum.photos/seed/merapi/800/500',
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
    imageUrl: 'https://images.unsplash.com/photo-1575573685828-7c1e20f05124?q=80&w=1331&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3Dhttps://picsum.photos/seed/merbabu/800/500',
  ),
];
