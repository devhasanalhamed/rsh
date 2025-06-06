import 'package:timer/core/enums/timer_status.dart';
import 'package:timer/domain/entities/timer_state.dart';

class TimerStateModel extends TimerState {
  const TimerStateModel({
    required super.status,
    required super.duration,
    required super.remaining,
  });

  TimerStateModel copyWith({
    TimerStatus? status,
    Duration? duration,
    Duration? remaining,
  }) {
    return TimerStateModel(
      status: status ?? this.status,
      duration: duration ?? this.duration,
      remaining: remaining ?? this.remaining,
    );
  }

  bool get isInitial => status == TimerStatus.initial;
  bool get isRunning => status == TimerStatus.running;
  bool get isPaused => status == TimerStatus.paused;
  bool get isCompleted => status == TimerStatus.completed;

  double get progress {
    if (duration.inSeconds == 0) return 0.0;

    return 1 - (remaining.inSeconds / duration.inSeconds);
  }
}
