// Model untuk data Tahun Akademik dan fungsi API
class TahunAkademik {
  final String idThnAk;
  final String tahun;
  final String semester;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isAktif;

  TahunAkademik({
    required this.idThnAk,
    required this.tahun,
    required this.semester,
    this.startDate,
    this.endDate,
    required this.isAktif,
  });

  // Konversi dari JSON ke model
  factory TahunAkademik.fromJson(Map<String, dynamic> json) {
    return TahunAkademik(
      idThnAk: json['id_thn_ak'] ?? '',
      tahun: json['nama_thn_ak'] ?? '',
      semester: json['smt'] ?? '',
      startDate: json['tgl_awal_kuliah'] != null 
          ? DateTime.parse(json['tgl_awal_kuliah']) 
          : null,
      endDate: json['tgl_akhir_kuliah'] != null 
          ? DateTime.parse(json['tgl_akhir_kuliah']) 
          : null,
      isAktif: json['status'] == 'Y',
    );
  }

  // Konversi dari model ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id_thn_ak': idThnAk,
      'nama_thn_ak': tahun,
      'smt': semester,
      'tgl_awal_kuliah': startDate?.toIso8601String(),
      'tgl_akhir_kuliah': endDate?.toIso8601String(),
      'status': isAktif ? 'Y' : 'T',
    };
  }
}

// Fungsi untuk memformat tanggal menjadi string
String formatDate(DateTime date) {
  return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
}