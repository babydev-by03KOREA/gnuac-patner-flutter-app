import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patner_app/features/daily_log/application/daily_log_controller.dart';
import 'package:patner_app/features/daily_log/data/models/daily_log.dart';
import 'package:patner_app/features/daily_log/presentation/widgets/GoalEditableItem.dart';
import 'package:patner_app/features/daily_log/presentation/widgets/goal_editable_item_single.dart';

class GoalCard extends ConsumerWidget {
  const GoalCard({required this.log, super.key});
  final DailyLog log;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "오늘 목표",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                GoalEditableItem(
                  label: "칼로리",
                  left: "${log.todayKcal} kcal",
                  right: "${log.targetKcal} kcal",
                  onTap: () => _editGoal(context, ref, log),
                ),
                GoalEditableItem(
                  label: "단백질",
                  left: "${log.todayProtein} g",
                  right: "${log.targetProtein} g",
                  onTap: () => _editGoal(context, ref, log),
                ),
                GoalEditableItemSingle(
                  label: "운동",
                  value: log.exerciseDone ? "O" : "X",
                  onTap: () => _editExerciseGoal(context, ref, log),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _editGoal(BuildContext context, WidgetRef ref, DailyLog log) {
  final kcalCtrl = TextEditingController(text: log.targetKcal.toString());
  final proteinCtrl = TextEditingController(text: log.targetProtein.toString());

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('목표 수정'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: kcalCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: '목표 칼로리'),
          ),
          SizedBox(height: 20,),
          TextField(
            controller: proteinCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: '목표 단백질'),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("취소")),
        ElevatedButton(
          onPressed: () {
            ref.read(dailyLogControllerProvider.notifier).updateGoals(
              int.tryParse(kcalCtrl.text) ?? log.targetKcal,
              int.tryParse(proteinCtrl.text) ?? log.targetProtein,
            );
            Navigator.pop(context);
          },
          child: const Text('저장'),
        ),
      ],
    ),
  );
}

void _editExerciseGoal(BuildContext context, WidgetRef ref, DailyLog log) {
  bool goal = log.exerciseDone;

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("운동 목표 설정"),
      content: StatefulBuilder(
        builder: (context, setState) {
          return SwitchListTile(
            title: const Text("오늘 운동 목표"),
            value: goal,
            onChanged: (v) => setState(() => goal = v),
          );
        },
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("취소")),
        ElevatedButton(
          onPressed: () {
            ref.read(dailyLogControllerProvider.notifier).updateExerciseGoal(goal);
            Navigator.pop(context);
          },
          child: const Text("저장"),
        ),
      ],
    ),
  );
}
