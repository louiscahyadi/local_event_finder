class Event {
  // mendefinisikan class Event sebagai representasi data event

  final int? id;
  // mendeklarasikan properti id sebagai integer nullable untuk menyimpan id event

  final String title;
  // mendeklarasikan properti title sebagai string untuk menyimpan judul event

  final String description;
  // mendeklarasikan properti description sebagai string untuk menyimpan deskripsi event

  final String date;
  // mendeklarasikan properti date sebagai string untuk menyimpan tanggal event

  final double latitude;
  // mendeklarasikan properti latitude sebagai double untuk menyimpan koordinat latitude event

  final double longitude;
  // mendeklarasikan properti longitude sebagai double untuk menyimpan koordinat longitude event

  final String? imagePath;
  // mendeklarasikan properti imagePath sebagai string nullable untuk menyimpan path gambar event

  final String? kategori;
  // mendeklarasikan properti kategori sebagai string nullable untuk menyimpan kategori event

  Event({
    this.id,
    // menerima nilai id sebagai parameter opsional
    required this.title,
    // menerima nilai title sebagai parameter wajib
    required this.description,
    // menerima nilai description sebagai parameter wajib
    required this.date,
    // menerima nilai date sebagai parameter wajib
    required this.latitude,
    // menerima nilai latitude sebagai parameter wajib
    required this.longitude,
    // menerima nilai longitude sebagai parameter wajib
    this.imagePath,
    // menerima nilai imagePath sebagai parameter opsional
    this.kategori,
    // menerima nilai kategori sebagai parameter opsional
  });

  String get location => '$latitude, $longitude';
  // membuat getter location untuk menggabungkan latitude dan longitude menjadi satu string

  factory Event.fromMap(Map<String, dynamic> map) {
    // membuat factory constructor untuk membuat objek Event dari map
    return Event(
      id: map['id'],
      // mengambil nilai id dari map
      title: map['title'],
      // mengambil nilai title dari map
      description: map['description'],
      // mengambil nilai description dari map
      date: map['date'],
      // mengambil nilai date dari map
      latitude: map['latitude'],
      // mengambil nilai latitude dari map
      longitude: map['longitude'],
      // mengambil nilai longitude dari map
      imagePath: map['imagePath'],
      // mengambil nilai imagePath dari map
      kategori: map['kategori'],
      // mengambil nilai kategori dari map
    );
  }

  Map<String, dynamic> toMap() {
    // membuat method untuk mengubah objek Event menjadi map
    return {
      'id': id,
      // memasukkan id ke dalam map
      'title': title,
      // memasukkan title ke dalam map
      'description': description,
      // memasukkan description ke dalam map
      'date': date,
      // memasukkan date ke dalam map
      'latitude': latitude,
      // memasukkan latitude ke dalam map
      'longitude': longitude,
      // memasukkan longitude ke dalam map
      'imagePath': imagePath,
      // memasukkan imagePath ke dalam map
      'kategori': kategori,
      // memasukkan kategori ke dalam map
    };
  }
}
