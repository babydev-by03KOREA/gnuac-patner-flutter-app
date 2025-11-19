import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  AppEnv(this.projectUrl, this.projectApiKey);
  final String projectUrl;
  final String projectApiKey;

  static Future<AppEnv> load() async {
    await dotenv.load(fileName: '.env');
    return AppEnv(
      dotenv.get('PROJECT_URL'),
      dotenv.get('PROJECT_API_KEY'),
    );
  }
}
