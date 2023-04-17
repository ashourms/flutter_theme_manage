

A simple Flutter theme manager for your application 

## Features

This packages allows you to manage your application theme easily

## Getting started

To use this package, you need to first add it to you pubspec.yaml file like so
dependencies:
    flutter_theme_manager:

## Usage

Wrap you material widget with ThemeBuilder as shown below

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      darkTheme: ThemeData.dark(),
      lightTheme: ThemeData.light(),
      builder: (BuildContext context, ThemeData theme) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: theme,
          home: const HomePage(),
        );
      },
      // themeMode: ThemeMode.system,
    );
  }
}
```
to toggle theme in your application, you can achieve that by using the below:
```dart
ThemeBuilder.of(context).toggleTheme();
```
