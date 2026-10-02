/// Mountain data shared by ticket catalog and transaction screens.
class Mountain {
  final String id;
  final String name;
  final String location;
  final String description;
  final String mainImageUrl;
  final String region;
  final int indonesianWeekdayPrice;
  final int internationalWeekdayPrice;
  final int indonesianWeekendPrice;
  final int internationalWeekendPrice;
  final double height;
  final List<String> images;
  final double basePrice;
  final AlertLevel? alertLevel;
  bool isFavorite;
  bool isVolcanicActive;

  Mountain({
    required this.id,
    required this.name,
    required this.location,
    required this.height,
    required this.mainImageUrl,
    required this.description,
    required this.images,
    required this.basePrice,
    this.region = '',
    this.indonesianWeekdayPrice = 0,
    this.internationalWeekdayPrice = 0,
    this.indonesianWeekendPrice = 0,
    this.internationalWeekendPrice = 0,
    this.alertLevel,
    this.isFavorite = false,
    this.isVolcanicActive = false,
  });
}

enum AlertLevel {
  siaga,
  waspada,
  awas,
}

final List<Mountain> sampleMountains = [
  Mountain(
    id: '2',
    name: 'Gunung Bekel',
    location: 'Perhutani',
    height: 0,
    images: const [],
    basePrice: 0,
    indonesianWeekdayPrice: 15000,
    internationalWeekdayPrice: 150000,
    indonesianWeekendPrice: 25000,
    internationalWeekendPrice: 200000,
    region: 'Semua Provinsi',
    description: 'Gunung Bekel menawarkan jalur pendakian yang mudah dan cocok untuk pemula.',
    mainImageUrl: 'https://1.bp.blogspot.com/-6kHIjLW-Mco/YD23fWHy8AI/AAAAAAAACZQ/IkRTzJZjLT4JwglY6dtjjUx52Jcvzb77wCLcBGAsYHQ/s2048/P_20200803_161002.jpg',
  ),
  Mountain(
    id: '3',
    name: 'Gunung Semeru',
    location: 'Jawa Timur',
    height: 0,
    images: const [],
    basePrice: 0,
    indonesianWeekdayPrice: 50000,
    internationalWeekdayPrice: 300000,
    indonesianWeekendPrice: 75000,
    internationalWeekendPrice: 350000,
    region: 'Jawa Timur',
    description: 'Gunung Semeru adalah gunung tertinggi di Jawa dengan pemandangan yang spektakuler.',
    mainImageUrl: 'https://images.unsplash.com/photo-1568023871295-465dc5ff748a?q=80&w=1331&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3Dhttps://picsum.photos/seed/semeru/800/500',
  ),
  Mountain(
    id: '4',
    name: 'Gunung Bromo',
    location: 'Jawa Timur',
    height: 0,
    images: const [],
    basePrice: 0,
    indonesianWeekdayPrice: 40000,
    internationalWeekdayPrice: 250000,
    indonesianWeekendPrice: 60000,
    internationalWeekendPrice: 300000,
    region: 'Jawa Timur',
    description: 'Gunung Bromo terkenal dengan pemandangan sunrise yang menakjubkan dari Penanjakan.',
    mainImageUrl: 'https://images.unsplash.com/photo-1602154663343-89fe0bf541ab?q=80&w=1331&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3Dhttps://images.unsplash.com/photo-1628421326877-ae193c09d48c?q=80&w=538&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3Dhttps://picsum.photos/seed/bromo/800/500',
  ),
  Mountain(
    id: '5',
    name: 'Gunung Merapi',
    location: 'Jawa Tengah',
    height: 0,
    images: const [],
    basePrice: 0,
    indonesianWeekdayPrice: 35000,
    internationalWeekdayPrice: 220000,
    indonesianWeekendPrice: 50000,
    internationalWeekendPrice: 280000,
    region: 'Jawa Tengah',
    description: 'Gunung Merapi adalah gunung berapi aktif dengan pemandangan yang mengesankan.',
    mainImageUrl: 'https://images.unsplash.com/photo-1628421326877-ae193c09d48c?q=80&w=538&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3Dhttps://picsum.photos/seed/merapi/800/500',
  ),
  Mountain(
    id: '6',
    name: 'Gunung Merbabu',
    location: 'Jawa Tengah',
    height: 0,
    images: const [],
    basePrice: 0,
    indonesianWeekdayPrice: 30000,
    internationalWeekdayPrice: 180000,
    indonesianWeekendPrice: 45000,
    internationalWeekendPrice: 230000,
    region: 'Jawa Tengah',
    description: 'Gunung Merbabu menawarkan jalur yang cukup menantang dengan pemandangan cantik.',
    mainImageUrl: 'https://images.unsplash.com/photo-1575573685828-7c1e20f05124?q=80&w=1331&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fDB8fHx8fA%3D%3Dhttps://picsum.photos/seed/merbabu/800/500',
  ),
];
