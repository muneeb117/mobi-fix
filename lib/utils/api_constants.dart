
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static late final String apiKey;

  static void load() {
    apiKey = dotenv.get('API_KEY', fallback: 'YOUR_DEFAULT_API_KEY');
  }
}
