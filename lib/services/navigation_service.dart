import 'package:shared_preferences/shared_preferences.dart';

class NavigationService {
  static const String _pathKey = 'last_path';

  static Future<void> savePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_pathKey, path);
  }

  static Future<String> getLastPath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_pathKey) ?? '/login';
  }

  static Future<void> clearLastPath() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_pathKey);
  }
}
