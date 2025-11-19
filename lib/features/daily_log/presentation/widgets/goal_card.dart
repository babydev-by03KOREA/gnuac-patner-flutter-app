import 'package:flutter/material.dart';
import 'package:patner_app/features/daily_log/data/models/daily_log.dart';

class GoalCard extends StatelessWidget {
  const GoalCard({required this.log});
  final DailyLog log;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            _GoalItem(
              label: '목표칼로리',
              value: '${log.targetKcal} kcal',
            ),
            _GoalItem(
              label: '단백질',
              value: '${log.targetProtein} g',
            ),
            _GoalItem(
              label: '운동',
              value: log.exerciseDone ? 'O' : 'X',
            ),
          ],
        ),
      ),
    );
  }
}

class _GoalItem extends StatelessWidget {
  const _GoalItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                fontSize: 11,
                color: Colors.black.withOpacity(0.6),
              )),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
