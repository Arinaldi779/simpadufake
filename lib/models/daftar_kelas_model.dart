class Kelas {
  final String? id;
  final String namaKelas;
  final String alias;
  final String idProdi;
  final String idThnAk;

  Kelas({
    this.id,
    required this.namaKelas,
    required this.alias,
    required this.idProdi,
    required this.idThnAk,
  });

  factory Kelas.fromJson(Map<String, dynamic> json) {
    return Kelas(
      id: json['id']?.toString(),
      namaKelas: json['nama_kelas'] ?? '',
      alias: json['alias'] ?? '',
      idProdi: json['id_prodi']?.toString() ?? '',
      idThnAk: json['id_thn_ak']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_kelas': namaKelas,
      'alias': alias,
      'id_prodi': idProdi,
      'id_thn_ak': idThnAk,
    };
  }
}

class Prodi {
  final String idProdi;
  final String namaProdi;

  Prodi({
    required this.idProdi,
    required this.namaProdi,
  });

  factory Prodi.fromJson(Map<String, dynamic> json) {
    return Prodi(
      idProdi: json['id_prodi']?.toString() ?? '',
      namaProdi: json['nama_prodi'] ?? '',
    );
  }
}

class TahunAkademik {
  final String idThnAk;
  final String namaThnAk;

  TahunAkademik({
    required this.idThnAk,
    required this.namaThnAk,
  });

  factory TahunAkademik.fromJson(Map<String, dynamic> json) {
    return TahunAkademik(
      idThnAk: json['id_thn_ak']?.toString() ?? '',
      namaThnAk: json['nama_thn_ak'] ?? '',
    );
  }
}