import 'package:flutter/material.dart';
import 'package:patner_app/app/theme.dart';
import 'package:patner_app/features/daily_log/presentation/screens/daily_log_screen.dart';
import 'package:patner_app/features/guide/presentation/guide_text_screen.dart';
import 'package:patner_app/features/guide/presentation/guide_warnging_screen.dart';
import 'package:patner_app/features/notifications/presentation/screens/guide_alarm_screen.dart';
import 'package:patner_app/features/recommend/presentation/screens/guide_recommend_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  late final List<Widget> _pages = [
    const DailyLogScreen(), // 1. 오늘 기록(1페이지)
    const GuideWarningScreen(), // 2. 주의사항 가이드
    const GuideRecommendScreen(), // 3. 추천/분석
    const GuideTextScreen(), // 4. 설명/교육 텍스트
    const GuideAlarmScreen(), // 5. 알림/설정 페이지
  ];

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: null,
      extendBodyBehindAppBar: false,
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/dog_icon.jpeg', width: 30,),
            label: '기록', // 1페이지
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/exclamation_icon.jpeg', width: 30,),
            label: '주의', // 2페이지
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/shop_icon.jpeg', width: 30,),
            label: '추천', // 3페이지
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/doctor_icon.jpeg', width: 30,),
            label: '설명', // 4페이지
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/alert_icon.jpeg', width: 30,),
            label: '알림', // 5페이지
          ),
        ],
      ),
    );
  }
}
