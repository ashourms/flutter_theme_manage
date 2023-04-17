import 'package:flutter/material.dart';
import 'package:flutter_theme_manager/src/services/theme_preference_manager.dart';

/// [ThemeBuilder] is a simple theme manager to that can be used to switch
/// application theme between light and dark themes. When used for the first
/// time, the system will use provided "light" theme. Once the theme is toggled
/// it will store in user's preference so that the selected theme will be always
/// loaded upon application startup
class ThemeBuilder extends StatefulWidget {
  /// Application light theme
  final ThemeData lightTheme;

  /// Application dark theme
  final ThemeData darkTheme;

  /// Builder function
  final Widget Function(BuildContext context, ThemeData theme) builder;
  const ThemeBuilder({
    super.key,
    required this.lightTheme,
    required this.darkTheme,
    required this.builder,
  });

  static ThemeBuilderState of(BuildContext context) {
    return context.findAncestorStateOfType<State<ThemeBuilder>>()
        as ThemeBuilderState;
  }

  @override
  State<StatefulWidget> createState() => ThemeBuilderState();
}

class ThemeBuilderState extends State<ThemeBuilder> {
  late ThemeData _currentTheme;
  late ThemePreferenceManager _themeManagerService;

  @override
  void initState() {
    super.initState();
    _currentTheme = widget.lightTheme;
    _themeManagerService = ThemePreferenceManager(
      lightTheme: widget.lightTheme,
      darkTheme: widget.darkTheme,
    );
    _initThemeData();
  }

  _initThemeData() async {
    _currentTheme = await _themeManagerService.getUserThemePreference();
    if (mounted) {
      setState(() {});
    }
  }

  void toggleTheme() async {
    _currentTheme = await _themeManagerService.toggleTheme();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      _currentTheme,
    );
  }
}
