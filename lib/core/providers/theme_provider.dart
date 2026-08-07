import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

// Theme State
class ThemeState {
  final ThemeData themeData;
  final bool isDarkMode;

  ThemeState({required this.themeData, required this.isDarkMode});
}

// Theme Notifier
class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier()
    : super(ThemeState(themeData: ThemeData.light(), isDarkMode: false));

  void toggleTheme() {
    final newIsDark = !state.isDarkMode;
    state = ThemeState(
      themeData: newIsDark ? ThemeData.dark() : ThemeData.light(),
      isDarkMode: newIsDark,
    );
  }
}

// Theme Provider
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});
