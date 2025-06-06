import 'package:equatable/equatable.dart';

class PresetTimer extends Equatable {
  final String name;
  final int hours;
  final int minutes;
  final int seconds;

  const PresetTimer({
    required this.name,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  @override
  List<Object> get props => [name, hours, minutes, seconds];
}
