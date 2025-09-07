class ContextReadings {
  final int? id;
  final String context_light;
  final String context_noise;
  final String context_activity;
  final int context_mood_score;

  ContextReadings({
    this.id,
    required this.context_light,
    required this.context_noise,
    required this.context_activity,
    required this.context_mood_score,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'context_light': context_light,
      'context_noise': context_noise,
      'context_activity': context_activity,
      'context_mood_score': context_mood_score,
    };
  }

  factory ContextReadings.fromMap(Map<String, dynamic> map) {
    return ContextReadings(
      id: map['id'],
      context_light: map['context_light'],
      context_noise: map['context_noise'],
      context_activity: map['context_activity'],
      context_mood_score: map['context_mood_score'],
    );
  }
}
