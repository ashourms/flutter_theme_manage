import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AvailableTheme { light, dark }

/// [ThemePreferenceManager] manages user's theme preferences. It store the user
/// selected theme mode (i.e. light or dark) and then loads the theme data
/// whenever needed.
class ThemePreferenceManager {
  final ThemeData _lightTheme;
  final ThemeData _darkTheme;
  static const _themeModeKey = 'themeMode';

  ThemePreferenceManager({
    required ThemeData lightTheme,
    required ThemeData darkTheme,
  })  : _darkTheme = darkTheme,
        _lightTheme = lightTheme;

  /// Stores the user's theme mode in the user preference
  Future<void> saveUserThemePreference(AvailableTheme mode) async {
    final sharedPreference = await SharedPreferences.getInstance();
    await sharedPreference.setString(_themeModeKey, mode.name);
  }

  /// Loads the user's theme mode from the user preference
  Future<String?> getUserSavedThemeMode() async {
    final sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.getString(_themeModeKey);
  }

  /// Toggles application theme and update user's theme preference
  Future<ThemeData> toggleTheme() async {
    final currentMode = await getUserSavedThemeMode();
    if (currentMode == AvailableTheme.light.name) {
      await saveUserThemePreference(AvailableTheme.dark);
      return _darkTheme;
    } else {
      await saveUserThemePreference(AvailableTheme.light);
      return _lightTheme;
    }
  }

  /// Get current user's theme preference
  Future<ThemeData> getUserThemePreference() async {
    final currentMode = await getUserSavedThemeMode();
    if (currentMode == AvailableTheme.dark.name) {
      return _darkTheme;
    }
    return _lightTheme;
  }
}
