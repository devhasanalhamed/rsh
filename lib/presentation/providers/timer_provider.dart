import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/timer_state.dart';
import '../../core/services/notification_service.dart';
import '../../core/services/audio_service.dart';
import '../../core/services/storage_service.dart';

final timerProvider = StateNotifierProvider<TimerNotifier, TimerState>((ref) {
  return TimerNotifier();
});

class TimerNotifier extends StateNotifier<TimerState> {
  Timer? _ticker;

  TimerNotifier()
    : super(
        const TimerState(
          status: TimerStatus.initial,
          duration: Duration.zero,
          remaining: Duration.zero,
        ),
      );

  void setTimer(Duration duration) {
    if (state.isRunning) return;

    state = TimerState(
      status: TimerStatus.initial,
      duration: duration,
      remaining: duration,
    );
  }

  void startTimer() {
    if (state.isRunning || state.remaining.inSeconds <= 0) return;

    state = state.copyWith(status: TimerStatus.running);

    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
      final newRemaining = Duration(seconds: state.remaining.inSeconds - 1);

      if (newRemaining.inSeconds <= 0) {
        _completeTimer();
      } else {
        state = state.copyWith(remaining: newRemaining);
      }
    });
  }

  void pauseTimer() {
    if (!state.isRunning) return;

    _ticker?.cancel();
    state = state.copyWith(status: TimerStatus.paused);
  }

  void resetTimer() {
    _ticker?.cancel();
    state = TimerState(
      status: TimerStatus.initial,
      duration: state.duration,
      remaining: state.duration,
    );
  }

  void _completeTimer() {
    _ticker?.cancel();
    state = state.copyWith(status: TimerStatus.completed);

    // Play completion sound and show notification
    AudioService.playTimerComplete();
    NotificationService.showTimerCompleteNotification();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }
}
