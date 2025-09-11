class Reading {
  final int? id;
  final String timestamp;
  final int mood_score;
  final int context_light;
  final int context_noise;
  final int context_activity;

  Reading({
    this.id,
    required this.timestamp,
    required this.mood_score,
    required this.context_light,
    required this.context_noise,
    required this.context_activity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': timestamp,
      'mood_score': mood_score,
      'context_light': context_light,
      'context_noise': context_noise,
      'context_activity': context_activity,
    };
  }

  factory Reading.fromMap(Map<String, dynamic> map) {
    return Reading(
      id: map['id'],
      timestamp: map['timestamp'],
      mood_score: map['mood_score'],
      context_light: map['context_light'],
      context_noise: map['context_noise'],
      context_activity: map['context_activity'],
    );
  }
}
