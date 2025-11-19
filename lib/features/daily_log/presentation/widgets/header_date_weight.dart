import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patner_app/features/daily_log/application/daily_log_controller.dart';
import 'package:patner_app/features/daily_log/data/models/daily_log.dart';

class HeaderDateWeight extends ConsumerWidget {
  const HeaderDateWeight({required this.log});

  final DailyLog log;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateStr =
        '${log.date.year}/${log.date.month.toString().padLeft(2, '0')}/${log.date.day.toString().padLeft(2, '0')}';

    final weightController = TextEditingController(
      text: log.weightKg == 0 ? '' : log.weightKg.toString(),
    );

    return Row(
      children: [
        Text(
          dateStr,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        ),
        const Spacer(),
        SizedBox(
          width: 80,
          child: TextField(
            controller: weightController,
            textAlign: TextAlign.right,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              hintText: '0.0',
              suffixText: 'kg',
            ),
            onSubmitted: (v) {
              final kg = double.tryParse(v) ?? 0;
              ref.read(dailyLogControllerProvider.notifier).updateWeight(kg);
            },
          ),
        ),
      ],
    );
  }
}
