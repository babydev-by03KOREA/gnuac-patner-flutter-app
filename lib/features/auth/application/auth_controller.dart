import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/providers/supabase_client_provider.dart';
import '../data/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final client = ref.watch(supabaseProvider);
  return AuthRepository(client);
});

class AuthState {
  const AuthState({this.loading = false, this.error});

  final bool loading;
  final String? error;

  AuthState copyWith({bool? loading, String? error}) =>
      AuthState(loading: loading ?? this.loading, error: error);
}

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    return AuthController(ref);
  },
);

class AuthController extends StateNotifier<AuthState> {
  AuthController(this.ref) : super(const AuthState());
  final Ref ref;

  Future<bool> signIn(String email, String password) async {
    state = state.copyWith(loading: true, error: null);
    try {
      await ref
          .read(authRepositoryProvider)
          .signIn(email: email, password: password);
      return true;
    } on AuthException catch (e) {
      state = state.copyWith(error: e.message);
      return false;
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<bool> signUp(
    String email,
    String password, {
    Map<String, dynamic>? meta,
  }) async {
    state = state.copyWith(loading: true, error: null);
    try {
      await ref
          .read(authRepositoryProvider)
          .signUp(email: email, password: password, userMeta: meta);
      return true;
    } on AuthException catch (e) {
      state = state.copyWith(error: e.message);
      return false;
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> signOut() => ref.read(authRepositoryProvider).signOut();
}
