class Kurikulum {
  final int idKurikulum;
  final String namaMatakuliah;
  final String namaTahunAkademik;
  final String namaProdi;
  final String ket;

  Kurikulum({
    required this.idKurikulum,
    required this.namaMatakuliah,
    required this.namaTahunAkademik,
    required this.namaProdi,
    required this.ket,
  });

  factory Kurikulum.fromJson(Map<String, dynamic> json) {
    return Kurikulum(
      idKurikulum: json['id_kurikulum'],
      namaMatakuliah: json['nama_matakuliah'],
      namaTahunAkademik: json['nama_tahun_akademik'],
      namaProdi: json['nama_prodi'],
      ket:
          (json['ket'] as String?)?.trim() == ''
              ? '-'
              : json['ket'] ?? 'Tidak Ada Keterangan',
    );
  }
}

// Untuk dropdown
class MataKuliah {
  final int idMk;
  final String kodeMk;
  final String namaMk;
  final int sks;

  MataKuliah({
    required this.idMk,
    required this.kodeMk,
    required this.namaMk,
    required this.sks,
  });

  factory MataKuliah.fromJson(Map<String, dynamic> json) {
    return MataKuliah(
      idMk: json['id_mk'],
      kodeMk: json['kode_mk'],
      namaMk: json['nama_mk'],
      sks: json['sks'],
    );
  }
}

class Prodi {
  final int idProdi;
  final String kodeProdi;
  final String namaProdi;

  Prodi({
    required this.idProdi,
    required this.kodeProdi,
    required this.namaProdi,
  });

  factory Prodi.fromJson(Map<String, dynamic> json) {
    return Prodi(
      idProdi: json['id_prodi'],
      kodeProdi: json['kode_prodi'],
      namaProdi: json['nama_prodi'],
    );
  }
}

class TahunAkademik {
  final String idThnAk;
  final String namaThnAk;
  final String? smt;
  final String status;
  final String? tglAwalKuliah;
  final String? tglAkhirKuliah;
  final String statusAktif;

  TahunAkademik({
    required this.idThnAk,
    required this.namaThnAk,
    this.smt,
    required this.status,
    this.tglAwalKuliah,
    this.tglAkhirKuliah,
    required this.statusAktif,
  });

  factory TahunAkademik.fromJson(Map<String, dynamic> json) {
    return TahunAkademik(
      idThnAk: json['id_thn_ak'],
      namaThnAk: json['nama_thn_ak'],
      smt: json['smt'],
      status: json['status'],
      tglAwalKuliah: json['tgl_awal_kuliah'],
      tglAkhirKuliah: json['tgl_akhir_kuliah'],
      statusAktif: json['status_aktif'],
    );
  }
}

class DropdownData {
  final List<MataKuliah> matakuliahList;
  final List<Prodi> prodiList;
  final List<TahunAkademik> tahunAkademikList;

  DropdownData({
    required this.matakuliahList,
    required this.prodiList,
    required this.tahunAkademikList,
  });

  factory DropdownData.fromJson(Map<String, dynamic> json) {
    final dynamic mkRaw = json['dataMk'];
    final dynamic prodiRaw = json['dataProdi'];
    final dynamic tahunAkRaw = json['dataTahunAkademik'];

    final List<MataKuliah> matakuliahList =
        (mkRaw is List)
            ? mkRaw
                .where((item) => item is Map<String, dynamic>)
                .map(
                  (item) => MataKuliah.fromJson(item as Map<String, dynamic>),
                )
                .toList()
            : [];

    final List<Prodi> prodiList =
        (prodiRaw is List)
            ? prodiRaw
                .where((item) => item is Map<String, dynamic>)
                .map((item) => Prodi.fromJson(item as Map<String, dynamic>))
                .toList()
            : [];

    final List<TahunAkademik> tahunAkademikList =
        (tahunAkRaw is List)
            ? tahunAkRaw
                .where((item) => item is Map<String, dynamic>)
                .map(
                  (item) =>
                      TahunAkademik.fromJson(item as Map<String, dynamic>),
                )
                .toList()
            : [];

    return DropdownData(
      matakuliahList: matakuliahList,
      prodiList: prodiList,
      tahunAkademikList: tahunAkademikList,
    );
  }
}
