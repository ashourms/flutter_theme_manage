import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_theme_manager/src/services/theme_preference_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late final ThemePreferenceManager themePreferenceManager;
  setUpAll(
    () {
      themePreferenceManager = ThemePreferenceManager(
          lightTheme: ThemeData.light(), darkTheme: ThemeData.dark());
    },
  );

  test('It loads theme mode from user sahred preference', () async {
    final Map<String, Object> values = <String, Object>{'themeMode': 0};
    SharedPreferences.setMockInitialValues(values);

    final themeMode = await themePreferenceManager.getUserSavedThemeMode();
    expect(themeMode, 0);
  });

  test('It loads light theme data when theme mode is 0', () async {
    final Map<String, Object> values = <String, Object>{'themeMode': 0};
    SharedPreferences.setMockInitialValues(values);

    final theme = await themePreferenceManager.getUserThemePreference();
    expect(theme, ThemeData.light());
  });

  test('It loads dark theme data when theme mode is 1', () async {
    final Map<String, Object> values = <String, Object>{'themeMode': 1};
    SharedPreferences.setMockInitialValues(values);

    final theme = await themePreferenceManager.getUserThemePreference();
    expect(theme, ThemeData.dark());
  });

  test('It toggles user\'s current theme to light if current store mode is 1',
      () async {
    final Map<String, Object> values = <String, Object>{'themeMode': 1};
    SharedPreferences.setMockInitialValues(values);

    final theme = await themePreferenceManager.toggleTheme();
    expect(theme, ThemeData.light());
  });
  test('It toggles user\'s current theme to dark if current store mode is 0',
      () async {
    final Map<String, Object> values = <String, Object>{'themeMode': 0};
    SharedPreferences.setMockInitialValues(values);

    final theme = await themePreferenceManager.toggleTheme();
    expect(theme, ThemeData.dark());
  });
}
