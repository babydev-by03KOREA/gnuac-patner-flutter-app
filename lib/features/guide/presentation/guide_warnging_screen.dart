import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patner_app/features/common/presentation/widgets/logo_header.dart';
import 'package:patner_app/features/daily_log/application/daily_log_controller.dart';

class GuideWarningScreen extends ConsumerWidget {
  const GuideWarningScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final log = ref.watch(dailyLogControllerProvider);

    // 여기서 log.checklist, log.weightKg 보고 메시지 간단 생성도 가능
    final hasWarning = log.checklist.q1 || log.checklist.q2 || log.checklist.q3;
    final text = hasWarning
        ? '오늘은 체크리스트에 주의 항목이 있어요.\n아래 내용을 꼭 읽어주세요.'
        : '오늘은 큰 이상 신호는 없어요.\n그래도 아래 주의사항을 참고해주세요.';

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const LogoHeader(
              title: '주의사항 안내페이지',
              subtitle: '추후 개선 예정',
            ),
            Card(
              color: Color(0xffC87D80),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),
                    // TODO: 여기에 정적 문구 / 그림 / 체크리스트 기반 가이드 넣기
                    const Text('여기에 Warning 텍스트들…'),
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
