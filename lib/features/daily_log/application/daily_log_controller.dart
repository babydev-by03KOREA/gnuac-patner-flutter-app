// Riverpod StateNotifier<DailyLog>
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:patner_app/features/daily_log/data/models/daily_log.dart';

final dailyLogControllerProvider =
    StateNotifierProvider.autoDispose<DailyLogController, DailyLog>((ref) {
      // 기본값(오늘 날짜, 기본 목표치) 세팅
      return DailyLogController(
        DailyLog(
          date: DateTime.now(),
          weightKg: 0,
          targetKcal: 100,
          targetProtein: 20,
          exerciseDone: false,
        ),
      );
    });

class DailyLogController extends StateNotifier<DailyLog> {
  DailyLogController(super.state);

  void updateWeight(double kg) {
    state = DailyLog(
      date: state.date,
      weightKg: kg,
      targetKcal: state.targetKcal,
      targetProtein: state.targetProtein,
      exerciseDone: state.exerciseDone,
      foods: state.foods,
      exercises: state.exercises,
      checklist: state.checklist,
    );
  }

  void addFood(FoodEntry entry) {
    state = DailyLog(
      date: state.date,
      weightKg: state.weightKg,
      targetKcal: state.targetKcal,
      targetProtein: state.targetProtein,
      exerciseDone: state.exerciseDone,
      foods: [...state.foods, entry],
      exercises: state.exercises,
      checklist: state.checklist,
    );
  }

  void addExercise(ExerciseEntry entry) {
    state = state.copyWith(
      exercises: [...state.exercises, entry],
      // 운동 기록이 하나라도 있으면 exerciseDone = true 로 자동 세팅하고 싶으면:
      exerciseDone: true,
    );
  }

  void updateChecklist(DailyChecklist checklist) {
    state = DailyLog(
      date: state.date,
      weightKg: state.weightKg,
      targetKcal: state.targetKcal,
      targetProtein: state.targetProtein,
      exerciseDone: state.exerciseDone,
      foods: state.foods,
      exercises: state.exercises,
      checklist: checklist,
    );
  }
}
