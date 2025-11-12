import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  AppEnv(this.supabaseUrl, this.supabaseAnonKey);
  final String supabaseUrl;
  final String supabaseAnonKey;

  static Future<AppEnv> load() async {
    await dotenv.load(fileName: '.env');
    return AppEnv(
      dotenv.get('SUPABASE_URL'),
      dotenv.get('SUPABASE_ANON_KEY'),
    );
  }
}
