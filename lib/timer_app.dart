import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer/core/themes/app_theme.dart';
import 'package:timer/presentation/pages/timer_page.dart';
import 'package:timer/presentation/providers/theme_provider.dart';

class TimerApp extends ConsumerWidget {
  const TimerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Timer',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const TimerPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
