import 'package:shared_preferences/shared_preferences.dart';

class Peferences {
  static const String _key = 'theme';

  static Future<void> saveTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, theme);
  }

  static Future<String?> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }
}
