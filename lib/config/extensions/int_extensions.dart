extension IntExtensions on int {
  String toReadableTime() {
    int totalMilliseconds =
        this ~/ 1000; // Convert microseconds to milliseconds
    int totalSeconds = totalMilliseconds ~/ 1000;

    int hours = totalSeconds ~/ 3600; // Calculate hours
    int minutes = (totalSeconds % 3600) ~/ 60; // Calculate minutes
    int seconds = totalSeconds % 60; // Remaining seconds

    if (hours > 0) {
      // Include hours if applicable
      return '${(this / 3.6e+9).toStringAsFixed(2)}\'h';
    } else if (minutes > 0) {
      // Include minutes if applicable
      return '${(this / 6e+7).toStringAsFixed(2)}\'m';
    } else if (seconds > 0) {
      // Include seconds if applicable
      return '${(this / 1e+6).toStringAsFixed(2)}\'s';
    } else {
      // Only milliseconds
      return '${(this / 1000).toStringAsFixed(2)}\'ms';
    }
  }
}
