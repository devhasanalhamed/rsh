class PresetTimer {
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

  Duration get duration =>
      Duration(hours: hours, minutes: minutes, seconds: seconds);

  String toJsonString() {
    return '$name:$hours:$minutes:$seconds';
  }

  static PresetTimer fromJsonString(String jsonString) {
    final parts = jsonString.split(':');
    return PresetTimer(
      name: parts[0],
      hours: int.parse(parts[1]),
      minutes: int.parse(parts[2]),
      seconds: int.parse(parts[3]),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PresetTimer &&
        other.name == name &&
        other.hours == hours &&
        other.minutes == minutes &&
        other.seconds == seconds;
  }

  @override
  int get hashCode {
    return Object.hash(name, hours, minutes, seconds);
  }
}
