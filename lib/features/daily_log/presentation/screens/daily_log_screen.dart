import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patner_app/app/theme.dart';
import 'package:patner_app/features/daily_log/application/daily_log_controller.dart';
import 'package:patner_app/features/daily_log/presentation/widgets/diary_section.dart';
import 'package:patner_app/features/daily_log/presentation/widgets/exercise_section.dart';
import 'package:patner_app/features/daily_log/presentation/widgets/food_section.dart';
import 'package:patner_app/features/daily_log/presentation/widgets/goal_card.dart';
import 'package:patner_app/features/daily_log/presentation/widgets/header_date_weight.dart';

class DailyLogScreen extends ConsumerStatefulWidget {
  const DailyLogScreen({super.key});

  @override
  ConsumerState<DailyLogScreen> createState() => _DailyLogScreenState();
}

class _DailyLogScreenState extends ConsumerState<DailyLogScreen> {
  @override
  Widget build(BuildContext context) {
    final log = ref.watch(dailyLogControllerProvider);

    return GradientScaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo.jpg', fit: BoxFit.contain, height: 50),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: false,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HeaderDateWeight(log: log),
                const SizedBox(height: 16),
                GoalCard(log: log),
                const SizedBox(height: 16),
                FoodSection(log: log),
                const SizedBox(height: 16),
                ExerciseSection(log: log),
                const SizedBox(height: 16),
                DiarySection(log: log),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
