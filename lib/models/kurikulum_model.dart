// kurikulum_model.dart
class Kurikulum {
  final int idKurikulum;
  final String namaMatakuliah;
  final String namaTahunAkademik;
  final String ket;

  Kurikulum({
    required this.idKurikulum,
    required this.namaMatakuliah,
    required this.namaTahunAkademik,
    required this.ket,
  });

  factory Kurikulum.fromJson(Map<String, dynamic> json) {
    return Kurikulum(
      idKurikulum: json['id_kurikulum'],
      namaMatakuliah: json['nama_matakuliah'],
      namaTahunAkademik: json['nama_tahun_akademik'],
      ket: json['ket'] ?? '',
    );
  }
}