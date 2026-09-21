class Travel {
  final String id;
  final String name;
  final String location;
  final String description;
  final String region;
  final int pricePerPerson;

  Travel({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.region,
    required this.pricePerPerson,
  });
}

// ===== SAMPLE DATA TRAVEL =====
final List<Travel> sampleTravels = [
  Travel(
    id: '1',
    name: 'Gunung Sindoro',
    location: 'Perhutani',
    description: 'Gunung Sindoro adalah salah satu gunung kembar di Jawa Tengah dengan pemandangan yang memukau.',
    region: 'JAWA TENGAH',
    pricePerPerson: 150000,
  ),
  Travel(
    id: '2',
    name: 'Gunung Merbabu',
    location: 'Jawa Tengah',
    description: 'Gunung Merbabu menawarkan jalur pendakian yang cukup menantang dengan pemandangan cantik di puncaknya.',
    region: 'JAWA TENGAH',
    pricePerPerson: 120000,
  ),
  Travel(
    id: '3',
    name: 'Gunung Lawu',
    location: 'Perhutani',
    description: 'Gunung Lawu adalah gunung tertua di Jawa dengan nilai spiritual yang tinggi.',
    region: 'JAWA TENGAH',
    pricePerPerson: 100000,
  ),
  Travel(
    id: '4',
    name: 'Gunung Semeru',
    location: 'Jawa Timur',
    description: 'Gunung Semeru adalah gunung tertinggi di Jawa dengan pemandangan yang spektakuler.',
    region: 'JAWA TIMUR',
    pricePerPerson: 200000,
  ),
  Travel(
    id: '5',
    name: 'Gunung Bromo',
    location: 'Jawa Timur',
    description: 'Gunung Bromo terkenal dengan pemandangan sunrise yang menakjubkan dari Penanjakan.',
    region: 'JAWA TIMUR',
    pricePerPerson: 180000,
  ),
];