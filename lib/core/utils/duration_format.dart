String formatSeconds(int totalSeconds) {
  final seconds = totalSeconds < 0 ? 0 : totalSeconds;
  final minutes = seconds ~/ 60;
  final remainingSeconds = seconds % 60;
  return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
}
