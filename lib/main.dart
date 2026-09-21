import 'package:flutter/material.dart';
import 'package:tenir/ui/transaction/transaction_screen.dart';
import 'package:tenir/ui/widgets/screen_info.dart';
import 'ui/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final isWide = constraints.maxWidth > 350;
        return ScreenInfo(
          isWide: isWide,
          child: MaterialApp(
            title: 'Tenir',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(30, 97, 168, 232),
              ),
            ),
            home: HomePage(),
          ),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;
  var expanded = false;
  
  @override
  Widget build(BuildContext context) {
    Widget page;

    /// Ini digunakan untuk menampilkan halaman yang sesuai dengan index yang dipilih pada NavigationRail atau NavigationBar. 
    /// Kalau ingin menambahkan halaman baru, cukup tambahkan case baru di switch statement ini.
    /// Untuk halaman baru, buat widget baru di folder lib/ui/nama_komponen dan import di sini. Ganti placeholder() dengan widget baru tersebut.
    switch (selectedIndex) {
      case 0:
        page = HomeScreen();
        break;
      case 1:
        page = TransactionScreen();
        break;
      case 2:
        page = Placeholder();
        break;
      default:
        page = Placeholder();
    }

    // Bisa diperhatikan cara memakai ScreenInfo.of(context) untuk mendapatkan informasi apakah layar lebar atau tidak. 
    // Ini digunakan untuk menampilkan NavigationRail di desktop dan NavigationBar di mobile.
    final isWide = ScreenInfo.of(context).isWide;

    return Scaffold(
      body: Row(
        children: [
          /// Navbar desktop
          if (isWide)
            NavigationRail(
              selectedIndex: selectedIndex,
              extended: expanded,
              minExtendedWidth: 200,
              onDestinationSelected: (value) => setState(() {
                selectedIndex = value;
              }),
              leading: IconButton(
                onPressed: () => {
                  setState(() {
                    expanded = !expanded;
                  }),
                },
                icon: const Icon(Icons.menu),
              ),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home_rounded),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.receipt_long_rounded),
                  label: Text('Transaksi'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person_rounded),
                  label: Text('Profil'),
                ),
              ],
            ),
          Expanded(
            child: SafeArea(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ),
        ],
      ),

      /// Navbar mobile
      bottomNavigationBar: isWide
          ? null
          : NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) => setState(() {
                selectedIndex = value;
              }),
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_rounded),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.receipt),
                  label: 'Transaksi',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_rounded),
                  label: 'Profil',
                ),
              ],
            ),
    );
  }
}