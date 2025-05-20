import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:simpadu/dashboard_admin_akademik.dart';

class DaftarKelasPage extends StatefulWidget {
  const DaftarKelasPage({super.key});

  @override
  State<DaftarKelasPage> createState() => _DaftarKelasPageState();
}

class _DaftarKelasPageState extends State<DaftarKelasPage> {
  final List<Map<String, dynamic>> _kelasList = [];
  final TextEditingController _searchController = TextEditingController();

  void _addKelas(Map<String, dynamic> kelas) {
    setState(() {
      if (kelas['isAktif']) {
        for (var item in _kelasList) {
          item['isAktif'] = false;
        }
      }
      _kelasList.add(kelas);
    });
  }

  void _editKelas(int index, Map<String, dynamic> kelas) {
    setState(() {
      if (kelas['isAktif']) {
        for (var item in _kelasList) {
          item['isAktif'] = false;
        }
      }
      _kelasList[index] = kelas;
    });
  }

  void _showAddEditDialog({int? index}) {
    final isEditing = index != null;
    final TextEditingController namaKelasController = TextEditingController();
    String? selectedProdi;
    String? selectedAngkatan;
    bool isAktif = false;

    final List<String> prodiList = [
      'Teknik Informatika',
      'Sistem Informasi',
      'Teknik Komputer',
      'Bisnis Digital'
    ];
    
    final List<String> angkatanList = [
      '2020',
      '2021',
      '2022',
      '2023',
      '2024'
    ];

    if (isEditing) {
      final kelas = _kelasList[index!];
      namaKelasController.text = kelas['nama_kelas'];
      selectedProdi = kelas['prodi'];
      selectedAngkatan = kelas['angkatan'];
      isAktif = kelas['isAktif'];
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titlePadding: EdgeInsets.zero,
          title: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFF392A9F),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Center(
              child: Text(
                isEditing ? 'Edit Kelas' : 'Tambah Kelas',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: namaKelasController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Kelas*',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: selectedProdi,
                      decoration: const InputDecoration(
                        labelText: 'Program Studi*',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      items: prodiList.map((prodi) {
                        return DropdownMenuItem<String>(
                          value: prodi,
                          child: Text(prodi),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedProdi = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: selectedAngkatan,
                      decoration: const InputDecoration(
                        labelText: 'Angkatan*',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      items: angkatanList.map((tahun) {
                        return DropdownMenuItem<String>(
                          value: tahun,
                          child: Text(tahun),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedAngkatan = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              );
            },
          ),
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          actions: [
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (namaKelasController.text.isEmpty ||
                            selectedProdi == null ||
                            selectedAngkatan == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Harap isi semua field yang wajib!',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        final kelas = {
                          'nama_kelas': namaKelasController.text,
                          'prodi': selectedProdi!,
                          'angkatan': selectedAngkatan!,
                          'tahun_akademik': '${selectedAngkatan!}/${int.parse(selectedAngkatan!) + 1}',
                          'jumlah_mahasiswa': 35,
                        };

                        if (isEditing) {
                          _editKelas(index!, kelas);
                        } else {
                          _addKelas(kelas);
                        }

                        Navigator.pop(context);

                        Future.delayed(const Duration(milliseconds: 200), () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.leftSlide,
                            title: 'Berhasil',
                            desc: isEditing
                                ? 'Kelas berhasil diubah!'
                                : 'Kelas berhasil ditambahkan!',
                            btnOkOnPress: () {},
                          ).show();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(
                        Icons.check,
                        color: Color(0xFFFFFFFF),
                        size: 16,
                      ),
                      label: const Text(
                        'Simpan',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(
                        Icons.close,
                        color: Color(0xFFFFFFFF),
                        size: 16,
                      ),
                      label: const Text(
                        'Batalkan',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  List<Map<String, dynamic>> get _filteredKelasList {
    if (_searchController.text.isEmpty) {
      return _kelasList;
    }
    return _kelasList.where((kelas) {
      return kelas['nama_kelas'].toLowerCase().contains(
            _searchController.text.toLowerCase(),
          );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2103FF), Color(0xFF140299)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.71],
            ),
          ),
        ),
        title: Row(
          children: [
            Image.asset('assets/images/logo2.png', width: 60, height: 60),
            const SizedBox(width: 10),
            const Text(
              'SIMPADU',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumb
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashboardAdmin(),
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 30.0, left: 10.0),
                      child: Text(
                        'Dashboard',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF686868),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    ' > ',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF686868),
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text(
                      'Kelas',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Title
              const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text(
                  'Daftar Kelas',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Search Field
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari Kelas...',
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
                ),
              ),
              const SizedBox(height: 20),

              // List Kelas
              if (_filteredKelasList.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Center(
                    child: Text(
                      'Tidak ada data kelas',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _filteredKelasList.length,
                  itemBuilder: (context, index) {
                    final kelas = _filteredKelasList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'NAMA KELAS',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF505050),
                                            fontSize: 13,
                                          ),
                                        ),
                                        Text(
                                          kelas['nama_kelas'] ?? '-',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF171717),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'PRODI',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF505050),
                                            fontSize: 13,
                                          ),
                                        ),
                                        Text(
                                          kelas['prodi'] ?? '-',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF171717),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'ANGKATAN',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF505050),
                                            fontSize: 13,
                                          ),
                                        ),
                                        Text(
                                          kelas['angkatan'] ?? '-',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF171717),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'TAHUN AKADEMIK',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF505050),
                                            fontSize: 13,
                                          ),
                                        ),
                                        Text(
                                          kelas['tahun_akademik'] ?? '-',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF171717),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'JUMLAH MAHASISWA',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF505050),
                                            fontSize: 13,
                                          ),
                                        ),
                                        Text(
                                          (kelas['jumlah_mahasiswa'] ?? 0)
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF171717),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      _showAddEditDialog(index: index);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

              const SizedBox(height: 80), // Space for the bottom button
            ],
          ),
        ),
      ),
      // Tombol Tambah Kelas
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: ElevatedButton.icon(
            onPressed: () {
              _showAddEditDialog();
            },
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              'Tambah Kelas',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF392A9F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}