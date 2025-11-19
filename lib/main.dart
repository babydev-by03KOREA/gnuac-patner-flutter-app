import 'package:flutter/material.dart';
import 'package:patner_app/app/app.dart';
import 'package:patner_app/core/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final env = await AppEnv.load();
  await Supabase.initialize(
    url: env.projectUrl,
    anonKey: env.projectApiKey,
    authOptions: const FlutterAuthClientOptions(
      autoRefreshToken: true,
      detectSessionInUri: true,
    ),
  );

  runApp(const ProviderScope(child: App()));
}
