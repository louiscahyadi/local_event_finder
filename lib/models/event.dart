class Event {
  final String? id;
  final String title;
  final String description;
  final String date;
  final double latitude;
  final double longitude;

  Event({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.latitude,
    required this.longitude,
  });

  String get location => '$latitude, $longitude';

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id']?.toString(),
      title: map['title'],
      description: map['description'],
      date: map['date'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
