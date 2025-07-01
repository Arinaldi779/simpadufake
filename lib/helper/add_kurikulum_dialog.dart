import 'package:flutter/material.dart';
import 'package:simpadu/services/kurikulum_service.dart';
import 'package:simpadu/models/kurikulum_model.dart';
import 'package:quickalert/quickalert.dart';

Future<void> showAddKurikulumDialog(BuildContext context) async {
  final KurikulumService _kurikulumService = KurikulumService();

  int? idMk;
  String? idThnAk;
  int? idProdi;
  final ketController = TextEditingController();

  DropdownData? dropdownData;

  try {
    dropdownData = await _kurikulumService.fetchDropdownData();
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
                        // Header Dialog
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
                              'Tambah Kurikulum',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        // Form Input
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 18,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Dropdown Mata Kuliah
                              _buildDropdownInt(
                                context: context,
                                value: idMk,
                                label: 'Mata Kuliah*',
                                items:
                                    dropdownData!.matakuliahList.map((mk) {
                                      return DropdownMenuItem<int>(
                                        value: mk.idMk,
                                        child: Text(
                                          '${mk.namaMk} (${mk.kodeMk})',
                                        ),
                                      );
                                    }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    idMk = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 16),

                              // Dropdown Tahun Akademik
                              _buildDropdownString(
                                context: context,
                                value: idThnAk,
                                label: 'Tahun Akademik*',
                                items:
                                    dropdownData.tahunAkademikList.map((ta) {
                                      return DropdownMenuItem<String>(
                                        value: ta.idThnAk,
                                        child: Text(ta.namaThnAk),
                                      );
                                    }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    idThnAk = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 16),

                              // Dropdown Program Studi
                              _buildDropdownInt(
                                context: context,
                                value: idProdi,
                                label: 'Program Studi*',
                                items:
                                    dropdownData.prodiList.map((prodi) {
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

                              // Field Keterangan
                              TextFormField(
                                controller: ketController,
                                maxLines: 3,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Keterangan',
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
                              ),
                            ],
                          ),
                        ),

                        // Tombol Simpan & Batal
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (idMk == null ||
                                        idThnAk == null ||
                                        idProdi == null) {
                                      QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.error,
                                        title: 'Gagal!',
                                        text: 'Harap pilih semua field wajib!',
                                        confirmBtnColor: Colors.red,
                                      );
                                      return;
                                    }

                                    try {
                                      await _kurikulumService.tambahKurikulum(
                                        idMk: idMk!,
                                        idThnAk: int.parse(idThnAk!),
                                        idProdi: idProdi!,
                                        ket: ketController.text,
                                      );

                                      if (context.mounted) {
                                        Navigator.pop(context);
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.success,
                                          title: 'Berhasil!',
                                          text:
                                              'Kurikulum berhasil ditambahkan',
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

// Fungsi reusable untuk dropdown dengan tipe int
Widget _buildDropdownInt({
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

// Fungsi reusable untuk dropdown dengan tipe String
Widget _buildDropdownString({
  required BuildContext context,
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
