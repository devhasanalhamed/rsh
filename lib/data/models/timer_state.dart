enum TimerStatus { initial, running, paused, completed }

class TimerState {
  final TimerStatus status;
  final Duration duration;
  final Duration remaining;

  const TimerState({
    required this.status,
    required this.duration,
    required this.remaining,
  });

  TimerState copyWith({
    TimerStatus? status,
    Duration? duration,
    Duration? remaining,
  }) {
    return TimerState(
      status: status ?? this.status,
      duration: duration ?? this.duration,
      remaining: remaining ?? this.remaining,
    );
  }

  bool get isRunning => status == TimerStatus.running;
  bool get isPaused => status == TimerStatus.paused;
  bool get isCompleted => status == TimerStatus.completed;
  bool get isInitial => status == TimerStatus.initial;

  double get progress {
    if (duration.inSeconds == 0) return 0.0;
    return 1.0 - (remaining.inSeconds / duration.inSeconds);
  }
}
