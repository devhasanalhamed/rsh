import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer/core/services/notification_service.dart';
import 'package:timer/timer_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();

  // runApp(const ProviderScope(child: TimerApp()));
  runApp(
    DevicePreview(builder: (context) => const ProviderScope(child: TimerApp())),
  );
}
