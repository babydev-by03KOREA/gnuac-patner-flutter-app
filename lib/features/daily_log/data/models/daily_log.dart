// DailyLog, FoodEntry, ExerciseEntry..
class FoodEntry {
  final String name;
  final int amountGram; // 섭취량(g)
  final int kcal;
  final int proteinGram;

  FoodEntry({
    required this.name,
    required this.amountGram,
    required this.kcal,
    required this.proteinGram,
  });
}

class ExerciseEntry {
  final String description; // 산책 30분, 터그놀이 20분..
  final String duration; // "30분", "20분" ..

  ExerciseEntry({required this.description, required this.duration});
}

class DailyChecklist {
  final bool q1, q2, q3, q4, q5;
  final String memo;
  const DailyChecklist({
    this.q1 = false,
    this.q2 = false,
    this.q3 = false,
    this.q4 = false,
    this.q5 = false,
    this.memo = '',
  });

  DailyChecklist copyWith({
    bool? q1,
    bool? q2,
    bool? q3,
    bool? q4,
    bool? q5,
    String? memo,
  }) {
    return DailyChecklist(
      q1: q1 ?? this.q1,
      q2: q2 ?? this.q2,
      q3: q3 ?? this.q3,
      q4: q4 ?? this.q4,
      q5: q5 ?? this.q5,
      memo: memo ?? this.memo,
    );
  }
}

class DailyLog {
  final DateTime date;
  final double weightKg;
  final int targetKcal;
  final int targetProtein;
  final bool exerciseDone;
  final List<FoodEntry> foods;
  final List<ExerciseEntry> exercises;
  final DailyChecklist checklist;

  const DailyLog({
    required this.date,
    required this.weightKg,
    required this.targetKcal,
    required this.targetProtein,
    required this.exerciseDone,
    this.foods = const [],
    this.exercises = const [],
    this.checklist = const DailyChecklist(),
  });

  DailyLog copyWith({
    DateTime? date,
    double? weightKg,
    int? targetKcal,
    int? targetProtein,
    bool? exerciseDone,
    List<FoodEntry>? foods,
    List<ExerciseEntry>? exercises,
    DailyChecklist? checklist,
  }) {
    return DailyLog(
      date: date ?? this.date,
      weightKg: weightKg ?? this.weightKg,
      targetKcal: targetKcal ?? this.targetKcal,
      targetProtein: targetProtein ?? this.targetProtein,
      exerciseDone: exerciseDone ?? this.exerciseDone,
      foods: foods ?? this.foods,
      exercises: exercises ?? this.exercises,
      checklist: checklist ?? this.checklist,
    );
  }
}