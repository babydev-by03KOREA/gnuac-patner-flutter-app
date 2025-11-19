import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' show ConsumerWidget, WidgetRef;
import 'package:patner_app/features/daily_log/application/daily_log_controller.dart';
import 'package:patner_app/features/daily_log/data/models/daily_log.dart';

class ExerciseSection extends ConsumerWidget {
  const ExerciseSection({required this.log});
  final DailyLog log;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Text(
                  '운동',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => _showAddExerciseSheet(context, ref),
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // 운동 리스트
            ...log.exercises.map(
                  (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Expanded(child: Text(e.description)),
                    Text(e.duration),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showAddExerciseSheet(BuildContext context, WidgetRef ref) {
  final descController = TextEditingController();
  final durationController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '운동 추가',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: '설명 (예: 산책)'),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: durationController,
              decoration: const InputDecoration(
                labelText: '시간 (예: 30분)',
              ),
            ),

            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final entry = ExerciseEntry(
                    description: descController.text.trim(),
                    duration: durationController.text.trim(),
                  );
                  ref.read(dailyLogControllerProvider.notifier).addExercise(entry);
                  Navigator.of(ctx).pop();
                },
                child: const Text('등록'),
              ),
            ),
          ],
        ),
      );
    },
  );
}
