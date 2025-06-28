class Event {
  final String? id; // ID boleh null (saat tambah event baru)
  final String title;
  final String description;
  final String date;
  final double latitude;
  final double longitude;

  Event({
    this.id, // tambahkan parameter id di sini
    required this.title,
    required this.description,
    required this.date,
    required this.latitude,
    required this.longitude,
  });

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
