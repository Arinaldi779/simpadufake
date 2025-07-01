import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simpadu/services/matakuliah_service.dart';
import 'package:simpadu/models/matakuliah_model.dart';
import 'package:quickalert/quickalert.dart';

Future<void> showAddMatakuliahDialog(BuildContext context) async {
  final MataKuliahService _mataKuliahService = MataKuliahService();

  String? kodeMk;
  String namaMk = '';
  int? idProdi;
  int sks = 0;
  int jam = 0;

  final kodeController = TextEditingController();
  final namaController = TextEditingController();
  final sksController = TextEditingController(text: '0');
  final jamController = TextEditingController(text: '0');

  DropdownDataMk? dropdownData;

  try {
    dropdownData = await _mataKuliahService.fetchDropdownData();
  } catch (e) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Gagal',
      text: 'Gagal memuat data dropdown: $e',
      confirmBtnColor: Colors.red,
    );
    return;
  }

  await showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return StatefulBuilder(
        builder: (context, setState) {
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
                        // Header
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
                              'Tambah Mata Kuliah',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        // Form
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 18,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Kode MK
                              TextFormField(
                                controller: kodeController,
                                decoration: InputDecoration(
                                  labelText: 'Kode Mata Kuliah*',
                                  labelStyle: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: Color(0xFF656464),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFFEEEEEE),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                ),
                                onChanged: (value) {
                                  kodeMk = value;
                                },
                              ),
                              const SizedBox(height: 16),

                              // Nama MK
                              TextFormField(
                                controller: namaController,
                                decoration: InputDecoration(
                                  labelText: 'Nama Mata Kuliah*',
                                  labelStyle: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: Color(0xFF656464),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFFEEEEEE),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                ),
                                onChanged: (value) {
                                  namaMk = value;
                                },
                              ),
                              const SizedBox(height: 16),

                              // Program Studi
                              _buildDropdownProdi(
                                context: context,
                                value: idProdi,
                                label: 'Program Studi*',
                                items:
                                    dropdownData!.prodiList.map((prodi) {
                                      return DropdownMenuItem<int>(
                                        value: prodi.idProdi,
                                        child: Text(prodi.namaProdi),
                                      );
                                    }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    idProdi = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 16),

                              // SKS
                              TextFormField(
                                controller: sksController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'SKS*',
                                  labelStyle: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: Color(0xFF656464),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFFEEEEEE),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                ),
                                onChanged: (value) {
                                  sks = int.tryParse(value) ?? 0;
                                },
                              ),
                              const SizedBox(height: 16),

                              // Jam
                              TextFormField(
                                controller: jamController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Jam*',
                                  labelStyle: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: Color(0xFF656464),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFFEEEEEE),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                ),
                                onChanged: (value) {
                                  jam = int.tryParse(value) ?? 0;
                                },
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
                                  onPressed: () async {
                                    if (kodeMk == null ||
                                        namaMk.isEmpty ||
                                        idProdi == null ||
                                        sks <= 0 ||
                                        jam <= 0) {
                                      QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.error,
                                        title: 'Gagal!',
                                        text:
                                            'Harap isi semua field dengan benar!',
                                        confirmBtnColor: Colors.red,
                                      );
                                      return;
                                    }

                                    try {
                                      await _mataKuliahService.tambahMataKuliah(
                                        kodeMk: kodeMk!,
                                        namaMk: namaMk,
                                        idProdi: idProdi!,
                                        sks: sks,
                                        jam: jam,
                                      );

                                      if (context.mounted) {
                                        Navigator.pop(context);
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.success,
                                          title: 'Berhasil!',
                                          text:
                                              'Mata kuliah berhasil ditambahkan',
                                          confirmBtnColor: Colors.green,
                                        );
                                      }
                                    } catch (e) {
                                      if (context.mounted) {
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
            ),
          );
        },
      );
    },
  );
}

// Fungsi reusable untuk dropdown prodi
Widget _buildDropdownProdi({
  required BuildContext context,
  required int? value,
  required String label,
  required List<DropdownMenuItem<int>> items,
  required ValueChanged<int?> onChanged,
}) {
  return DropdownButtonFormField<int>(
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
