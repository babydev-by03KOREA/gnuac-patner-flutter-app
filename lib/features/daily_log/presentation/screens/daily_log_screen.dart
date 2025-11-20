import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patner_app/app/theme.dart';
import 'package:patner_app/features/common/presentation/widgets/logo_header.dart';
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
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    // 앱 들어오면 오늘 날짜 기준으로 Supabase에서 기록 불러오기
    Future.microtask(() {
      ref.read(dailyLogControllerProvider.notifier).load();
    });
  }

  Future<void> _onSave() async {
    setState(() => _saving = true);
    try {
      await ref.read(dailyLogControllerProvider.notifier).save();
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('오늘 기록이 저장되었습니다.')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('저장 중 오류가 발생했습니다: $e')));
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final log = ref.watch(dailyLogControllerProvider);

    return GradientScaffold(
      extendBodyBehindAppBar: false,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const LogoHeader(),
                HeaderDateWeight(log: log),
                const SizedBox(height: 16),
                GoalCard(log: log),
                const SizedBox(height: 16),
                FoodSection(log: log),
                const SizedBox(height: 16),
                ExerciseSection(log: log),
                const SizedBox(height: 16),
                DiarySection(log: log),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saving ? null : _onSave,
                    child: _saving
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('오늘 기록 저장하기'),
                  ),
                ),

                if (_saving) Container(color: Colors.black.withOpacity(0.1)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
