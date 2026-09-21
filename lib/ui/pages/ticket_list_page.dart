import 'package:flutter/material.dart';
import 'package:tenir/models/ticket_model.dart';
import 'ticket_detail_page.dart';

class TicketListPage extends StatefulWidget {
  const TicketListPage({Key? key}) : super(key: key);

  @override
  State<TicketListPage> createState() => _TicketListPageState();
}

class _TicketListPageState extends State<TicketListPage> {
  // ===== COLOR SCHEME (SAMA SEPERTI HOME) =====
  final Color primaryColor = const Color(0xFF2D6A4F); // Hijau gelap
  final Color accentColor = const Color(0xFFFFA500); // Orange
  final Color lightBg = const Color(0xFFF5F5F5); // Abu-abu terang
  final Color cardBg = Colors.white;

  List<Mountain> hasilPencarian = [];
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
    hasilPencarian = sampleMountains;
  }

  void cariGunung(String teks) {
    List<Mountain> tampung = [];

    if (teks.isEmpty) {
      tampung = sampleMountains;
    } else {
      for (var mountain in sampleMountains) {
        String namaGunung = mountain.name.toLowerCase();
        if (namaGunung.contains(teks.toLowerCase())) {
          tampung.add(mountain);
        }
      }
    }

    // Filter berdasarkan region
    List<Mountain> hasil = [];
    for (var mountain in tampung) {
      if (selectedRegion == 'SEMUA PROVINSI' ||
          mountain.region.toUpperCase() == selectedRegion) {
        hasil.add(mountain);
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
      backgroundColor: lightBg, // ✅ FIXED: Sama dengan home_screen
      appBar: AppBar(
        backgroundColor: primaryColor, // ✅ FIXED: Hijau gelap seperti home
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Pesan Tiket Masuk",
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
                cariGunung(value);
              },
              decoration: InputDecoration(
                hintText: "Cari nama gunung...",
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
                        cariGunung(controllerSearch.text);
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

          // ===== LIST GUNUNG =====
          hasilPencarian.isEmpty
              ? const Expanded(
                  child: Center(child: Text("Gunung tidak ditemukan")))
              : Expanded(
                  child: ListView.builder(
                    itemCount: hasilPencarian.length,
                    itemBuilder: (context, index) {
                      var gunung = hasilPencarian[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TicketDetailPage(mountain: gunung),
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
                                            gunung.name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: accentColor,
                                              size: 18,
                                            ),
                                            const SizedBox(width: 3),
                                            const Text(
                                              "4.8",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    // ===== PENGELOLA =====
                                    Text(
                                      gunung.location,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 13,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    // ===== TARIF WNI =====
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Tarif Hari Kerja (WNI)",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              Text(
                                                "Rp ${formatUang(gunung.wniPrice)}",
                                                style: TextStyle(
                                                  color: primaryColor, // ✅ FIXED: primaryColor
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Tarif Hari Libur (WNI)",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              Text(
                                                "Rp ${formatUang(gunung.wniWeekendPrice)}",
                                                style: TextStyle(
                                                  color: primaryColor, // ✅ FIXED: primaryColor
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 8),

                                    // ===== TARIF WNA =====
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Tarif Hari Kerja (WNA)",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              Text(
                                                "Rp ${formatUang(gunung.wnaPrice)}",
                                                style: TextStyle(
                                                  color: primaryColor, // ✅ FIXED: primaryColor
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Tarif Hari Libur (WNA)",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              Text(
                                                "Rp ${formatUang(gunung.wnaWeekendPrice)}",
                                                style: TextStyle(
                                                  color: primaryColor, // ✅ FIXED: primaryColor
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 10),

                                    // ===== TOMBOL PESAN =====
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TicketDetailPage(
                                                      mountain: gunung),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor, // ✅ FIXED: primaryColor bukan green
                                        ),
                                        child: const Text(
                                          "Pesan Tiket",
                                          style: TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
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
