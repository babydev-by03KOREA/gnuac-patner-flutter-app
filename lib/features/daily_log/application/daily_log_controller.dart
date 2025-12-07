// Riverpod StateNotifier<DailyLog>
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:patner_app/core/providers/supabase_client_provider.dart';
import 'package:patner_app/features/daily_log/data/daily_log_repository.dart';
import 'package:patner_app/features/daily_log/data/models/daily_log.dart';
import 'package:patner_app/features/daily_log/data/daily_log_repository.dart';

final dailyLogControllerProvider =
StateNotifierProvider.autoDispose<DailyLogController, DailyLog>((ref) {
  final repo = ref.watch(dailyLogRepositoryProvider);
  final today = DateTime.now();
  final controller = DailyLogController(repo, today);
  // controller.load(); // 오늘 데이터 로딩
  return controller;
});

class DailyLogController extends StateNotifier<DailyLog> {
  DailyLogController(this._repo, DateTime date)
      : super(DailyLog(
    date: date,
    weightKg: 0,
    targetKcal: 100,
    targetProtein: 20,
    exerciseDone: false,
  ));

  final DailyLogRepository _repo;

  Future<void> load() async {
    final data = await _repo.fetch(state.date);
    if (data != null) state = data;
  }

  Future<void> save() async {
    await _repo.save(state);
  }

  void addExercise(ExerciseEntry entry) {
    state = state.copyWith(
      exercises: [...state.exercises, entry],
      exerciseDone: true,
    );
    // 필요하면 여기서 바로 save() 호출하거나, 상단 저장 버튼에서만 저장
  }

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
    // 1) 새로 추가된 음식까지 포함한 리스트
    final updatedFoods = [...state.foods, entry];

    // 2) 오늘 총 칼로리 / 단백질 계산
    final todayKcal =
    updatedFoods.fold<int>(0, (sum, f) => sum + f.kcal);
    final todayProtein =
    updatedFoods.fold<int>(0, (sum, f) => sum + f.proteinGram);

    // 3) 상태 업데이트
    state = state.copyWith(
      foods: updatedFoods,
      todayKcal: todayKcal,
      todayProtein: todayProtein,
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

  void updateGoals(int kcal, int protein) {
    state = state.copyWith(
      targetKcal: kcal,
      targetProtein: protein,
    );
  }

  void updateExerciseGoal(bool goal) {
    state = state.copyWith(
      exerciseDone: goal,
    );
  }
}

final dailyLogRepositoryProvider = Provider<DailyLogRepository>((ref) {
  final client = ref.watch(supabaseProvider);
  return DailyLogRepository(client);
});
