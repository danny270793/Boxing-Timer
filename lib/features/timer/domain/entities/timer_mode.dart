import 'timer_phase.dart';

const int kWarmupSeconds = 10;
const int kClashWarningSeconds = 10;

class TimerMode {
  final String id;
  final String name;
  final int totalRounds;
  final int roundSeconds;
  final int restSeconds;

  const TimerMode({
    required this.id,
    required this.name,
    required this.totalRounds,
    required this.roundSeconds,
    required this.restSeconds,
  });

  int secondsFor(TimerPhase phase) {
    switch (phase) {
      case TimerPhase.warmup:
        return kWarmupSeconds;
      case TimerPhase.round:
        return roundSeconds;
      case TimerPhase.rest:
        return restSeconds;
      case TimerPhase.idle:
      case TimerPhase.finished:
        return 0;
    }
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'totalRounds': totalRounds,
    'roundSeconds': roundSeconds,
    'restSeconds': restSeconds,
  };

  factory TimerMode.fromJson(Map<String, dynamic> json) => TimerMode(
    id: json['id'] as String,
    name: json['name'] as String,
    totalRounds: json['totalRounds'] as int,
    roundSeconds: json['roundSeconds'] as int,
    restSeconds: json['restSeconds'] as int,
  );
}
