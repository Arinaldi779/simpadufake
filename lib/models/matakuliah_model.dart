class MataKuliah {
  final int idMk;
  final String kodeMk;
  final String namaMk;
  final int sks;
  final int? jam;
  final int? idProdi;

  MataKuliah({
    required this.idMk,
    required this.kodeMk,
    required this.namaMk,
    required this.sks,
    this.jam,
    this.idProdi,
  });

  factory MataKuliah.fromJson(Map<String, dynamic> json) {
    return MataKuliah(
      idMk: json['id_mk'] ?? json['idMk'] ?? 0,
      kodeMk: json['kode_mk'] ?? json['kodeMk'] ?? '',
      namaMk: json['nama_mk'] ?? json['namaMk'] ?? '',
      sks: int.tryParse(json['sks'].toString()) ?? 0,
      jam: json['jam'] ?? 0,
      idProdi: json['id_prodi'] ?? json['idProdi'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kode_mk': kodeMk,
      'nama_mk': namaMk,
      'id_prodi': idProdi,
      'sks': sks,
      'jam': jam,
    };
  }
}

class DropdownDataMk {
  final List<Prodi> prodiList;

  DropdownDataMk({required this.prodiList});

  factory DropdownDataMk.fromJson(Map<String, dynamic> json) {
    var prodiJson = json['prodi'] as List;
    List<Prodi> prodiList = prodiJson.map((i) => Prodi.fromJson(i)).toList();

    return DropdownDataMk(
      prodiList: prodiList,
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
      idProdi: json['id_prodi'] ?? json['idProdi'] ?? 0,
      kodeProdi: json['kode_prodi'] ?? json['kodeProdi'] ?? '',
      namaProdi: json['nama_prodi'] ?? json['namaProdi'] ?? '',
    );
  }
}