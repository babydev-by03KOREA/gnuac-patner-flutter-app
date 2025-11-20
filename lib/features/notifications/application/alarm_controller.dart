import 'package:flutter_riverpod/legacy.dart';

class AlarmItem {
  final String message;
  final DateTime time;

  AlarmItem({required this.message, required this.time});
}

class AlarmState {
  final List<AlarmItem> recent;
  final bool pushEnabled;

  const AlarmState({
    this.recent = const [],
    this.pushEnabled = false,
  });

  AlarmState copyWith({
    List<AlarmItem>? recent,
    bool? pushEnabled,
  }) {
    return AlarmState(
      recent: recent ?? this.recent,
      pushEnabled: pushEnabled ?? this.pushEnabled,
    );
  }
}

class AlarmController extends StateNotifier<AlarmState> {
  AlarmController() : super(const AlarmState());

  /// 공지 텍스트로 알림 하나 추가 (최대 3개 유지)
  void addAlarm(String message) {
    if (message.trim().isEmpty) return;

    final now = DateTime.now();
    final newItem = AlarmItem(message: message.trim(), time: now);

    final updated = [newItem, ...state.recent];
    // 최근 3개만 남기기
    final limited = updated.length > 3 ? updated.sublist(0, 3) : updated;

    state = state.copyWith(recent: limited);
  }

  void togglePush(bool enabled) {
    state = state.copyWith(pushEnabled: enabled);
  }
}

final alarmControllerProvider =
StateNotifierProvider<AlarmController, AlarmState>(
      (ref) => AlarmController(),
);
