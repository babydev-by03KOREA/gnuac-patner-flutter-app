import 'package:flutter/material.dart';

class LogoHeader extends StatelessWidget {
  const LogoHeader({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 로고 동그라미
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 1),
          ),
          alignment: Alignment.center,
          child: const Text('로고'),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
        const SizedBox(height: 16),
      ],
    );
  }
}
