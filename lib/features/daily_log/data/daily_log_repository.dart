// lib/features/daily_log/data/daily_log_repository.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:patner_app/core/providers/supabase_client_provider.dart';
import 'models/daily_log.dart';

class DailyLogRepository {
  DailyLogRepository(this.client);

  final SupabaseClient client;

  // ---------- Fetch (하루치 가져오기) ----------
  Future<DailyLog?> fetch(DateTime date) async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return null;

    final dateStr = date.toIso8601String().substring(0, 10); // YYYY-MM-DD

    final res = await client
        .from('daily_logs')
        .select('''
          id,
          date,
          weight_kg,
          today_kcal,
          today_protein,
          target_kcal,
          target_protein,
          exercise_goal,
          exercise_done,
          memo,
          checklist_q1,
          checklist_q2,
          checklist_q3,
          checklist_q4,
          checklist_q5,
          checklist_q6,
          food_logs(*),
          exercise_logs(*)
        ''')
        .eq('user_id', userId)
        .eq('date', dateStr)
        .maybeSingle();

    if (res == null) return null;

    final foods = ((res['food_logs'] as List?) ?? [])
        .map((row) => FoodEntry.fromJson(row as Map<String, dynamic>))
        .toList();

    final exercises = ((res['exercise_logs'] as List?) ?? [])
        .map((row) => ExerciseEntry.fromJson(row as Map<String, dynamic>))
        .toList();

    final checklist = DailyChecklist(
      q1: res['checklist_q1'] as bool? ?? false,
      q2: res['checklist_q2'] as bool? ?? false,
      q3: res['checklist_q3'] as bool? ?? false,
      q4: res['checklist_q4'] as bool? ?? false,
      q5: res['checklist_q5'] as bool? ?? false,
    );

    return DailyLog(
      date: DateTime.parse(res['date'] as String),
      weightKg: (res['weight_kg'] as num?)?.toDouble() ?? 0,
      todayKcal: res['today_kcal'] as int? ?? 0,
      todayProtein: res['today_protein'] as int? ?? 0,
      targetKcal: res['target_kcal'] as int? ?? 100,
      targetProtein: res['target_protein'] as int? ?? 20,
      exerciseDone: res['exercise_goal'] as bool? ?? false,
      memo: res['memo'] as String? ?? '',
      foods: foods,
      exercises: exercises,
      checklist: checklist,
    );
  }

  // ---------- Save (upsert + 하위 로그 재삽입) ----------
  Future<void> save(DailyLog log) async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('로그인 정보가 없습니다.');
    }

    final dateStr = log.date.toIso8601String().substring(0, 10);

    // daily_logs upsert
    final dailyLogRow = await client
        .from('daily_logs')
        .upsert({
          'user_id': userId,
          'date': dateStr,
          'weight_kg': log.weightKg,
          'today_kcal': log.todayKcal,
          'today_protein': log.todayProtein,
          'target_kcal': log.targetKcal,
          'target_protein': log.targetProtein,
          'exercise_done': log.exerciseDone,
          'memo': log.memo,
          'checklist_q1': log.checklist?.q1 ?? false,
          'checklist_q2': log.checklist?.q2 ?? false,
          'checklist_q3': log.checklist?.q3 ?? false,
          'checklist_q4': log.checklist?.q4 ?? false,
          'checklist_q5': log.checklist?.q5 ?? false,
        }, onConflict: 'user_id,date')
        .select()
        .single();

    final dailyLogId = dailyLogRow['id'] as int;

    // food_logs 초기화 후 다시 insert
    await client.from('food_logs').delete().eq('daily_log_id', dailyLogId);
    for (final f in log.foods) {
      await client.from('food_logs').insert({
        'daily_log_id': dailyLogId,
        'food_name': f.name,
        'kcal': f.kcal,
        'protein': f.proteinGram,
      });
    }

    // exercise_logs 초기화 후 다시 insert
    await client.from('exercise_logs').delete().eq('daily_log_id', dailyLogId);
    for (final e in log.exercises) {
      await client.from('exercise_logs').insert({
        'daily_log_id': dailyLogId,
        'description': e.description,
        'duration': e.duration,
        'type': e.type.name, // ExerciseType enum 문자열
      });
    }
  }
}

// ---------- Repository Provider ----------
final dailyLogRepositoryProvider = Provider<DailyLogRepository>((ref) {
  final client = ref.watch(supabaseProvider);
  return DailyLogRepository(client);
});
