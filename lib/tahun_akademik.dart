import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simpadu/dashboard_admin_akademik.dart';
import 'models/tahun_akademik_model.dart';
import 'services/tahun_akademik_service.dart';
import 'services/auth_helper.dart'; // ← import helper

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
    _checkTokenAndFetchData(); // Cek token & muat data
  }

  Future<void> _checkTokenAndFetchData() async {
    final isValid = await isTokenValid(); // Dari auth_helper.dart
    if (!isValid) {
      logoutAndRedirect(context); // Arahkan ke login jika token tidak valid
      return;
    }

    await _loadTahunAkademik();
  }

  Future<void> _loadTahunAkademik() async {
    try {
      final data = await _service.fetchTahunAkademik();
      setState(() {
        _tahunAkademikList = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showErrorSnackbar('Error: $e');
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildAddButton(),
    );
  }

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

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBreadcrumb(),
          const SizedBox(height: 20),
          const Text(
            'Tahun Akademik',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
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

  Widget _buildBreadcrumb() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pushReplacement(
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
        const Text(' > ', style: TextStyle(fontSize: 15, color: Color(0xFF686868))),
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

  Widget _buildSearchField() {
    return TextField(
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
          child: Image.asset('assets/icons/search.png', width: 23, height: 23),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF999999), width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF0B0B0B), width: 1.0),
        ),
      ),
    );
  }

  Widget _buildTahunAkademikList() {
    final filteredList = _searchController.text.isEmpty
        ? _tahunAkademikList
        : _tahunAkademikList.where((tahun) =>
            tahun.tahun.toLowerCase().contains(_searchController.text.toLowerCase()))
        .toList();

    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (filteredList.isEmpty) return _buildEmptyState();

    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: filteredList.length,
        itemBuilder: (context, index) => _buildTahunAkademikCard(filteredList[index], filteredList),
      ),
    );
  }

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

  Widget _buildTahunAkademikCard(TahunAkademik tahunAkademik, List<TahunAkademik> currentList) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final startDate = tahunAkademik.startDate != null
        ? dateFormat.format(tahunAkademik.startDate!)
        : '-';
    final endDate = tahunAkademik.endDate != null
        ? dateFormat.format(tahunAkademik.endDate!)
        : '-';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFF171717), width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: tahunAkademik.isAktif ? const Color(0xFFB2FFB7) : Color(0xFFD3D3D3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  tahunAkademik.isAktif ? 'Aktif' : 'Tidak Aktif',
                  style: TextStyle(
                    color: tahunAkademik.isAktif ? Color(0xFF31B14E) : Color(0xFF171717),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildInfoRow('TAHUN AKADEMIK', tahunAkademik.tahun),
              _buildInfoRow('SEMESTER', tahunAkademik.semester),
              _buildInfoRow('TANGGAL MULAI - SELESAI', '$startDate\n$endDate'),
              IconButton(
                icon: Image.asset('assets/icons/edit.png', width: 41, height: 33),
                onPressed: () => _showAddEditDialog(tahunAkademik: tahunAkademik),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF505050), fontSize: 13)),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontSize: 15, color: Color(0xFF171717)),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return Padding(
      padding: const EdgeInsets.all(35.0),
      child: SizedBox(
        width: 335,
        height: 60,
        child: ElevatedButton.icon(
          onPressed: _showAddEditDialog,
          icon: Image.asset('assets/icons/plus_icon.png', width: 20, height: 20),
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ),
    );
  }

  void _showAddEditDialog({TahunAkademik? tahunAkademik}) {
    final isEditing = tahunAkademik != null;
    showDialog(
      context: context,
      builder: (context) => AddEditTahunAkademikDialog(
        isEditing: isEditing,
        tahunAkademik: tahunAkademik,
        onSave: (tahunAkademik) async {
          try {
            if (isEditing) {
              await _service.updateTahunAkademik(tahunAkademik.idThnAk, tahunAkademik.isAktif);
              _showSuccessSnackbar('Tahun Akademik berhasil diubah!');
            } else {
              await _service.addTahunAkademik(tahunAkademik);
              _showSuccessSnackbar('Tahun Akademik berhasil ditambahkan!');
            }
            _loadTahunAkademik();
          } catch (e) {
            _showErrorSnackbar('Error: $e');
          }
        },
      ),
    );
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }
}

// Dialog untuk menambah/mengedit tahun akademik
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
  State<AddEditTahunAkademikDialog> createState() => _AddEditTahunAkademikDialogState();
}

class _AddEditTahunAkademikDialogState extends State<AddEditTahunAkademikDialog> {
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
    // Pastikan _selectedSemester tidak null dan valid
    if (_selectedSemester == null || (_selectedSemester != 'Ganjil' && _selectedSemester != 'Genap')) {
      _selectedSemester = 'Ganjil';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titlePadding: EdgeInsets.zero,
      title: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Color(0xFF392A9F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Center(
          child: Text(
            widget.isEditing ? 'Edit Tahun Akademik' : 'Tambah Tahun Akademik',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _idController,
              enabled: !widget.isEditing, // terkunci saat edit
              decoration: const InputDecoration(
                labelText: 'Kode Tahun Akademik *',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _tahunController,
              enabled: !widget.isEditing, // terkunci saat edit
              decoration: const InputDecoration(
                labelText: 'Tahun Ajaran *',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedSemester,
              decoration: const InputDecoration(
                labelText: 'Semester *',
                border: OutlineInputBorder(),
              ),
              items: ['Ganjil', 'Genap'].map((semester) {
                return DropdownMenuItem<String>(
                  value: semester,
                  child: Text(semester),
                );
              }).toList(),
              onChanged: !widget.isEditing ? (value) => setState(() => _selectedSemester = value) : null, // terkunci saat edit
            ),
            const Divider(height: 20),
            Row(
              children: [
                Expanded(child: _buildDatePicker('Start Date', _startDate, (date) => _startDate = date, enabled: !widget.isEditing)),
                const SizedBox(width: 8),
                Expanded(child: _buildDatePicker('End Date', _endDate, (date) => _endDate = date, enabled: !widget.isEditing)),
              ],
            ),
          
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _isAktif ? 'Aktif' : 'Tidak Aktif',
              decoration: InputDecoration(
                filled: true,
                fillColor: _isAktif ? const Color(0xFFDFF5E1) : Colors.grey[200],
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: _isAktif ? Colors.green : Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              items: ['Aktif', 'Tidak Aktif'].map((status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status + '*'),
                );
              }).toList(),
              onChanged: (value) => setState(() => _isAktif = value == 'Aktif'),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _saveTahunAkademik,
                icon: const Icon(Icons.check, color: Colors.white),
                label: const Text('Simpan'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green[400]),
              ),
            ),
            const SizedBox(width: 2),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.white),
                label: const Text('Batalkan'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red[400]),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Membangun date picker
  Widget _buildDatePicker(String label, DateTime? date, Function(DateTime) onDateSelected, {bool enabled = true}) {
    return InkWell(
      onTap: enabled
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
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        child: Row(
          children: [
            Image.asset('assets/icons/calendar2.png', width: 18, height: 18),
            const SizedBox(width: 8),
            Text(
              date != null ? formatDate(date) : 'Pilih Tanggal',
              style: const TextStyle(fontSize: 8),
            ),
          ],
        ),
      ),
    );
  }

  // Menyimpan data tahun akademik
  void _saveTahunAkademik() {
    if (_idController.text.isEmpty || 
        _tahunController.text.isEmpty || 
        _selectedSemester == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap isi semua field yang wajib!')),
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