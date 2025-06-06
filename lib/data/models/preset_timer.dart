import 'package:timer/domain/entities/preset_timer.dart';

class PresetTimerModel extends PresetTimer {
  const PresetTimerModel({
    required super.name,
    required super.hours,
    required super.minutes,
    required super.seconds,
  });

  Duration get duration =>
      Duration(hours: hours, minutes: minutes, seconds: seconds);

  String toJsonString() {
    return '$name:$hours:$minutes:$seconds';
  }

  static PresetTimerModel fromJsonString(String jsonString) {
    final parts = jsonString.split(':');
    return PresetTimerModel(
      name: parts[0],
      hours: int.parse(parts[1]),
      minutes: int.parse(parts[2]),
      seconds: int.parse(parts[3]),
    );
  }
}
