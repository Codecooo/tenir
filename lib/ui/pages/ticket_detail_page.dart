import 'package:flutter/material.dart';
import 'package:tenir/models/ticket_model.dart';

class TicketDetailPage extends StatefulWidget {
  final Mountain mountain;

  const TicketDetailPage({Key? key, required this.mountain}) : super(key: key);

  @override
  State<TicketDetailPage> createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends State<TicketDetailPage> {
  final Color primaryColor = const Color(0xFF2D6A4F); // Hijau gelap
  final Color accentColor = const Color(0xFFFFA500); // Orange

  String selectedType = 'WNI'; // WNI atau WNA
  bool isWeekend = false;
  int quantity = 1;

  // ===== DATE PICKER =====
  DateTime? tanggalMasuk;
  DateTime? tanggalKeluar;

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

  String formatTanggal(DateTime? date) {
    if (date == null) return '-';
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _selectDateMasuk() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025, 12, 31),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != tanggalMasuk) {
      setState(() {
        tanggalMasuk = picked;
        // Reset tanggal keluar jika lebih awal dari tanggal masuk
        if (tanggalKeluar != null && tanggalKeluar!.isBefore(tanggalMasuk!)) {
          tanggalKeluar = null;
        }
      });
    }
  }

  Future<void> _selectDateKeluar() async {
    if (tanggalMasuk == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih tanggal masuk terlebih dahulu')),
      );
      return;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: tanggalMasuk!.add(const Duration(days: 1)),
      firstDate: tanggalMasuk!.add(const Duration(days: 1)),
      lastDate: DateTime(2025, 12, 31),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != tanggalKeluar) {
      setState(() {
        tanggalKeluar = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(widget.mountain.name, style: TextStyle(color: Colors.white),),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== GAMBAR GUNUNG =====
            Image.network(
              widget.mountain.imageUrl,
              height: 400,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  height: 400,
                  color: Colors.grey[300],
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 400,
                  color: Colors.grey[300],
                  child: Icon(Icons.landscape, size: 80, color: primaryColor),
                );
              },
            ),

            // ===== HEADER WITH DESCRIPTION =====
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.mountain.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        widget.mountain.location,
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.mountain.description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // ===== TYPE SELECTION =====
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tipe Pengunjung',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildTypeButton('WNI'),
                      const SizedBox(width: 12),
                      _buildTypeButton('WNA'),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(),

            // ===== TANGGAL MASUK =====
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pos Perizinan Masuk',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: _selectDateMasuk,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Tanggal Masuk',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                tanggalMasuk == null
                                    ? 'Pilih tanggal'
                                    : formatTanggal(tanggalMasuk),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.calendar_today,
                            color: primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(),

            // ===== TANGGAL KELUAR =====
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pos Perizinan Keluar',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: _selectDateKeluar,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: tanggalMasuk == null
                              ? Colors.grey[300]!
                              : primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Tanggal Keluar',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                tanggalKeluar == null
                                    ? 'Pilih tanggal'
                                    : formatTanggal(tanggalKeluar),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: tanggalMasuk == null
                                      ? Colors.grey
                                      : primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.calendar_today,
                            color: tanggalMasuk == null
                                ? Colors.grey[300]
                                : primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(),

            // ===== WEEKEND TOGGLE =====
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Hari Libur',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Switch(
                    value: isWeekend,
                    onChanged: (value) {
                      setState(() {
                        isWeekend = value;
                      });
                    },
                    activeColor: primaryColor,
                  ),
                ],
              ),
            ),

            const Divider(),

            // ===== QUANTITY =====
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Jumlah Pemesan',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (quantity > 1) quantity--;
                          });
                        },
                        icon: const Icon(Icons.remove),
                        color: primaryColor,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          quantity.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        icon: const Icon(Icons.add),
                        color: primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(),

            // ===== PRICE INFO =====
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Harga per orang:',
                          style: TextStyle(fontSize: 13, color: Colors.black87),
                        ),
                        Text(
                          'Rp ${formatUang(_getPrice())}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          'Rp ${formatUang((_getPrice() * quantity).toInt())}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ===== BOOKING BUTTON =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (tanggalMasuk == null || tanggalKeluar == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Silahkan pilih tanggal masuk dan tanggal keluar'),
                        ),
                      );
                      return;
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Pesan $quantity tiket untuk ${widget.mountain.name}\nTanggal: ${formatTanggal(tanggalMasuk)} - ${formatTanggal(tanggalKeluar)}\nTotal: Rp ${formatUang((_getPrice() * quantity).toInt())}',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Lanjutkan ke Pembayaran',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeButton(String type) {
    final isSelected = selectedType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedType = type;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            type,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  int _getPrice() {
    if (selectedType == 'WNI') {
      return isWeekend
          ? widget.mountain.wniWeekendPrice
          : widget.mountain.wniPrice;
    } else {
      return isWeekend
          ? widget.mountain.wnaWeekendPrice
          : widget.mountain.wnaPrice;
    }
  }
}
