class Mahasiswa {
  final String? id;
  final String nim;
  final String namaMhs;
  final int idKelas;
  final int noAbsen;

  Mahasiswa({
    this.id,
    required this.nim,
    required this.namaMhs,
    required this.idKelas,
    required this.noAbsen,
  });

  factory Mahasiswa.fromJson(Map<String, dynamic> json) {
    return Mahasiswa(
      id: json['id']?.toString(),
      nim: json['nim'] ?? '',
      namaMhs: json['nama_mhs'] ?? '',
      idKelas: json['id_kelas'] is int ? json['id_kelas'] : int.tryParse(json['id_kelas'].toString()) ?? 0,
      noAbsen: json['no_absen'] is int ? json['no_absen'] : int.tryParse(json['no_absen'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nim': nim,
      'id_kelas': idKelas,
      'no_absen': noAbsen,
    };
  }
}

class Kelas {
  final int idKelas;
  final String namaKelas;

  Kelas({
    required this.idKelas,
    required this.namaKelas,
  });

  factory Kelas.fromJson(Map<String, dynamic> json) {
    return Kelas(
      idKelas: json['id_kelas'] ?? 0,
      namaKelas: json['nama_kelas'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_kelas': idKelas,
      'nama_kelas': namaKelas,
    };
  }
}