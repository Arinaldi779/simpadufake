import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:simpadu/dashboard_admin_akademik.dart';
import 'package:simpadu/services/auth_helper.dart';
import '../models/mahasiswa_model.dart';
import '../services/mahasiswa_service.dart';

class DaftarMasiswaPage extends StatefulWidget {
  const DaftarMasiswaPage({super.key});

  @override
  State<DaftarMasiswaPage> createState() => _DaftarMasiswaPageState();
}

class _DaftarMasiswaPageState extends State<DaftarMasiswaPage> {
  final TextEditingController _searchController = TextEditingController();
  final MahasiswaService _mahasiswaService = MahasiswaService();
  List<Mahasiswa> _mahasiswaList = [];
  List<Kelas> _kelasList = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchAllData();
  }

  Future<void> _fetchAllData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final results = await Future.wait([
        _mahasiswaService.fetchMahasiswa(),
        _mahasiswaService.fetchKelas(),
      ]);

      setState(() {
        _mahasiswaList = results[0] as List<Mahasiswa>;
        _kelasList = results[1] as List<Kelas>;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Gagal memuat data: $e';
      });
      if (e.toString().contains('401')) {
        _handleUnauthorized(context);
      }
    }
  }

  void _handleUnauthorized(BuildContext context) {
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

  List<Mahasiswa> get filteredMahasiswa {
    if (_searchController.text.isEmpty) {
      return _mahasiswaList;
    }
    return _mahasiswaList.where((mhs) {
      final namaKelas = _getNamaKelas(mhs.idKelas);
      return mhs.nim.toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) ||
          namaKelas.toLowerCase().contains(
            _searchController.text.toLowerCase(),
          );
    }).toList();
  }

  String _getNamaKelas(int idKelas) {
    final kelas = _kelasList.firstWhere(
      (k) => k.idKelas == idKelas,
      orElse: () => Kelas(idKelas: 0, namaKelas: 'Tidak Diketahui'),
    );
    return kelas.namaKelas;
  }

  void _showAddDialog() {
    final TextEditingController nimController = TextEditingController();
    final TextEditingController noAbsenController = TextEditingController();
    int? selectedKelasId;

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
              scale: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutBack,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Color(0xFF392A9F),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
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

                    SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 18,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: nimController,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
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
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xFFEEEEEE),
                                  width: 1,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildDropdownFormField(
                            value: selectedKelasId?.toString(),
                            label: 'Kelas*',
                            items:
                                _kelasList.map((kelas) {
                                  return DropdownMenuItem(
                                    value: kelas.idKelas.toString(),
                                    child: Text(kelas.namaKelas),
                                  );
                                }).toList(),
                            onChanged:
                                (value) => setState(
                                  () => selectedKelasId = int.parse(value!),
                                ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: noAbsenController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
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
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xFFEEEEEE),
                                  width: 1,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (nimController.text.isEmpty ||
                                    selectedKelasId == null ||
                                    noAbsenController.text.isEmpty) {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.error,
                                    title: 'Gagal!',
                                    text: 'Harap isi semua field wajib!',
                                    confirmBtnColor: Colors.red,
                                  );

                                  return;
                                }
                                final mahasiswaBaru = Mahasiswa(
                                  nim: nimController.text,
                                  idKelas: selectedKelasId!,
                                  noAbsen: int.parse(noAbsenController.text),
                                );
                                try {
                                  await _mahasiswaService.tambahMahasiswa(
                                    mahasiswaBaru,
                                  );
                                  await _fetchAllData();
                                  if (mounted) {
                                    Navigator.pop(context);
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.success,
                                      title: 'Berhasil!',
                                      text: 'Mahasiswa berhasil ditambahkan',
                                      confirmBtnColor: Colors.green,
                                    );
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
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
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
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
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
              ElevatedButton(
                onPressed: _fetchAllData,
                child: const Text('Coba Lagi'),
              ),
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
                  itemCount: filteredMahasiswa.length,
                  itemBuilder: (context, index) {
                    final mhs = filteredMahasiswa[index];
                    final namaKelas = _getNamaKelas(mhs.idKelas);
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 55,
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
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 20.0,
                            bottom: 20.0,
                            right: 20.0,
                            left: 50.0,
                          ),
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
                                          'NIM',
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
                                          mhs.nim,
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
                                          'Kelas',
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
                                          namaKelas,
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
                                          'No Absen',
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
                                          mhs.noAbsen.toString(),
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF171717),
                                          ),
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
