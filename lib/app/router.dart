import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../features/auth/presentation/sign_in_screen.dart';
import '../features/auth/presentation/sign_up_screen.dart';
import '../features/home/presentation/home_screen.dart';

/// 현재 로그인되어 있는지 간단 체크
bool get _isSignedIn =>
    Supabase.instance.client.auth.currentSession != null;

/// Supabase auth state 변경을 GoRouter에 반영하기 위한 헬퍼
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream stream) {
    _sub = stream.listen((_) => notifyListeners());
  }
  late final StreamSubscription _sub;
  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}

GoRouter buildRouter() {
  final authStream = Supabase.instance.client.auth.onAuthStateChange;

  return GoRouter(
    initialLocation: _isSignedIn ? '/home' : '/sign-in',
    debugLogDiagnostics: kDebugMode,
    refreshListenable: GoRouterRefreshStream(authStream),
    routes: [
      GoRoute(
        path: '/sign-in',
        name: 'sign-in',
        builder: (_, __) => const SignInScreen(),
        redirect: (_, __) => _isSignedIn ? '/home' : null,
      ),
      GoRoute(
        path: '/sign-up',
        name: 'sign-up',
        builder: (_, __) => const SignUpScreen(),
        redirect: (_, __) => _isSignedIn ? '/home' : null,
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (_, __) => const HomeScreen(),
        // 로그인 안되어 있으면 차단
        redirect: (_, __) => _isSignedIn ? null : '/sign-in',
      ),
    ],
    // 알 수 없는 경로는 홈/로그인으로 스낵바와 함께 보냄
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Not found: ${state.matchedLocation}'),
      ),
    ),
  );
}
