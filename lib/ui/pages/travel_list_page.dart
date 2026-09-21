import 'package:flutter/material.dart';
import 'package:tenir/models/travel_model.dart';
import 'travel_detail_page.dart';

class TravelListPage extends StatefulWidget {
  const TravelListPage({Key? key}) : super(key: key);

  @override
  State<TravelListPage> createState() => _TravelListPageState();
}

class _TravelListPageState extends State<TravelListPage> {
  final Color primaryColor = const Color(0xFF2D6A4F);
  final Color accentColor = const Color(0xFFFFA500);
  final Color lightBg = const Color(0xFFF5F5F5);
  final Color cardBg = Colors.white;

  List<Travel> hasilPencarian = [];
  TextEditingController controllerSearch = TextEditingController();
  String selectedRegion = 'SEMUA PROVINSI';

  final List<String> regions = [
    'SEMUA PROVINSI',
    'JAWA TIMUR',
    'JAWA TENGAH',
  ];

  @override
  void initState() {
    super.initState();
    hasilPencarian = sampleTravels;
  }

  void cariTravel(String teks) {
    List<Travel> tampung = [];

    if (teks.isEmpty) {
      tampung = sampleTravels;
    } else {
      for (var travel in sampleTravels) {
        String namaTravel = travel.name.toLowerCase();
        if (namaTravel.contains(teks.toLowerCase())) {
          tampung.add(travel);
        }
      }
    }

    List<Travel> hasil = [];
    for (var travel in tampung) {
      if (selectedRegion == 'SEMUA PROVINSI' ||
          travel.region == selectedRegion) {
        hasil.add(travel);
      }
    }

    setState(() {
      hasilPencarian = hasil;
    });
  }

  String formatUang(int angka) {
    String hasil = angka.toString();
    String hasilBaru = "";
    int hitung = 0;

    for (int i = hasil.length - 1; i >= 0; i--) {
      hasilBaru = hasil[i] + hasilBaru;
      hitung++;
      if (hitung % 3 == 0 && i != 0) {
        hasilBaru = "." + hasilBaru;
      }
    }
    return hasilBaru;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBg,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Pesan Travel",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // ===== SEARCH BAR =====
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controllerSearch,
              onChanged: (value) {
                cariTravel(value);
              },
              decoration: InputDecoration(
                hintText: "Cari travel...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: cardBg,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // ===== FILTER DROPDOWN =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: DropdownButton<String>(
                    value: selectedRegion,
                    underline: const SizedBox.shrink(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedRegion = value ?? 'SEMUA PROVINSI';
                        cariTravel(controllerSearch.text);
                      });
                    },
                    items: regions.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // ===== LIST TRAVEL =====
          hasilPencarian.isEmpty
              ? const Expanded(
                  child: Center(child: Text("Travel tidak ditemukan")))
              : Expanded(
                  child: ListView.builder(
                    itemCount: hasilPencarian.length,
                    itemBuilder: (context, index) {
                      var travel = hasilPencarian[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TravelDetailPage(travel: travel),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: cardBg,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ===== FOTO =====
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                child: Container(
                                  height: 200,
                                  width: double.infinity,
                                  color: Colors.grey[300],
                                  child: Icon(
                                    Icons.landscape,
                                    size: 80,
                                    color: primaryColor,
                                  ),
                                ),
                              ),

                              // ===== INFO =====
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // ===== NAMA & RATING =====
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            travel.name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    // ===== LOKASI =====
                                    Text(
                                      travel.location,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 13,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    // ===== HARGA =====
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Harga per orang:',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        Text(
                                          'Rp ${formatUang(travel.pricePerPerson)}',
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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