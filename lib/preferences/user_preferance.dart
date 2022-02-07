import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static SharedPreferences? instance;
  static const String showAreaDialogue = 'areaDialog';
  static const String selectedArea = 'selectedArea';
  static Future<void> setPreference() async {
    instance = await SharedPreferences.getInstance();
  }

  static Future<bool> clearPreference() {
    return instance!.clear();
  }

  static bool containsKey(String key) {
    return instance!.containsKey(key);
  }

  static dynamic get(String key) {
    return instance!.get(key);
  }

  static bool? getBool(String key) {
    return instance!.getBool(key);
  }

  static Future<bool> setBool(String key, bool value) {
    return instance!.setBool(key, value);
  }

  static String? getString(String key) {
    return instance!.getString(key);
  }

  static Future<bool> setString(String key, String value) {
    return instance!.setString(key, value);
  }
}
