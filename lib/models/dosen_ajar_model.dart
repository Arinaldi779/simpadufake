// models/dosen_ajar_model.dart
class DosenAjar {
  final int idKelasMk;
  final int idKelas;
  final int idKurikulum;
  final int idPegawai;
  final String namaKelas;
  final String namaMk;
  

  DosenAjar({
    required this.idKelasMk,
    required this.idKelas,
    required this.idKurikulum,
    required this.idPegawai,
    required this.namaKelas,
    required this.namaMk,
  });

  factory DosenAjar.fromJson(Map<String, dynamic> json) {
    return DosenAjar(
      idKelasMk: json['id_kelas_mk'],
      idKelas: json['id_kelas'],
      idKurikulum: json['id_kurikulum'],
      idPegawai: json['id_pegawai'],
      namaKelas: json['nama_kelas'],
      namaMk: json['nama_mk'],
    );
  }
}

class Pegawai {
  final int idPegawai;
  final String namaPegawai;

  Pegawai({
    required this.idPegawai,
    required this.namaPegawai,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) {
    return Pegawai(
      idPegawai: json['id_pegawai'],
      namaPegawai: json['nama_pegawai'],
    );
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
      idKelas: json['id_kelas'],
      namaKelas: json['nama_kelas'],
    );
  }
}

class KurikulumKelas {
  final int idKurikulum;
  final String namaMk;
  final String namaTahunAkademik;
  final String namaProdi;
  final String ket;

  KurikulumKelas({
    required this.idKurikulum,
    required this.namaMk,
    required this.namaTahunAkademik,
    required this.namaProdi,
    required this.ket,
  });

  factory KurikulumKelas.fromJson(Map<String, dynamic> json) {
    return KurikulumKelas(
      idKurikulum: json['id_kurikulum'],
      namaMk: json['nama_mk'],
      namaTahunAkademik: json['nama_tahun_akademik'],
      namaProdi: json['nama_prodi'] ?? 'N/A',
      ket: json['ket'] ?? '',
    );
  }
}

class DropdownDosenAjarData {
  final List<Pegawai> pegawaiList;
  final List<Kelas> kelasList;
  final List<KurikulumKelas> kurikulumList;

  DropdownDosenAjarData({
    required this.pegawaiList,
    required this.kelasList,
    required this.kurikulumList,
  });
}