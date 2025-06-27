class DosenAjar {
  final int idKelas;
  final int idPegawai;
  final String namaKelas;
  final String namaMk;

  DosenAjar({
    required this.idKelas,
    required this.idPegawai,
    required this.namaKelas,
    required this.namaMk,
  });

  factory DosenAjar.fromJson(Map<String, dynamic> json) {
    return DosenAjar(
      idKelas: json['id_kelas'] ?? 0,
      idPegawai: json['id_pegawai'] ?? 0,
      namaKelas: json['nama_kelas'] ?? '',
      namaMk: json['nama_mk'] ?? '',
    );
  }
}

class PegawaiRingkas {
  final int idPegawai;
  final String nama;

  PegawaiRingkas({required this.idPegawai, required this.nama});

  factory PegawaiRingkas.fromJson(Map<String, dynamic> json) {
    return PegawaiRingkas(
      idPegawai: json['id_pegawai'] ?? 0,
      nama: json['nama_pegawai'] ?? '',
    );
  }
}

class Kelas {
  final int idProdi;
  final String namaProdi;

  Kelas({required this.idProdi, required this.namaProdi});

  factory Kelas.fromJson(Map<String, dynamic> json) {
    return Kelas(
      idProdi: json['id_prodi'] ?? 0,
      namaProdi: json['nama_kelas'] ?? '', // Sesuaikan field jika di API sebenarnya 'nama_kelas'
    );
  }
}

class Kurikulum {
  final int idKurikulum;
  final String namaMk;
  final String tahunAkademik;

  Kurikulum({
    required this.idKurikulum,
    required this.namaMk,
    required this.tahunAkademik,
  });

  factory Kurikulum.fromJson(Map<String, dynamic> json) {
    return Kurikulum(
      idKurikulum: json['id_kurikulum'] ?? 0,
      namaMk: json['nama_mk'] ?? '',
      tahunAkademik: json['tahun_akademik'] ?? '',
    );
  }
}