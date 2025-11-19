import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patner_app/features/daily_log/application/daily_log_controller.dart';
import 'package:patner_app/features/daily_log/data/models/daily_log.dart';

class FoodSection extends ConsumerWidget {
  const FoodSection({required this.log});
  final DailyLog log;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalGram =
    log.foods.fold<int>(0, (sum, f) => sum + f.amountGram);
    final totalKcal = log.foods.fold<int>(0, (sum, f) => sum + f.kcal);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Text(
                  '음식',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                Text('$totalGram g / $totalKcal kcal'),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => _showAddFoodBottomSheet(context, ref),
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...log.foods.map(
                  (f) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Expanded(child: Text(f.name)),
                    Text('${f.amountGram} g / ${f.kcal} kcal'),
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

void _showAddFoodBottomSheet(BuildContext context, WidgetRef ref) {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final kcalController = TextEditingController();
  final proteinController = TextEditingController();

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
              '음식 추가',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: '음식명'),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: amountController,
                    keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: '섭취량',
                      suffixText: 'g',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: kcalController,
                    keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: '칼로리',
                      suffixText: 'kcal',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: proteinController,
              keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: '단백질',
                suffixText: 'g',
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final amount = int.tryParse(amountController.text) ?? 0;
                  final kcal = int.tryParse(kcalController.text) ?? 0;
                  final protein = int.tryParse(proteinController.text) ?? 0;

                  final entry = FoodEntry(
                    name: nameController.text.trim(),
                    amountGram: amount,
                    kcal: kcal,
                    proteinGram: protein,
                  );
                  ref
                      .read(dailyLogControllerProvider.notifier)
                      .addFood(entry);
                  Navigator.of(ctx).pop();
                },
                child: const Text('등록'),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      );
    },
  );
}

