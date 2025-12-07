// DailyLog, FoodEntry, ExerciseEntry..
import 'package:patner_app/features/daily_log/data/models/exercise_type.dart';

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

  factory FoodEntry.fromJson(Map<String, dynamic> json) {
    return FoodEntry(
      name: json['food_name'] as String? ?? '',
      amountGram: json['amount_gram'] as int? ?? 0,
      kcal: json['kcal'] as int? ?? 0,
      proteinGram: json['protein'] as int? ?? 0,
    );
  }
}

class ExerciseEntry {
  final String description; // 산책 30분, 터그놀이 20분..
  final String duration; // "30분", "20분" ..
  final ExerciseType type;

  ExerciseEntry({
    required this.description,
    required this.duration,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
    'description': description,
    'duration': duration,
    'type': type.name, // Supabase에 문자열로 저장
  };

  factory ExerciseEntry.fromJson(Map<String, dynamic> json) {
    return ExerciseEntry(
      description: json['description'] as String,
      duration: json['duration'] as String,
      type: ExerciseTypeInfo.fromName(json['type'] as String?),
    );
  }
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

  // 오늘 값
  final int todayKcal;
  final int todayProtein;

  // 리스트들
  final List<FoodEntry> foods;
  final List<ExerciseEntry> exercises;

  final DailyChecklist checklist;
  final String memo;

  const DailyLog({
    required this.date,
    required this.weightKg,
    required this.targetKcal,
    required this.targetProtein,
    required this.exerciseDone,
    this.todayKcal = 0,
    this.todayProtein = 0,
    this.foods = const [],
    this.exercises = const [],
    this.checklist = const DailyChecklist(),
    this.memo = '',
  });

  DailyLog copyWith({
    DateTime? date,
    double? weightKg,
    int? targetKcal,
    int? targetProtein,
    bool? exerciseDone,
    int? todayKcal,
    int? todayProtein,
    List<FoodEntry>? foods,
    List<ExerciseEntry>? exercises,
    DailyChecklist? checklist,
    String? memo,
  }) {
    return DailyLog(
      date: date ?? this.date,
      weightKg: weightKg ?? this.weightKg,
      targetKcal: targetKcal ?? this.targetKcal,
      targetProtein: targetProtein ?? this.targetProtein,
      exerciseDone: exerciseDone ?? this.exerciseDone,
      todayKcal: todayKcal ?? this.todayKcal,
      todayProtein: todayProtein ?? this.todayProtein,
      foods: foods ?? this.foods,
      exercises: exercises ?? this.exercises,
      checklist: checklist ?? this.checklist,
      memo: memo ?? this.memo,
    );
  }
}