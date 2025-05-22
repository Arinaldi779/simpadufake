class TahunAkademik {
  final String id;
  final String nama;
  final String semester;
  final String status;
  final DateTime? tglAwal;
  final DateTime? tglAkhir;
  final bool isAktif;

  TahunAkademik({
    required this.id,
    required this.nama,
    required this.semester,
    required this.status,
    this.tglAwal,
    this.tglAkhir,
    required this.isAktif,
  });

  factory TahunAkademik.fromJson(Map<String, dynamic> json) {
    return TahunAkademik(
      id: json['id_thn_ak'] ?? '',
      nama: json['nama_thn_ak'] ?? '',
      semester: json['smt'] ?? '',
      status: json['status'] ?? 'Y',
      tglAwal: json['tgl_awal_kuliah'] != null 
          ? DateTime.parse(json['tgl_awal_kuliah'])
          : null,
      tglAkhir: json['tgl_akhir_kuliah'] != null
          ? DateTime.parse(json['tgl_akhir_kuliah'])
          : null,
      isAktif: json['status_aktif'] == 'Aktif',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_thn_ak': id,
      'nama_thn_ak': nama,
      'smt': semester,
      'status': status,
      'tgl_awal_kuliah': tglAwal?.toIso8601String(),
      'tgl_akhir_kuliah': tglAkhir?.toIso8601String(),
      'status_aktif': isAktif ? 'Aktif' : 'Tidak Aktif',
    };
  }
}