import 'package:equatable/equatable.dart';
import 'package:timer/core/enums/timer_status.dart';

class TimerState extends Equatable {
  final TimerStatus status;
  final Duration duration;
  final Duration remaining;

  const TimerState({
    required this.status,
    required this.duration,
    required this.remaining,
  });

  @override
  List<Object> get props => [status, duration, remaining];
}
