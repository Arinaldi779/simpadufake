class Kelas {
  final String id_kelas;
  final String nama_kelas;
  final String id_thn_ak;
  final String id_prodi;
  final String alias;

  Kelas({
    required this.id_kelas,
    required this.nama_kelas,
    required this.id_thn_ak,
    required this.id_prodi,
    required this.alias,
  });

  factory Kelas.fromJson(Map<String, dynamic> json) {
    return Kelas(
      id_kelas: json['id_kelas'] ?? '',
      nama_kelas: json['nama_kelas'] ?? '',
      id_thn_ak: json['id_thn_ak'] ?? '',
      id_prodi: json['id_prodi']?.toString() ?? '',
      alias: json['alias'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_kelas': nama_kelas,
      'id_thn_ak': id_thn_ak,
      'id_prodi': id_prodi,
      'alias': alias,
    };
  }
}