import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patner_app/features/daily_log/application/daily_log_controller.dart';
import 'package:patner_app/features/daily_log/data/models/daily_log.dart';

class DiarySection extends ConsumerWidget {
  const DiarySection({required this.log});
  final DailyLog log;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = log.checklist;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '일지',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),

            // 체크리스트 5개
            _ChecklistItem(
              label: '1. 하루 체중감량이 0.1~0.3kg 초과하나요?',
              value: c.q1,
              onChanged: (v) => _updateChecklist(ref, log, c.copyWith(q1: v)),
            ),
            _ChecklistItem(
              label: '2. 물 또는 식사를 지나치게 안 먹으려 하나요?',
              value: c.q2,
              onChanged: (v) => _updateChecklist(ref, log, c.copyWith(q2: v)),
            ),
            _ChecklistItem(
              label: '3. 평소보다 무기력하거나 활동력이 떨어졌나요?',
              value: c.q3,
              onChanged: (v) => _updateChecklist(ref, log, c.copyWith(q3: v)),
            ),
            _ChecklistItem(
              label: '4. 설사/변비/혈변 또는 소변문제는 없나요?',
              value: c.q4,
              onChanged: (v) => _updateChecklist(ref, log, c.copyWith(q4: v)),
            ),
            _ChecklistItem(
              label: '5. 털빠짐/숨기/피부문제/기타 이상 증상은 없나요?',
              value: c.q5,
              onChanged: (v) => _updateChecklist(ref, log, c.copyWith(q5: v)),
            ),

            const SizedBox(height: 16),

            const Text(
              'MEMO',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),

            TextField(
              maxLines: 3,
              controller: TextEditingController(text: c.memo),
              decoration: const InputDecoration(
                hintText: '자유롭게 메모를 남겨주세요',
              ),
              onChanged: (v) =>
                  _updateChecklist(ref, log, c.copyWith(memo: v)),
            ),
          ],
        ),
      ),
    );
  }

  void _updateChecklist(WidgetRef ref, DailyLog log, DailyChecklist newChecklist) {
    ref.read(dailyLogControllerProvider.notifier).updateChecklist(newChecklist);
  }
}

class _ChecklistItem extends StatelessWidget {
  const _ChecklistItem({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 13),
          ),
        ),
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

