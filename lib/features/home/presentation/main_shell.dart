import 'package:flutter/material.dart';
import 'package:patner_app/features/daily_log/presentation/screens/daily_log_screen.dart';
import 'package:patner_app/features/guide/presentation/guide_warnging_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  late final List<Widget> _pages = [
    const DailyLogScreen(),         // 1. 오늘 기록(1페이지)
    const GuideWarningScreen(),     // 2. 주의사항 가이드
    const GuideRecommendScreen(),   // 3. 추천/분석
    const GuideTextScreen(),        // 4. 설명/교육 텍스트
    const GuideAlarmScreen(),       // 5. 알림/설정 페이지
  ];

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
