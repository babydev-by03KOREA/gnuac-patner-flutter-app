import 'package:flutter/material.dart';

class AppColors {
  // From your sketch
  static const Color gradientTop = Color(0xFFBADBE9); // 상단
  static const Color gradientBottom = Color(0xFFD6CFE6); // 하단
  static const Color surfaceVariant = Color(0xFFC8D0D0); // 안내/워닝 박스 톤

  // Derivatives
  static const Color primary = Color(0xFF9CBBD4); // 그라데이션 중간 톤
  static const Color onPrimary = Colors.white;
  static const Color secondary = Color(0xFF8FA6B8);
  static const Color onSecondary = Colors.white;

  static const Color neutralBg = Color(0xFFF8FAFB);
}

/// 공통 그라데이션 (시안 상/하 색)
const LinearGradient kAppGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [AppColors.gradientTop, AppColors.gradientBottom],
);

ThemeData buildTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondary,
    surface: Colors.white,
    onSurface: const Color(0xFF1B1B1B),
    background: AppColors.neutralBg,
    onBackground: const Color(0xFF1B1B1B),
    surfaceVariant: AppColors.surfaceVariant,
    brightness: Brightness.light,
  );

  return ThemeData(
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.background,
    useMaterial3: true,

    // 앱바: 투명 배경 + 텍스트는 onPrimary 톤
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.onPrimary,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: AppColors.onPrimary,
      ),
    ),

    // 입력창
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: AppColors.gradientBottom.withOpacity(0.6)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: AppColors.gradientBottom.withOpacity(0.6)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.6),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
      hintStyle: TextStyle(color: Colors.black.withOpacity(0.35)),
    ),

    // 버튼
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.onPrimary,
        backgroundColor: AppColors.primary,
        disabledBackgroundColor: AppColors.primary.withOpacity(.4),
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.secondary,
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),

    // 카드(안내/워닝 박스 등에 사용)
    cardTheme: CardThemeData(
      color: scheme.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      surfaceTintColor: Colors.transparent,
    ),

    // 스위치(알람 ON/OFF 토글 느낌 살리기)
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith((states) {
        final active = states.contains(WidgetState.selected);
        return active ? AppColors.primary.withOpacity(.35) : Colors.black12;
      }),
      thumbColor: WidgetStateProperty.resolveWith((states) {
        final active = states.contains(WidgetState.selected);
        return active ? AppColors.primary : Colors.white;
      }),
    ),
  );
}

/// 그라데이션 배경을 손쉽게 쓰기 위한 위젯
class GradientScaffold extends StatelessWidget {
  const GradientScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.extendBodyBehindAppBar = true,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final bool extendBodyBehindAppBar;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: kAppGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
      ),
    );
  }
}
