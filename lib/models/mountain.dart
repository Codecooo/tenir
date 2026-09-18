/// Pakai model ini untuk menampung data gunung yang akan ditampilkan di aplikasi.
class Mountain {
  final String id;
  final String name;
  final String location;
  final double height;
  final String mainImageUrl;
  final String description;
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