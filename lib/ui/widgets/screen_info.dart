import 'package:flutter/material.dart';

/// Digunakan untuk mengidentifikasi ukuran layar saat ini. Widget ini akan membungkus [MaterialApp] dan menyediakan informasi apakah layar saat ini lebar atau sempit.
/// Cara menggunakannya adalah dengan memanggil `ScreenInfo.of(context).isWide` untuk mendapatkan nilai boolean yang menunjukkan apakah layar saat ini lebar atau sempit.
/// Terus ganti layout sesuai selera
class ScreenInfo extends InheritedWidget {
  final bool isWide;

  const ScreenInfo({
    required this.isWide,
    required super.child,
    super.key,
  });

  static ScreenInfo of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ScreenInfo>()!;

  @override
  bool updateShouldNotify(ScreenInfo old) => isWide != old.isWide;
}