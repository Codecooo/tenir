/// Model untuk pendaki gunung. Ini berbeda dengan user karena user bisa saja bukan pendaki gunung, misal admin atau guide.
/// Atau pendaki gunung yang belum mendaftar di aplikasi ini.
class Hiker {
  final String id;
  final String firstName;
  final String lastName;
  final String identityNumber; // NIK / Passport
  final String phoneNumber;
  final String emergencyContactPhone;
  final String? medicalNotes;

  Hiker({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.identityNumber,
    required this.phoneNumber,
    required this.emergencyContactPhone,
    this.medicalNotes,
  });
}