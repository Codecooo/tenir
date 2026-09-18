import 'package:flutter/material.dart';

/// Digunakan untuk mengidentifikasi ukuran layar saat ini. Widget ini akan membungkus [MaterialApp] dan menyediakan informasi apakah layar saat ini lebar atau sempit.
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