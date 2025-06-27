import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import '../../screens/dashboard_admin_prodi.dart';
import 'package:simpadu/services/auth_helper.dart';
import 'package:simpadu/services/auth_middleware.dart';
import 'package:simpadu/models/dosen_ajar_model.dart';
import 'package:simpadu/services/dosen_ajar_service.dart';

class DosenAjarPage extends StatefulWidget {
  const DosenAjarPage({super.key});

  @override
  State<DosenAjarPage> createState() => _DosenAjarPageState();
}

class _DosenAjarPageState extends State<DosenAjarPage> {
  final TextEditingController _searchController = TextEditingController();
  final DosenAjarService _service = DosenAjarService();
  List<DosenAjar> _dosenAjarList = [];
  late List<Kelas> _kelasList;
  late List<PegawaiRingkas> _pegawaiList;
  late List<Kurikulum> _kurikulumList;

  bool isLoading = true;
  String? errorMessage;

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
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final dosenAjar = await _service.fetchDosenAjar();
      final pegawai = await _service.fetchPegawai();
      final kelas = await _service.fetchKelas();
      final kurikulum = await _service.fetchKurikulum();

      setState(() {
        _dosenAjarList = dosenAjar;
        _pegawaiList = pegawai;
        _kelasList = kelas;
        _kurikulumList = kurikulum;
        isLoading = false;
      });
    } catch (e) {
      // Tangani jika error karena token tidak valid/expired
      if (e.toString().contains('401') && mounted) {
        handleUnauthorized(context);
      } else {
        setState(() {
          isLoading = false;
          errorMessage = e.toString();
        });
        if (mounted) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Terjadi Kesalahan',
            text: e.toString(),
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
  }

  List<DosenAjar> get filteredList {
    if (_searchController.text.isEmpty) return _dosenAjarList;
    final query = _searchController.text.toLowerCase();
    return _dosenAjarList.where((d) {
      return d.namaKelas.toLowerCase().contains(query) ||
          d.namaMk.toLowerCase().contains(query);
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
        child:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage != null
                ? Center(
                  child: Text(
                    errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                    ),
                  ),
                )
                : Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => const DashboardAdminProdi(),
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
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 12.0),
                          child: Text(
                            'Dosen Ajar',
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
                          'Daftar Dosen Ajar',
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
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                          hintText:
                              'Cari berdasarkan Kelas atau Mata Kuliah...',
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Image.asset(
                              'assets/icons/search.png',
                              width: 20,
                              height: 20,
                              color: Colors.grey,
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
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: _fetchAllData,
                        child: ListView.builder(
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            final item = filteredList[index];
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                  item.namaKelas,
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
                                                  'Mata Kuliah',
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
                                                  item.namaMk,
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
      floatingActionButton: (!isLoading && errorMessage == null)
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 35.0),
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
                    'Tambah Dosen Ajar',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 19,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF392A9F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _showAddDialog() {
    int? idKelas;
    int? idPegawai;
    int? idKurikulum;

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
                child: SingleChildScrollView(
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
                            'Tambah Dosen Ajar',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDropdown(
                              value: idKelas,
                              label: 'Nama Kelas*',
                              items:
                                  _kelasList
                                      .map(
                                        (kelas) => DropdownMenuItem<int>(
                                          value: kelas.idProdi,
                                          child: Text(kelas.namaProdi),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (value) => idKelas = value,
                            ),
                            const SizedBox(height: 16),
                            _buildDropdown(
                              value: idPegawai,
                              label: 'Dosen*',
                              items:
                                  _pegawaiList
                                      .map(
                                        (p) => DropdownMenuItem<int>(
                                          value: p.idPegawai,
                                          child: Text(p.nama),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (value) => idPegawai = value,
                            ),
                            const SizedBox(height: 16),
                            _buildDropdown(
                              value: idKurikulum,
                              label: 'Mata Kuliah*',
                              items:
                                  _kurikulumList
                                      .map(
                                        (k) => DropdownMenuItem<int>(
                                          value: k.idKurikulum,
                                          child: Text(
                                            '${k.namaMk} (${k.tahunAkademik})',
                                          ),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (value) => idKurikulum = value,
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
                                  if (idKelas == null ||
                                      idPegawai == null ||
                                      idKurikulum == null) {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      title: 'Gagal!',
                                      text:
                                          'Harap isi semua field dengan benar.',
                                      confirmBtnColor: Colors.red,
                                    );
                                    return;
                                  }

                                  try {
                                    await _service.tambahDosenAjar(
                                      idKelas: idKelas!,
                                      idPegawai: idPegawai!,
                                      idKurikulum: idKurikulum!,
                                    );
                                    await _fetchAllData();
                                    if (mounted) {
                                      Navigator.pop(context);
                                      QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.success,
                                        title: 'Berhasil!',
                                        text: 'Dosen ajar berhasil ditambahkan',
                                        confirmBtnColor: Colors.green,
                                      );
                                    }
                                  } catch (e) {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      title: 'Gagal!',
                                      text: 'Error: $e',
                                      confirmBtnColor: Colors.red,
                                    );
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
                                onPressed: Navigator.of(context).pop,
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
          ));
      },
    );
  }

  Widget _buildDropdown({
    required dynamic value,
    required String label,
    required List<DropdownMenuItem<dynamic>> items,
    required ValueChanged<dynamic> onChanged,
  }) {
    return DropdownButtonFormField<dynamic>(
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
}
