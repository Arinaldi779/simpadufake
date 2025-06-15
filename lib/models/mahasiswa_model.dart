class Mahasiswa {
  final String? id;
  final String nim;
  final int idKelas;
  final int noAbsen;

  Mahasiswa({
    this.id,
    required this.nim,
    required this.idKelas,
    required this.noAbsen,
  });

  factory Mahasiswa.fromJson(Map<String, dynamic> json) {
    return Mahasiswa(
      id: json['id']?.toString(),
      nim: json['nim'] ?? '',
      idKelas: json['id_kelas'] ?? 0,
      noAbsen: json['no_absen'] ?? 0,
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
}