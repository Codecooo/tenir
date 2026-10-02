import 'package:flutter_test/flutter_test.dart';
import 'package:tenir/models/mountain.dart';

void main() {
  test(
    'catalog mountains retain their local and international ticket prices',
    () {
      expect(
        sampleMountains
            .map((mountain) => mountain.indonesianWeekdayPrice)
            .toList(),
        [15000, 50000, 40000, 35000, 30000],
      );
      expect(
        sampleMountains
            .map((mountain) => mountain.internationalWeekendPrice)
            .toList(),
        [200000, 350000, 300000, 280000, 230000],
      );
    },
  );

  test('mountain retains the original transaction model fields', () {
    final mountain = Mountain(
      id: 'test',
      name: 'Test Mountain',
      location: 'Test Location',
      height: 1000,
      mainImageUrl: 'https://example.com/mountain.jpg',
      description: 'Test description',
      images: const [],
      basePrice: 10000,
    );

    expect(mountain.height, 1000);
    expect(mountain.mainImageUrl, 'https://example.com/mountain.jpg');
    expect(mountain.basePrice, 10000);
    expect(mountain.indonesianWeekdayPrice, 0);
    expect(mountain.internationalWeekdayPrice, 0);
  });
}
