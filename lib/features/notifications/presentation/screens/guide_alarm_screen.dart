import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/presentation/widgets/logo_header.dart';
import '../../application/alarm_controller.dart';

class GuideAlarmScreen extends ConsumerStatefulWidget {
  const GuideAlarmScreen({super.key});

  @override
  ConsumerState<GuideAlarmScreen> createState() => _GuideAlarmScreenState();
}

class _GuideAlarmScreenState extends ConsumerState<GuideAlarmScreen> {
  final _noticeController = TextEditingController();

  @override
  void dispose() {
    _noticeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final alarmState = ref.watch(alarmControllerProvider);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const LogoHeader(title: '알림함'),

            // ── 공지 입력 박스 ────────────────────────────────
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      '<공지>',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _noticeController,
                      minLines: 4,
                      maxLines: 6,
                      decoration: const InputDecoration(
                        hintText: '공지 내용을 입력해주세요',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          ref
                              .read(alarmControllerProvider.notifier)
                              .addAlarm(_noticeController.text);
                          _noticeController.clear();
                        },
                        child: const Text('알림 등록'),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ── 최근 알림 3가지 테이블 ────────────────────────
            Card(
              child: Column(
                children: [
                  // 헤더 행
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 28,
                          child: Icon(Icons.notifications_none, size: 20),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '알림 내용',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'YY.MM.D\nh:mm a',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  ),

                  // 데이터 행들
                  ...List.generate(3, (index) {
                    final item = index < alarmState.recent.length
                        ? alarmState.recent[index]
                        : null;

                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: index == 2
                                ? Colors.transparent
                                : Colors.grey.shade200,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 28,
                            child: Icon(Icons.notifications_none, size: 18),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item?.message ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 70,
                            child: Text(
                              item != null ? _formatTime(item.time) : '',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── 동기부여 푸시알림 ON/OFF ──────────────────────
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        '동기부여 푸시알림',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    // 디자인은 ON/OFF 버튼이지만 기능상은 Switch가 편해서 일단 이렇게
                    Switch(
                      value: alarmState.pushEnabled,
                      onChanged: (value) => ref
                          .read(alarmControllerProvider.notifier)
                          .togglePush(value),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final yy = time.year % 100;
    final mm = time.month.toString().padLeft(2, '0');
    final dd = time.day.toString().padLeft(2, '0');
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final min = time.minute.toString().padLeft(2, '0');
    final ampm = time.hour >= 12 ? 'PM' : 'AM';
    return '$yy.$mm.$dd\n$hour:$min $ampm';
  }
}
