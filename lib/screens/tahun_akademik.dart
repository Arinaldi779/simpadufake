import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal
import 'package:simpadu/screens/dashboard_admin_akademik.dart';
import 'package:simpadu/services/auth_middleware.dart'; // Cek token validitas
import '../models/tahun_akademik_model.dart'; // Model data Tahun Akademik
import '../services/tahun_akademik_service.dart'; // Service API CRUD
import 'package:quickalert/quickalert.dart'; // Alert dialog
import '../services/auth_helper.dart'; // Fungsi logout & alert unauthorized

// Halaman utama daftar tahun akademik
class TahunAkademikPage extends StatefulWidget {
  const TahunAkademikPage({super.key});

  @override
  State<TahunAkademikPage> createState() => _TahunAkademikPageState();
}

class _TahunAkademikPageState extends State<TahunAkademikPage> {
  final TahunAkademikService _service = TahunAkademikService();
  final TextEditingController _searchController = TextEditingController();
  List<TahunAkademik> _tahunAkademikList = [];
  bool _isLoading = true;

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
    await _loadTahunAkademik();
  }

  // Memuat data dari API
  Future<void> _loadTahunAkademik() async {
    try {
      final data = await _service.fetchTahunAkademik();
      setState(() {
        _tahunAkademikList = data;
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
      setState(() => _isLoading = false);
      if ((status == '401' || message.contains('401')) && mounted) {
        handleUnauthorized(context);
      } else {
        _showError(message);
      }
    }
  }

  // Menampilkan alert error
  void _showError(String message) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Gagal!',
      text: message,
      confirmBtnColor: Colors.red,
    );
  }

  // Menampilkan alert sukses
  void _showSuccess(String message) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Berhasil!',
      text: message,
      confirmBtnColor: Colors.green,
    );
  }

  // Handle sesi berakhir / token tidak valid
  void _handleUnauthorized(BuildContext context) {
    if (!mounted || ModalRoute.of(context)?.isCurrent == false) return;
    QuickAlert.show(
      context: context,
      type: QuickAlertType.warning,
      title: 'Sesi Berakhir',
      text: 'Silakan login kembali.',
      confirmBtnText: 'Login Ulang',
      onConfirmBtnTap: () {
        logoutAndRedirect(context); // Dari auth_helper.dart
      },
    );
  }

  // UI Build
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildAddButton(), // Tombol tambah data
    );
  }

  // AppBar custom
  AppBar _buildAppBar() {
    return AppBar(
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
    );
  }

  // Body halaman utama
  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBreadcrumb(),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              'Tahun Akademik',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          const SizedBox(height: 15),
          _buildSearchField(),
          const SizedBox(height: 20),
          _buildTahunAkademikList(),
        ],
      ),
    );
  }

  // Breadcrumb navigasi
  Widget _buildBreadcrumb() {
    return Row(
      children: [
        GestureDetector(
          onTap:
              () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DashboardAdmin()),
              ),
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
            'Tahun Akademik',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF333333),
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    );
  }

  // Input pencarian
  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: TextField(
        controller: _searchController,
        onChanged: (value) => setState(() {}),
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: ' Cari Tahun...',
          hintStyle: const TextStyle(color: Color(0xFF999999)),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: Image.asset(
              'assets/icons/search.png',
              width: 23,
              height: 23,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: const Color(0xFF999999), width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: const Color(0xFF0B0B0B), width: 1.0),
          ),
        ),
      ),
    );
  }

  // Daftar data tahun akademik
  Widget _buildTahunAkademikList() {
    final filteredList =
        _searchController.text.isEmpty
            ? _tahunAkademikList
            : _tahunAkademikList
                .where(
                  (tahun) => tahun.tahun.toLowerCase().contains(
                    _searchController.text.toLowerCase(),
                  ),
                )
                .toList();
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (filteredList.isEmpty) return _buildEmptyState();
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: filteredList.length,
        itemBuilder:
            (context, index) =>
                _buildTahunAkademikCard(filteredList[index], filteredList),
      ),
    );
  }

  // Tampilan ketika tidak ada data
  Widget _buildEmptyState() {
    return const Padding(
      padding: EdgeInsets.only(top: 50.0),
      child: Center(
        child: Text(
          'Tidak ada data tahun akademik',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }

  // Kartu satu item data tahun akademik
  Widget _buildTahunAkademikCard(
    TahunAkademik tahunAkademik,
    List<TahunAkademik> currentList,
  ) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final startDate =
        tahunAkademik.startDate != null
            ? dateFormat.format(tahunAkademik.startDate!)
            : '-';
    final endDate =
        tahunAkademik.endDate != null
            ? dateFormat.format(tahunAkademik.endDate!)
            : '-';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFF171717), width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // <-- Tambahkan ini
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color:
                        tahunAkademik.isAktif
                            ? const Color(0xFFB2FFB7)
                            : const Color(0xFFD3D3D3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    tahunAkademik.isAktif ? 'Aktif' : 'Tidak Aktif',
                    style: TextStyle(
                      color:
                          tahunAkademik.isAktif
                              ? const Color(0xFF31B14E)
                              : const Color(0xFF171717),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildInfoRow('TAHUN AKADEMIK', tahunAkademik.tahun),
              _buildInfoRow('SEMESTER', tahunAkademik.semester),
              _buildInfoRow('TANGGAL MULAI - SELESAI', '$startDate\n$endDate'),
              Align(
                alignment: Alignment.center,
                child: IconButton(
                  icon: Image.asset(
                    'assets/icons/edit.png',
                    width: 41,
                    height: 33,
                  ),
                  onPressed:
                      () => _showAddEditDialog(tahunAkademik: tahunAkademik),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Baris informasi dalam kartu
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF505050),
                fontSize: 13,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF171717),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Tombol "Tambah Tahun Akademik"
  Widget _buildAddButton() {
    return Padding(
      padding: const EdgeInsets.all(35.0),
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
            'Tambah Tahun Akademik',
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
    );
  }

  // Dialog tambah/edit data
  void _showAddEditDialog({TahunAkademik? tahunAkademik}) {
    final isEditing = tahunAkademik != null;
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return AddEditTahunAkademikDialog(
          isEditing: isEditing,
          tahunAkademik: tahunAkademik,
          onSave: (tahunAkademik) async {
            try {
              if (isEditing) {
                await _service.updateTahunAkademik(
                  tahunAkademik.idThnAk,
                  tahunAkademik.isAktif,
                );
                _showSuccess('Tahun Akademik berhasil diubah!');
              } else {
                await _service.addTahunAkademik(tahunAkademik);
                _showSuccess('Tahun Akademik berhasil ditambahkan!');
              }
              _loadTahunAkademik();
            } catch (e) {
              _showError('Gagal menyimpan data: $e');
            }
          },
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}

// Dialog form tambah/edit
class AddEditTahunAkademikDialog extends StatefulWidget {
  final bool isEditing;
  final TahunAkademik? tahunAkademik;
  final Function(TahunAkademik) onSave;

  const AddEditTahunAkademikDialog({
    required this.isEditing,
    this.tahunAkademik,
    required this.onSave,
  });

  @override
  State<AddEditTahunAkademikDialog> createState() =>
      _AddEditTahunAkademikDialogState();
}

class _AddEditTahunAkademikDialogState
    extends State<AddEditTahunAkademikDialog> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _tahunController = TextEditingController();
  String? _selectedSemester;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isAktif = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.tahunAkademik != null) {
      _idController.text = widget.tahunAkademik!.idThnAk;
      _tahunController.text = widget.tahunAkademik!.tahun;
      _selectedSemester = widget.tahunAkademik!.semester;
      _startDate = widget.tahunAkademik!.startDate;
      _endDate = widget.tahunAkademik!.endDate;
      _isAktif = widget.tahunAkademik!.isAktif;
    }
    if (_selectedSemester == null ||
        (_selectedSemester != 'Ganjil' && _selectedSemester != 'Genap')) {
      _selectedSemester = 'Ganjil';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFF392A9F),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Center(
                child: Text(
                  widget.isEditing
                      ? 'Edit Tahun Akademik'
                      : 'Tambah Tahun Akademik',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _idController,
              enabled: !widget.isEditing,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Color(0xFF656464),
              ),
              decoration: const InputDecoration(
                labelText: 'Kode Tahun Akademik *',
                labelStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Color(0xFF656464),
                  fontWeight: FontWeight.w700,
                ),
                filled: true,
                fillColor: Color(0xFFEEEEEE),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _tahunController,
              enabled: !widget.isEditing,
              decoration: const InputDecoration(
                labelText: 'Tahun Ajaran *',
                labelStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Color(0xFF656464),
                  fontWeight: FontWeight.w700,
                ),
                filled: true,
                fillColor: Color(0xFFEEEEEE),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                ),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedSemester,
              decoration: const InputDecoration(
                labelText: 'Semester *',
                labelStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Color(0xFF656464),
                  fontWeight: FontWeight.w700,
                ),
                filled: true,
                fillColor: Color(0xFFEEEEEE),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                ),
              ),
              items:
                  ['Ganjil', 'Genap'].map((semester) {
                    return DropdownMenuItem<String>(
                      value: semester,
                      child: Text(semester),
                    );
                  }).toList(),
              onChanged:
                  !widget.isEditing
                      ? (value) => setState(() => _selectedSemester = value)
                      : null,
            ),
            const Divider(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildDatePicker(
                    'Start Date',
                    _startDate,
                    (date) => _startDate = date,
                    enabled: !widget.isEditing,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildDatePicker(
                    'End Date',
                    _endDate,
                    (date) => _endDate = date,
                    enabled: !widget.isEditing,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _isAktif ? 'Aktif' : 'Tidak Aktif',
              decoration: InputDecoration(
                filled: true,
                fillColor:
                    _isAktif ? const Color(0xFFDFF5E1) : Colors.grey[200],
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: _isAktif ? Colors.green : Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              items:
                  ['Aktif', 'Tidak Aktif'].map((status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(status + '*')],
                      ),
                    );
                  }).toList(),
              onChanged: (value) => setState(() => _isAktif = value == 'Aktif'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveTahunAkademik,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.check, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Simpan',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
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
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.close, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Batal',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Custom picker tanggal
  Widget _buildDatePicker(
    String label,
    DateTime? date,
    Function(DateTime) onDateSelected, {
    bool enabled = true,
  }) {
    return InkWell(
      onTap:
          enabled
              ? () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: date ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  setState(() => onDateSelected(picked));
                }
              }
              : null,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        child: Row(
          children: [
            Image.asset('assets/icons/calendar2.png', width: 18, height: 18),
            const SizedBox(width: 8),
            Text(
              date != null
                  ? DateFormat('dd/MM/yyyy').format(date)
                  : 'Pilih Tanggal',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  // Simpan data
  void _saveTahunAkademik() {
    if (_idController.text.isEmpty ||
        _tahunController.text.isEmpty ||
        _selectedSemester == null) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Gagal!',
        text: 'Harap isi semua field wajib!',
        confirmBtnColor: Colors.red,
      );
      return;
    }
    final tahunAkademik = TahunAkademik(
      idThnAk: _idController.text,
      tahun: _tahunController.text,
      semester: _selectedSemester!,
      startDate: _startDate,
      endDate: _endDate,
      isAktif: _isAktif,
    );
    widget.onSave(tahunAkademik);
    Navigator.pop(context);
  }
}
