import 'package:flutter/material.dart' show debugPrint;
import 'package:vibration/vibration.dart';

class VibrationService {
  static final VibrationService _instance = VibrationService._();

  static VibrationService get instance => _instance;

  late bool hasVibratorSupport;
  late final bool hasAmplitudeControlSupport;
  late final bool hasCustomVibrationsSupport;

  VibrationService._();

  Future<void> initialize() async {
    try {
      hasVibratorSupport = await Vibration.hasVibrator();
      hasAmplitudeControlSupport = await Vibration.hasAmplitudeControl();
      hasCustomVibrationsSupport = await Vibration.hasCustomVibrationsSupport();
    } catch (e) {
      debugPrint(e.toString());
      hasVibratorSupport = false;
      hasAmplitudeControlSupport = false;
      hasCustomVibrationsSupport = false;
    }
  }

  final int _tickerDuration = 45; // light duration
  final int _tickerAmplitude = 128;

  // check if the device has a vibrator
  Future<bool> checkHasVibrator() async {
    return await Vibration.hasVibrator();
  }

  // check if the device has the ability to control the amplitude
  Future<bool> hasAmplitudeControl() async {
    return await Vibration.hasAmplitudeControl();
  }

  // check if the device has customized vibrator
  Future<bool> checkHasCustomVibrationsSupport() async {
    return await Vibration.hasCustomVibrationsSupport();
  }

  Future<void> tick() async {
    if (hasVibratorSupport && hasAmplitudeControlSupport) {
      cancel();
      await Vibration.vibrate(
        duration: _tickerDuration,
        amplitude: _tickerAmplitude,
      );
    } else {
      debugPrint('Device has no vibrator.');
    }
  }

  Future<void> cancel() async {
    await Vibration.cancel();
  }
}
