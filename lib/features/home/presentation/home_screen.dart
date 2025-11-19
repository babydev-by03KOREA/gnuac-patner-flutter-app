import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patner_app/features/daily_log/presentation/screens/daily_log_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // v1: 홈 = 그냥 1페이지(하루 로그)
    return const DailyLogScreen();
  }
}
