import 'package:flutter/material.dart';

class AppThemeScope extends InheritedWidget {
  final ThemeMode themeMode;
  final VoidCallback toggleTheme;

  const AppThemeScope({
    super.key,
    required this.themeMode,
    required this.toggleTheme,
    required super.child,
  });

  static AppThemeScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppThemeScope>();
    assert(scope != null, 'AppThemeScope not found');
    return scope!;
  }

  @override
  bool updateShouldNotify(AppThemeScope oldWidget) {
    return themeMode != oldWidget.themeMode;
  }
}
