class Reading {
  final int? id;
  final String timestamp;
  final int mood_score;

  Reading({this.id, required this.timestamp, required this.mood_score});

  Map<String, dynamic> toMap() {
    return {'id': id, 'timestamp': timestamp, 'mood_score': mood_score};
  }

  factory Reading.fromMap(Map<String, dynamic> map) {
    return Reading(
      id: map['id'],
      timestamp: map['timestamp'],
      mood_score: map['mood_score'],
    );
  }
}
