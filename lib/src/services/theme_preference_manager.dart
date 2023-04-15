import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [ThemePreferenceManager] manages user's theme preferences. It store the user
/// selected theme mode (i.e. light or dark) and then loads the theme data
/// whenever needed.
class ThemePreferenceManager {
  final ThemeData _lightTheme;
  final ThemeData _darkTheme;
  static const themeModeKey = 'themeMode';

  ThemePreferenceManager(
      {required ThemeData lightTheme, required ThemeData darkTheme})
      : _darkTheme = darkTheme,
        _lightTheme = lightTheme;

  /// Stores the user's theme mode in the user preference
  Future<void> presisteThemePrefernce(int mode) async {
    final sharedPreference = await SharedPreferences.getInstance();
    await sharedPreference.setInt(themeModeKey, mode);
  }

  /// Loads the user's theme mode from the user preference
  Future<int?> getThemeModePrefernce() async {
    final sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.getInt(themeModeKey);
  }

  /// Toggles application theme and update user's theme preference
  Future<ThemeData> toggleTheme() async {
    final currentMode = await getThemeModePrefernce();
    if (currentMode == 0) {
      await presisteThemePrefernce(1);
      return _darkTheme;
    } else {
      await presisteThemePrefernce(0);
      return _lightTheme;
    }
  }

  /// Get current user's theme preference
  Future<ThemeData> getThemePrefernce() async {
    final sharedPreference = await SharedPreferences.getInstance();
    final currentMode = sharedPreference.getInt(themeModeKey);
    if (currentMode == 1) {
      return _darkTheme;
    }
    return _lightTheme;
  }
}
