import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'services/auth_helper.dart';
import 'package:simpadu/dashboard_admin_akademik.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DaftarKelasPage extends StatefulWidget {
  const DaftarKelasPage({super.key});

  @override
  State<DaftarKelasPage> createState() => _DaftarKelasPageState();
}

class _DaftarKelasPageState extends State<DaftarKelasPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _kelasList = [];
  List<Map<String, dynamic>> _prodiList = [];
  List<Map<String, dynamic>> _tahunAkademikList = [];
  bool _isLoading = true;
  String? _errorMessage;
  String? _token;

  @override
  void initState() {
    super.initState();
    _loadTokenAndFetchData();
  }

  Future<void> _loadTokenAndFetchData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token == null) {
        logoutAndRedirect(context);
        return;
      }
      setState(() {
        _token = token;
      });
      await _fetchAllData();
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Gagal memuat token: ${e.toString()}';
      });
    }
  }

  Future<void> _fetchAllData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      await Future.wait([
        _fetchKelas(),
        _fetchProdiDanTahunAkademik(),
      ]);

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Gagal memuat data: ${e.toString()}';
      });
    }
  }

  Future<void> _fetchKelas() async {
    final response = await http.get(
      Uri.parse('http://36.91.27.150:815/api/siapkelas'),
      headers: {
        'Authorization': 'Bearer $_token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<dynamic> data = json['data'];
      setState(() {
        _kelasList = data.map((item) => item as Map<String, dynamic>).toList();
      });
    } else if (response.statusCode == 401) {
      throw Exception('Token tidak valid atau kedaluwarsa');
    } else {
      throw Exception('Gagal memuat data kelas');
    }
  }

  Future<void> _fetchProdiDanTahunAkademik() async {
    final response = await http.get(
      Uri.parse('http://36.91.27.150:815/api/thnak-prodi'),
      headers: {
        'Authorization': 'Bearer $_token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      setState(() {
        _prodiList = List<Map<String, dynamic>>.from(json['dataProdi']);
        _tahunAkademikList = List<Map<String, dynamic>>.from(json['dataTahunAkademik']);
      });
    } else if (response.statusCode == 401) {
      throw Exception('Token tidak valid atau kedaluwarsa');
    } else {
      throw Exception('Gagal memuat data prodi dan tahun akademik');
    }
  }

  Future<void> _tambahKelas(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('http://36.91.27.150:815/api/siapkelas'),
        headers: {
          'Authorization': 'Bearer $_token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await _fetchKelas();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kelas berhasil ditambahkan'),
            backgroundColor: Colors.green,
          ),
        );
      } else if (response.statusCode == 401) {
        throw Exception('Token tidak valid atau kedaluwarsa');
      } else {
        throw Exception('Gagal menambahkan kelas');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  List<Map<String, dynamic>> get _filteredKelasList {
    if (_searchController.text.isEmpty) {
      return _kelasList;
    }
    return _kelasList.where((kelas) {
      final namaProdi = _getNamaProdi(kelas['id_prodi']?.toString() ?? '');
      final tahunAkademik = _getNamaTahunAkademik(kelas['id_thn_ak']?.toString() ?? '');

      return (kelas['nama_kelas']?.toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) ??
          false) ||
          (kelas['alias']?.toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) ??
          false) ||
          namaProdi.toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) ||
          tahunAkademik.toLowerCase().contains(
            _searchController.text.toLowerCase(),
          );
    }).toList();
  }

  String _getNamaProdi(String idProdi) {
    final prodi = _prodiList.firstWhere(
      (p) => p['id_prodi'].toString() == idProdi,
      orElse: () => {'nama_prodi': 'Prodi tidak ditemukan'},
    );
    return prodi['nama_prodi'];
  }

  String _getNamaTahunAkademik(String idTahunAkademik) {
    final tahunAkademik = _tahunAkademikList.firstWhere(
      (t) => t['id_thn_ak'].toString() == idTahunAkademik,
      orElse: () => {'nama_thn_ak': 'Tahun akademik tidak ditemukan'},
    );
    return tahunAkademik['nama_thn_ak'];
  }

  void _showAddDialog() {
    final TextEditingController namaKelasController = TextEditingController();
    final TextEditingController aliasController = TextEditingController();
    String? selectedProdiId;
    String? selectedTahunAkademikId;

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
                'Tambah Kelas',
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
            builder: (context, setDialogState) {
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
                    TextField(
                      controller: aliasController,
                      decoration: const InputDecoration(
                        labelText: 'Alias*',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: selectedProdiId,
                      decoration: const InputDecoration(
                        labelText: 'Program Studi*',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      items: _prodiList.map((prodi) {
                        return DropdownMenuItem(
                          value: prodi['id_prodi'].toString(),
                          child: Text(prodi['nama_prodi']),
                        );
                      }).toList(),
                      onChanged: (value) => setDialogState(() => selectedProdiId = value),
                      validator: (value) => value == null ? 'Harap pilih Program Studi' : null,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: selectedTahunAkademikId,
                      decoration: const InputDecoration(
                        labelText: 'Tahun Akademik*',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      items: _tahunAkademikList.map((tahun) {
                        return DropdownMenuItem(
                          value: tahun['id_thn_ak'].toString(),
                          child: Text(tahun['nama_thn_ak']),
                        );
                      }).toList(),
                      onChanged: (value) => setDialogState(() => selectedTahunAkademikId = value),
                      validator: (value) => value == null ? 'Harap pilih Tahun Akademik' : null,
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
                            aliasController.text.isEmpty ||
                            selectedProdiId == null ||
                            selectedTahunAkademikId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Harap isi semua field yang wajib!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        final kelasBaru = {
                          'nama_kelas': namaKelasController.text,
                          'alias': aliasController.text,
                          'id_prodi': int.parse(selectedProdiId!),
                          'id_thn_ak': selectedTahunAkademikId,
                        };

                        _tambahKelas(kelasBaru);
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
                        'Batal',
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

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_errorMessage != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_errorMessage!),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _fetchAllData,
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    if (_kelasList.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Tidak ada kelas ditemukan'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _fetchAllData,
                child: const Text('Muat Ulang'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddDialog,
          backgroundColor: const Color(0xFF392A9F),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      );
    }

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
                  style: TextStyle(fontSize: 15, color: Color(0xFF686868)),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
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
            Expanded(
              child: RefreshIndicator(
                onRefresh: _fetchAllData,
                child: ListView.builder(
                  itemCount: _filteredKelasList.length,
                  itemBuilder: (context, index) {
                    final kelas = _filteredKelasList[index];
                    final namaProdi = _getNamaProdi(kelas['id_prodi']?.toString() ?? '');
                    final tahunAkademik = _getNamaTahunAkademik(kelas['id_thn_ak']?.toString() ?? '');

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
                              Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(1.5),
                                  1: FlexColumnWidth(2),
                                },
                                children: [
                                  TableRow(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          bottom: 8,
                                          top: 8,
                                        ),
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
                                        padding: const EdgeInsets.only(
                                          bottom: 8,
                                          top: 8,
                                        ),
                                        child: Text(
                                          kelas['nama_kelas'] ?? '-',
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
                                        padding: EdgeInsets.only(
                                          bottom: 8,
                                          top: 8,
                                        ),
                                        child: Text(
                                          'Alias',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF505050),
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 8,
                                          top: 8,
                                        ),
                                        child: Text(
                                          kelas['alias'] ?? '-',
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
                                        padding: EdgeInsets.only(
                                          bottom: 8,
                                          top: 8,
                                        ),
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
                                        padding: const EdgeInsets.only(
                                          bottom: 8,
                                          top: 8,
                                        ),
                                        child: Text(
                                          namaProdi,
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
                                        'Tahun Akademik',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF505050),
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        tahunAkademik,
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
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
            onPressed: _showAddDialog,
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
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF392A9F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}