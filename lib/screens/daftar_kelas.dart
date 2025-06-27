import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:simpadu/screens/dashboard_admin_akademik.dart';
import 'package:simpadu/services/auth_helper.dart';
import 'package:simpadu/services/auth_middleware.dart';
import '/models/daftar_kelas_model.dart';
import '/services/daftar_kelas_service.dart';

class DaftarKelasPage extends StatefulWidget {
  const DaftarKelasPage({super.key});

  @override
  State<DaftarKelasPage> createState() => _DaftarKelasPageState();
}

class _DaftarKelasPageState extends State<DaftarKelasPage> {
  final TextEditingController _searchController = TextEditingController();
  final KelasService _kelasService = KelasService();
  List<Kelas> _kelasList = [];
  List<Prodi> _prodiList = [];
  List<TahunAkademik> _tahunAkademikList = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _checkAuthAndFetch();
  }

  Future<void> _checkAuthAndFetch() async {
    final valid = await isTokenValid();
    if (!valid && mounted) {
      handleUnauthorized(context);
      return;
    }
    await _fetchAllData();
  }

  Future<void> _fetchAllData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final results = await Future.wait([
        _kelasService.fetchKelas(),
        _kelasService.fetchProdiDanTahunAkademik(),
      ]);

      setState(() {
        _kelasList = results[0] as List<Kelas>;
        _prodiList =
            (results[1] as Map<String, dynamic>)['prodiList'] as List<Prodi>;
        _tahunAkademikList =
            (results[1] as Map<String, dynamic>)['tahunAkademikList']
                as List<TahunAkademik>;
        _isLoading = false;
      });
    } catch (e) {
      String errMsg = e.toString();
      String status = '';
      String message = errMsg;
      if (errMsg.contains('|')) {
        final parts = errMsg.split('|');
        status = parts[0];
        message = parts.sublist(1).join('|');
      }
      setState(() {
        _isLoading = false;
        _errorMessage = message;
      });
      if ((status == '401' || message.contains('401')) && mounted) {
        handleUnauthorized(context);
      } else if (mounted) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Terjadi Kesalahan',
          text: message,
          confirmBtnText: 'Coba Lagi',
          confirmBtnColor: Colors.blue,
          onConfirmBtnTap: () {
            Navigator.of(context, rootNavigator: true).pop();
            _fetchAllData();
          },
        );
      }
    }
  }

  // void _handleUnauthorized(BuildContext context) {
  //   if (!mounted || ModalRoute.of(context)?.isCurrent == false) return;

  //   QuickAlert.show(
  //     context: context,
  //     type: QuickAlertType.warning,
  //     title: 'Sesi Berakhir',
  //     text: 'Silakan login kembali.',
  //     confirmBtnText: 'Login Ulang',
  //     onConfirmBtnTap: () {
  //       logoutAndRedirect(context);
  //     },
  //   );
  // }

  List<Kelas> get _filteredKelasList {
    if (_searchController.text.isEmpty) {
      return _kelasList;
    }
    return _kelasList.where((kelas) {
      final namaProdi = _getNamaProdi(kelas.idProdi);
      final tahunAkademik = _getNamaTahunAkademik(kelas.idThnAk);
      return kelas.namaKelas.toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) ||
          kelas.alias.toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) ||
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
      (p) => p.idProdi == idProdi,
      orElse: () => Prodi(idProdi: '', namaProdi: 'Prodi tidak ditemukan'),
    );
    return prodi.namaProdi;
  }

  String _getNamaTahunAkademik(String idTahunAkademik) {
    final tahunAkademik = _tahunAkademikList.firstWhere(
      (t) => t.idThnAk == idTahunAkademik,
      orElse:
          () => TahunAkademik(
            idThnAk: '',
            namaThnAk: 'Tahun akademik tidak ditemukan',
          ),
    );
    return tahunAkademik.namaThnAk;
  }

  void _showAddDialog() {
    final TextEditingController namaKelasController = TextEditingController();
    final TextEditingController aliasController = TextEditingController();
    String? selectedProdiId;
    String? selectedTahunAkademikId;

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
                          'Tambah Kelas',
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
                            controller: namaKelasController,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Nama Kelas*',
                              labelStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Color(0xFF656464),
                                fontWeight: FontWeight.w700,
                              ),
                              filled: true,
                              fillColor: Color(0xFFEEEEEE),
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
                          TextFormField(
                            controller: aliasController,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Color(0xFF656464),
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Alias*',
                              labelStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Color(0xFF656464),
                                fontWeight: FontWeight.w700,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xFF9A9393),
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
                            value: selectedProdiId,
                            label: 'Program Studi*',
                            items:
                                _prodiList.map((prodi) {
                                  return DropdownMenuItem(
                                    value: prodi.idProdi,
                                    child: Text(
                                      prodi.namaProdi,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }).toList(),
                            onChanged:
                                (value) =>
                                    setState(() => selectedProdiId = value),
                          ),
                          const SizedBox(height: 10),
                          _buildDropdownFormField(
                            value: selectedTahunAkademikId,
                            label: 'Tahun Akademik*',
                            items:
                                _tahunAkademikList.map((tahun) {
                                  return DropdownMenuItem(
                                    value: tahun.idThnAk,
                                    child: Text(
                                      tahun.namaThnAk,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }).toList(),
                            onChanged:
                                (value) => setState(
                                  () => selectedTahunAkademikId = value,
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
                                if (namaKelasController.text.isEmpty ||
                                    aliasController.text.isEmpty ||
                                    selectedProdiId == null ||
                                    selectedTahunAkademikId == null) {
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
                                final kelasBaru = Kelas(
                                  namaKelas: namaKelasController.text,
                                  alias: aliasController.text,
                                  idProdi: selectedProdiId!,
                                  idThnAk: selectedTahunAkademikId!,
                                );
                                try {
                                  await _kelasService.tambahKelas(kelasBaru);
                                  await _fetchAllData();
                                  if (mounted) {
                                    Navigator.pop(context);
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.success,
                                      title: 'Berhasil!',
                                      text: 'Kelas berhasil ditambahkan',
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
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Image.asset(
                      'assets/icons/search.png', // Ganti dengan path gambar kamu
                      width: 20,
                      height: 20,
                      color: Colors.grey, // opsional, jika ingin ubah warna
                    ),
                  ),
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
                    final namaProdi = _getNamaProdi(kelas.idProdi);
                    final tahunAkademik = _getNamaTahunAkademik(kelas.idThnAk);
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 25,
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
                            left: 40.0,
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
                                          kelas.namaKelas,
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
                                          kelas.alias,
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
                                        'Angkatan',
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
