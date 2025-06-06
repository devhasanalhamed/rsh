class TimeFormatter {
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return formatTime(hours, minutes, seconds);
  }

  static String formatTime(int hours, int minutes, int seconds) {
    return '${_formatUnit(hours)} : ${_formatUnit(minutes)} : ${_formatUnit(seconds)}';
  }

  static String _formatUnit(int value) {
    return value.toString().padLeft(2, '0');
  }

  static Duration parseDuration(String timeString) {
    final parts = timeString.split(':');
    if (parts.length != 3) return Duration.zero;

    final hours = int.tryParse(parts[0]) ?? 0;
    final minutes = int.tryParse(parts[1]) ?? 0;
    final seconds = int.tryParse(parts[2]) ?? 0;

    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }
}
