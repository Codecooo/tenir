import 'package:flutter/material.dart';
import 'package:tenir/ui/widgets/screen_info.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key, 
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isWide = ScreenInfo.of(context).isWide;

    return Expanded(
      child: isWide ? Card(
        elevation: 0,
        color: color.withAlpha(22),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                  Text(label, style: Theme.of(context).textTheme.labelMedium),
                ],
              ),
            ],
          ),
        ),
      )

      // Mobile view
      : Card(
        elevation: 0,
        color: color.withAlpha(22),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 12),
              Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
              Text(label, style: Theme.of(context).textTheme.labelMedium),
            ],
          ),
        ),
      ),
    );
  }
}