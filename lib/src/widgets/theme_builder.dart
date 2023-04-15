import 'package:flutter/material.dart';
import 'package:flutter_theme_manager/src/services/theme_preference_manager.dart';

class ThemeBuilder extends StatefulWidget {
  // final Widget child;
  final ThemeData lightTheme;
  final ThemeData darkTheme;
  final Widget Function(BuildContext context, ThemeData theme) builder;
  const ThemeBuilder({
    super.key,
    // required this.child,
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
  late ThemeData _themeData;
  late ThemePreferenceManager _themeManagerService;
  final String themeModeKey = 'themeMode';

  @override
  void initState() {
    super.initState();
    _themeData = widget.lightTheme;
    _themeManagerService = ThemePreferenceManager(
      lightTheme: widget.lightTheme,
      darkTheme: widget.darkTheme,
    );
    _initThemeData();
  }

  _initThemeData() async {
    _themeData = await _themeManagerService.getThemePrefernce();
    if (mounted) {
      setState(() {});
    }
  }

  void toggleTheme() async {
    _themeData = await _themeManagerService.toggleTheme();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      _themeData,
    );
  }
}
