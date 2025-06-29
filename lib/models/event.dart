class Event {
  final int? id;
  final String title;
  final String description;
  final String date;
  final double latitude;
  final double longitude;
  final String? imagePath; // pastikan ada
  final String? kategori; // tambahkan ini

  Event({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.latitude,
    required this.longitude,
    this.imagePath,
    this.kategori, // tambahkan ini
  });

  String get location => '$latitude, $longitude';

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: map['date'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      imagePath: map['imagePath'],
      kategori: map['kategori'], // tambahkan ini
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
      'imagePath': imagePath,
      'kategori': kategori, // tambahkan ini
    };
  }
}
