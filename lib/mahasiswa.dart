import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:simpadu/dashboard_admin_akademik.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quickalert/quickalert.dart';
import '../services/auth_helper.dart';

class DaftarMasiswaPage extends StatefulWidget {
  const DaftarMasiswaPage({super.key});

  @override
  State<DaftarMasiswaPage> createState() => _DaftarMasiswaPageState();
}

class _DaftarMasiswaPageState extends State<DaftarMasiswaPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _mahasiswaList = [];
  List<Map<String, dynamic>> _kelasList = [];
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

      if (token == null || token.isEmpty) {
        if (mounted) {
          _handleUnauthorized(context);
        }
        return;
      }

      setState(() {
        _token = token;
      });

      await _fetchAllData();
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Gagal memuat token: $e';
        });
      }
    }
  }

  Future<void> _fetchAllData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      await Future.wait([
        _fetchMahasiswa(),
        _fetchKelas(),
      ]);

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Gagal memuat data: $e';
        });
      }
    }
  }

  Future<void> _fetchMahasiswa() async {
    final response = await http.get(
      Uri.parse('http://36.91.27.150:815/api/kls-master'),
      headers: {
        'Authorization': 'Bearer $_token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<dynamic> data = json['data'];
      if (mounted) {
        setState(() {
          _mahasiswaList = data.cast<Map<String, dynamic>>();
        });
      }
    } else if (response.statusCode == 401) {
      if (mounted) {
        _handleUnauthorized(context);
      }
    } else {
      throw Exception('Gagal memuat data mahasiswa');
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
      if (mounted) {
        setState(() {
          _kelasList = data.cast<Map<String, dynamic>>();
        });
      }
    } else if (response.statusCode == 401) {
      if (mounted) {
        _handleUnauthorized(context);
      }
    } else {
      throw Exception('Gagal memuat data kelas');
    }
  }

  void _handleUnauthorized(BuildContext context) {
    // Cegah alert duplikat jika sudah ada alert
    if (!mounted || ModalRoute.of(context)?.isCurrent == false) return;

    QuickAlert.show(
      context: context,
      type: QuickAlertType.warning,
      title: 'Sesi Berakhir',
      text: 'Silakan login kembali.',
      confirmBtnText: 'Login Ulang',
      onConfirmBtnTap: () {
        logoutAndRedirect(context);
      },
    );
  }

  Future<void> _tambahMahasiswa(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('http://36.91.27.150:815/api/kls-master'),
        headers: {
          'Authorization': 'Bearer $_token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await _fetchMahasiswa();
        if (mounted) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: 'Berhasil!',
            text: 'Mahasiswa berhasil ditambahkan',
            confirmBtnColor: Colors.green,
          );
        }
      } else if (response.statusCode == 401) {
        if (mounted) {
          _handleUnauthorized(context);
        }
      } else {
        throw Exception('Gagal menambahkan mahasiswa');
      }
    } catch (e) {
      if (mounted) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Gagal!',
          text: 'Error: $e',
          confirmBtnColor: Colors.red,
        );
      }
    }
  }

  List<Map<String, dynamic>> get filteredMahasiswa {
    if (_searchController.text.isEmpty) {
      return _mahasiswaList;
    }
    return _mahasiswaList.where((mhs) {
      final nim = mhs['nim']?.toLowerCase() ?? '';
      final namaKelas = _getNamaKelas(mhs['id_kelas'].toString());
      return nim.contains(_searchController.text.toLowerCase()) ||
          namaKelas.toLowerCase().contains(_searchController.text.toLowerCase());
    }).toList();
  }

  String _getNamaKelas(String idKelas) {
    final kelas = _kelasList.firstWhere(
      (k) => k['id_kelas'].toString() == idKelas,
      orElse: () => {'nama_kelas': 'Tidak Diketahui'},
    );
    return kelas['nama_kelas'];
  }

  void _showAddDialog() {
    final TextEditingController nimController = TextEditingController();
    final TextEditingController noAbsenController = TextEditingController();
    String? selectedKelasId;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: ScaleTransition(
              scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF392A9F),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      child: const Center(
                        child: Text(
                          'Tambah Mahasiswa',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // Form Content
                    SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: nimController,
                            style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
                            decoration: InputDecoration(
                              labelText: 'NIM*',
                              labelStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Color(0xFF656464),
                                fontWeight: FontWeight.w700,
                              ),
                              filled: true,
                              fillColor: const Color(0xFFEEEEEE),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildDropdownFormField(
                            value: selectedKelasId,
                            label: 'Kelas*',
                            items: _kelasList.map((kelas) {
                              return DropdownMenuItem(
                                value: kelas['id_kelas'].toString(),
                                child: Text(kelas['nama_kelas']),
                              );
                            }).toList(),
                            onChanged: (value) => setState(() => selectedKelasId = value),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: noAbsenController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
                            decoration: InputDecoration(
                              labelText: 'No Absen*',
                              labelStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Color(0xFF656464),
                                fontWeight: FontWeight.w700,
                              ),
                              filled: true,
                              fillColor: const Color(0xFFEEEEEE),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Buttons
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (nimController.text.isEmpty ||
                                    selectedKelasId == null ||
                                    noAbsenController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Harap isi semua field wajib!'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }
                                final data = {
                                  "nim": nimController.text,
                                  "id_kelas": int.parse(selectedKelasId!),
                                  "no_absen": int.parse(noAbsenController.text),
                                };
                                _tambahMahasiswa(data);
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              child: const Text(
                                'Simpan',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              child: const Text(
                                'Batal',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDropdownFormField({
    required String? value,
    required String label,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          color: Color(0xFF656464),
          fontWeight: FontWeight.w700,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Color(0xFF9A9393), width: 1),
        ),
        filled: true,
        fillColor: const Color(0xFFEEEEEE),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      items: items,
      onChanged: onChanged,
      isExpanded: true,
      itemHeight: 56,
      menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
      dropdownColor: Colors.white,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        color: Color(0xFF656464),
      ),
      icon: Image.asset(
        'assets/icons/down_arrow_icon.png',
        width: 24,
        height: 24,
      ),
      borderRadius: BorderRadius.circular(8),
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
              ElevatedButton(onPressed: _fetchAllData, child: const Text('Coba Lagi')),
            ],
          ),
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
                      MaterialPageRoute(builder: (context) => const DashboardAdmin()),
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
                    'Mahasiswa Kelas',
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
                  'Daftar Mahasiswa',
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
                  hintText: 'Cari berdasarkan NIM atau Kelas...',
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
                  itemCount: filteredMahasiswa.length,
                  itemBuilder: (context, index) {
                    final mhs = filteredMahasiswa[index];
                    final namaKelas = _getNamaKelas(mhs['id_kelas'].toString());
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 35),
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
                          side: const BorderSide(color: Color(0xFF171717), width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(1.5),
                                  1: FlexColumnWidth(2),
                                },
                                children: [
                                  TableRow(children: [
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 8, top: 8),
                                      child: Text(
                                        'NIM',
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
                                        mhs['nim'] ?? '-',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF171717),
                                        ),
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 8, top: 8),
                                      child: Text(
                                        'Kelas',
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
                                        namaKelas,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF171717),
                                        ),
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 8, top: 8),
                                      child: Text(
                                        'No Absen',
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
                                        mhs['no_absen'].toString(),
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF171717),
                                        ),
                                      ),
                                    ),
                                  ]),
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
        padding: const EdgeInsets.only(left: 70.0, right: 70.0, top: 35.0, bottom: 35.0),
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
              'Tambah Mahasiswa',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 19,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF392A9F),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}