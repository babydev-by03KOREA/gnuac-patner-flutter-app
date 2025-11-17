import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  AuthRepository(this._client);
  final SupabaseClient _client;

  Future<AuthResponse> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? userMeta, // 프로필 초기값
  }) {
    return _client.auth.signUp(
      email: email,
      password: password,
      data: userMeta,
      emailRedirectTo: null, // 필요 시 딥링크
    );
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) {
    return _client.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() => _client.auth.signOut();

  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  Session? get currentSession => _client.auth.currentSession;
}
