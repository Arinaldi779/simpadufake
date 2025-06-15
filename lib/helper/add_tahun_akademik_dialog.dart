import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simpadu/models/tahun_akademik_model.dart';
import 'package:simpadu/services/tahun_akademik_service.dart';
import 'package:quickalert/quickalert.dart';

Future<void> showAddTahunAkademikDialog(BuildContext context) async {
  final service = TahunAkademikService();
  final idController = TextEditingController();
  final tahunController = TextEditingController();
  String? selectedSemester = 'Ganjil';
  DateTime? startDate;
  DateTime? endDate;
  bool isAktif = false;

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
                      'Tambah Tahun Akademik',
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

                // Kode Tahun
                TextFormField(
                  controller: idController,
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
                      borderSide: BorderSide(
                        color: Color(0xFFEEEEEE),
                        width: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Tahun Ajaran
                TextFormField(
                  controller: tahunController,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Color(0xFF656464),
                  ),
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
                      borderSide: BorderSide(
                        color: Color(0xFFEEEEEE),
                        width: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Semester
                DropdownButtonFormField<String>(
                  value: selectedSemester,
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
                      borderSide: BorderSide(
                        color: Color(0xFFEEEEEE),
                        width: 1,
                      ),
                    ),
                  ),
                  items:
                      ['Ganjil', 'Genap'].map((s) {
                        return DropdownMenuItem<String>(
                          value: s,
                          child: Text(s),
                        );
                      }).toList(),
                  onChanged: (value) => selectedSemester = value ?? 'Ganjil',
                ),
                const SizedBox(height: 16),

                // Tanggal Mulai & Selesai
                Row(
                  children: [
                    Expanded(
                      child: _buildDatePicker(
                        context,
                        'Start Date',
                        startDate,
                        () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: startDate ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            startDate = picked;
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildDatePicker(
                        context,
                        'End Date',
                        endDate,
                        () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: endDate ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            endDate = picked;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Status Aktif
                DropdownButtonFormField<String>(
                  value: isAktif ? 'Aktif' : 'Tidak Aktif',
                  decoration: InputDecoration(
                    filled: true,
                    fillColor:
                        isAktif ? const Color(0xFFDFF5E1) : Colors.grey[200],
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: isAktif ? Colors.green : Colors.grey!,
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
                  onChanged: (value) => isAktif = value == 'Aktif',
                ),

                const SizedBox(height: 16),

                // Tombol Simpan & Batal
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          if (idController.text.isEmpty ||
                              tahunController.text.isEmpty ||
                              selectedSemester == null) {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              title: 'Gagal!',
                              text: 'Harap isi semua field wajib!',
                              confirmBtnColor: Colors.red,
                            );
                            return;
                          }

                          try {
                            await service.addTahunAkademik(
                              TahunAkademik(
                                idThnAk: idController.text,
                                tahun: tahunController.text,
                                semester: selectedSemester!,
                                startDate: startDate,
                                endDate: endDate,
                                isAktif: isAktif,
                              ),
                            );
                            Navigator.pop(context);
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              title: 'Berhasil!',
                              text: 'Tahun akademik berhasil ditambahkan.',
                              confirmBtnColor: Colors.green,
                            );
                          } catch (e) {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              title: 'Gagal!',
                              text: 'Gagal menambahkan data: $e',
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
    transitionDuration: const Duration(milliseconds: 300),
  );
}

// Helper: DatePicker dengan Ikon Asset
Widget _buildDatePicker(
  BuildContext context,
  String label,
  DateTime? date,
  Function() onPick, {
  bool enabled = true,
}) {
  return InkWell(
    onTap: enabled ? onPick : null,
    child: InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/icons/calendar2.png', // Pastikan file ini tersedia
            width: 18,
            height: 18,
          ),
          const SizedBox(width: 8),
          Text(
            date != null
                ? DateFormat('dd/MM/yyyy').format(date)
                : 'Pilih Tanggal',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: enabled ? const Color(0xFF656464) : Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}
