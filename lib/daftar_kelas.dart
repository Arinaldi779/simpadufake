import 'package:flutter/material.dart';
import 'package:simpadu/dashboard_admin_akademik.dart';

class DaftarKelasPage extends StatefulWidget {
  const DaftarKelasPage({super.key});

  @override
  State<DaftarKelasPage> createState() => _DaftarKelasPageState();
}

class _DaftarKelasPageState extends State<DaftarKelasPage> {
  final List<Map<String, dynamic>> _kelasList = [
  ];
  
  final TextEditingController _searchController = TextEditingController();

  void _addKelas(Map<String, dynamic> kelas) {
    setState(() {
      _kelasList.add(kelas);
    });
  }

  void _editKelas(int index, Map<String, dynamic> kelas) {
    setState(() {
      _kelasList[index] = kelas;
    });
  }

  void _showAddEditDialog({int? index}) {
    final isEditing = index != null;
    final TextEditingController namaKelasController = TextEditingController();
    String? selectedProdi;
    String? selectedAngkatan;

    final List<String> prodiList = [
      'Teknik Informatika',
      'Sistem Informasi',
      'Teknik Komputer',
      'Bisnis Digital',
    ];

    final List<String> angkatanList = ['2020', '2021', '2022', '2023', '2024'];

    if (isEditing) {
      final kelas = _kelasList[index!];
      namaKelasController.text = kelas['nama_kelas'];
      selectedProdi = kelas['prodi'];
      selectedAngkatan = kelas['angkatan'];
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
                  mainAxisSize: MainAxisSize.min,
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
                          selectedProdi = value;
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
                          selectedAngkatan = value;
                        });
                      },
                    ),
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
                    child: ElevatedButton(
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
                        };

                        if (isEditing) {
                          _editKelas(index, kelas);
                        } else {
                          _addKelas(kelas);
                        }

                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
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
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
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
          ) ||
          kelas['prodi'].toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) ||
          kelas['angkatan'].toLowerCase().contains(
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
        child: Column(
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
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
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
            ),
            const SizedBox(height: 15),

            // Search Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Cari berdasarkan Nama Kelas, Prodi...',
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

            // List of Classes
            Expanded(
              child: _filteredKelasList.isEmpty
                  ? const Center(
                      child: Text(
                        'Tidak ada data kelas',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _filteredKelasList.length,
                      itemBuilder: (context, index) {
                        final kelas = _filteredKelasList[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(
                                color: Color(0xFF171717),
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Edit button at the top right
        
                                  
                                  // Class information
                                  Table(
                                    columnWidths: const {
                                      0: FlexColumnWidth(1.5),
                                      1: FlexColumnWidth(2),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(bottom: 8, top: 8),
                                            child: Text(
                                              'Nama Kelas',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF505050),
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 8, top: 8),
                                            child: Text(
                                              kelas['nama_kelas'],
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF171717),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(bottom: 8),
                                            child: Text(
                                              'Program Studi',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF505050),
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 8),
                                            child: Text(
                                              kelas['prodi'],
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF171717),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          const Text(
                                            'Angkatan',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF505050),
                                              fontSize: 13,
                                            ),
                                          ),
                                          Text(
                                            kelas['angkatan'],
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF171717),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: IconButton(
                                      icon: Image.asset(
                                        'assets/icons/edit.png',
                                        width: 24,
                                        height: 24,
                                      ),
                                      onPressed: () {
                                        _showAddEditDialog(index: index);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          left: 70.0,
          right: 70.0,
          top: 35.0,
          bottom: 35.0,
        ),
        child: SizedBox(
          width: 335,
          height: 60,
          child: ElevatedButton.icon(
            onPressed: _showAddEditDialog,
            icon: Image.asset(
              'assets/icons/plus_icon.png',
              width: 20,
              height: 20,
            ),
            label: const Text(
              'Tambah Kelas',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 19,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF392A9F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
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