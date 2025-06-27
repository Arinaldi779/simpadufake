import 'package:flutter/material.dart';
import 'package:simpadu/models/daftar_kelas_model.dart';
import 'package:simpadu/services/daftar_kelas_service.dart';
import 'package:quickalert/quickalert.dart';

Future<void> showAddKelasDialog(BuildContext context) async {
  final service = KelasService();
  final namaKelasController = TextEditingController();
  final aliasController = TextEditingController();
  String? selectedProdiId;
  String? selectedTahunAkademikId;

  // Ambil data prodi & tahun akademik
  List<Prodi> prodiList = [];
  List<TahunAkademik> tahunAkademikList = [];

  try {
    final response = await service.fetchProdiDanTahunAkademik();
    prodiList = response['prodiList'] as List<Prodi>;
    tahunAkademikList = response['tahunAkademikList'] as List<TahunAkademik>;
  } catch (e) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Gagal',
      text: 'Gagal memuat data Prodi atau Tahun Akademik: $e',
    );
    return;
  }

  await showGeneralDialog(
    context: context,
    pageBuilder:
        (context, animation, secondaryAnimation) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header Dialog
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Color(0xFF392A9F), // Warna header biru tua
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Tambah Kelas',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Nama Kelas
                TextFormField(
                  controller: namaKelasController,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Color(0xFF656464),
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Nama Kelas *',
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
                      borderSide: BorderSide(
                        color: Color(0xFFEEEEEE),
                        width: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Alias
                TextFormField(
                  controller: aliasController,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Color(0xFF656464),
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Alias *',
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
                      borderSide: BorderSide(
                        color: Color(0xFFEEEEEE),
                        width: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Dropdown Program Studi
                _buildDropdown(
                  context,
                  label: 'Program Studi *',
                  value: selectedProdiId,
                  items:
                      prodiList.map((prodi) {
                        return DropdownMenuItem(
                          value: prodi.idProdi,
                          child: Text(prodi.namaProdi),
                        );
                      }).toList(),
                  onChanged: (value) => selectedProdiId = value,
                ),
                const SizedBox(height: 12),

                // Dropdown Tahun Akademik
                _buildDropdown(
                  context,
                  label: 'Tahun Akademik *',
                  value: selectedTahunAkademikId,
                  items:
                      tahunAkademikList.map((tahun) {
                        return DropdownMenuItem(
                          value: tahun.idThnAk,
                          child: Text(tahun.namaThnAk),
                        );
                      }).toList(),
                  onChanged: (value) => selectedTahunAkademikId = value,
                ),

                const SizedBox(height: 16),

                // Tombol Simpan & Batal
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          if (namaKelasController.text.isEmpty ||
                              aliasController.text.isEmpty ||
                              selectedProdiId == null ||
                              selectedTahunAkademikId == null) {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              title: 'Gagal!',
                              text: 'Harap isi semua field wajib!',
                              confirmBtnColor: Colors.red,
                            );
                            return;
                          }

                          final newKelas = Kelas(
                            namaKelas: namaKelasController.text,
                            alias: aliasController.text,
                            idProdi: selectedProdiId!,
                            idThnAk: selectedTahunAkademikId!,
                          );

                          try {
                            await service.tambahKelas(newKelas);
                            Navigator.pop(context);
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              title: 'Berhasil!',
                              text: 'Kelas berhasil ditambahkan.',
                              confirmBtnColor: Colors.green,
                            );
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
                        icon: const Icon(Icons.check, color: Colors.white),
                        label: Text(
                          'Simpan',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: Navigator.of(context).pop,
                        icon: const Icon(Icons.close, color: Colors.white),
                        label: Text(
                          'Batal',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
        child: FadeTransition(opacity: animation, child: child),
      );
    },
    transitionDuration: const Duration(milliseconds: 100),
  );
}

// Helper untuk Dropdown
Widget _buildDropdown(
  BuildContext context, {
  required String label,
  required String? value,
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
      filled: true,
      fillColor: const Color(0xFFEEEEEE),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1),
      ),
    ),
    items: items,
    onChanged: onChanged,
    isExpanded: true,
    itemHeight: 56,
    menuMaxHeight: 300,
    dropdownColor: Colors.white,
    style: const TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      color: Color(0xFF656464),
    ),
    icon: Image.asset(
      'assets/icons/down_arrow_icon.png', // Pastikan ikon tersedia
      width: 24,
      height: 24,
    ),
    borderRadius: BorderRadius.circular(8),
  );
}
