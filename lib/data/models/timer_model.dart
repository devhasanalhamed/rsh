class TimerModel {
  final int hours;
  final int minutes;
  final int seconds;
  final DateTime? startTime;
  final bool isRunning;
  final bool isPaused;

  const TimerModel({
    required this.hours,
    required this.minutes,
    required this.seconds,
    this.startTime,
    this.isRunning = false,
    this.isPaused = false,
  });

  Duration get duration =>
      Duration(hours: hours, minutes: minutes, seconds: seconds);

  int get totalSeconds => duration.inSeconds;

  TimerModel copyWith({
    int? hours,
    int? minutes,
    int? seconds,
    DateTime? startTime,
    bool? isRunning,
    bool? isPaused,
  }) {
    return TimerModel(
      hours: hours ?? this.hours,
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
      startTime: startTime ?? this.startTime,
      isRunning: isRunning ?? this.isRunning,
      isPaused: isPaused ?? this.isPaused,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TimerModel &&
        other.hours == hours &&
        other.minutes == minutes &&
        other.seconds == seconds &&
        other.startTime == startTime &&
        other.isRunning == isRunning &&
        other.isPaused == isPaused;
  }

  @override
  int get hashCode {
    return Object.hash(hours, minutes, seconds, startTime, isRunning, isPaused);
  }

  @override
  String toString() {
    return 'TimerModel(hours: $hours, minutes: $minutes, seconds: $seconds, isRunning: $isRunning, isPaused: $isPaused)';
  }
}
