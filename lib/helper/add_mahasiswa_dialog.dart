import 'package:flutter/material.dart';
import 'package:simpadu/models/mahasiswa_model.dart';
import 'package:simpadu/services/mahasiswa_service.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> showAddMahasiswaDialog(BuildContext context) async {
  final TextEditingController nimController = TextEditingController();
  final TextEditingController noAbsenController = TextEditingController();
  int? selectedKelasId;
  final MahasiswaService _mahasiswaService = MahasiswaService();
  List<Kelas> kelasList = [];

  try {
    kelasList = await _mahasiswaService.fetchKelas();
  } catch (e) {
    if (context.mounted) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Gagal',
        text: 'Gagal memuat data kelas: $e',
      );
    }
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
                child: FadeTransition(
                  opacity: animation,
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r)),
                    contentPadding: EdgeInsets.zero,
                    content: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.all(16.sp),
                            decoration: const BoxDecoration(
                              color: Color(0xFF392A9F),
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16)),
                            ),
                            child: Center(
                              child: Text(
                                'Tambah Mahasiswa',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: nimController,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 14.sp),
                                    decoration: InputDecoration(
                                      labelText: 'NIM*',
                                      labelStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14.sp,
                                        color: const Color(0xFF656464),
                                        fontWeight: FontWeight.w700,
                                      ),
                                      filled: true,
                                      fillColor:
                                          const Color(0xFFEEEEEE),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: const BorderSide(
                                            color: Color(0xFFEEEEEE)),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12.w, vertical: 10.h),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  _buildDropdown(
                                    value: selectedKelasId?.toString(),
                                    label: 'Kelas*',
                                    items: kelasList.map((kelas) {
                                      return DropdownMenuItem(
                                        value: kelas.idKelas.toString(),
                                        child: Text(kelas.namaKelas),
                                      );
                                    }).toList(),
                                    onChanged: (value) => setState(
                                        () => selectedKelasId =
                                            int.parse(value!)),
                                  ),
                                  SizedBox(height: 10.h),
                                  TextFormField(
                                    controller: noAbsenController,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 14.sp),
                                    decoration: InputDecoration(
                                      labelText: 'No Absen*',
                                      labelStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14.sp,
                                        color: const Color(0xFF656464),
                                        fontWeight: FontWeight.w700,
                                      ),
                                      filled: true,
                                      fillColor:
                                          const Color(0xFFEEEEEE),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF9A9393)),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12.w, vertical: 10.h),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.sp),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () async {
                                      if (nimController.text.isEmpty ||
                                          noAbsenController.text.isEmpty ||
                                          selectedKelasId == null) {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.error,
                                          title: 'Gagal!',
                                          text:
                                              'Harap isi semua field wajib!',
                                          confirmBtnColor: Colors.red,
                                        );
                                        return;
                                      }
                                      final newMahasiswa = Mahasiswa(
                                        nim: nimController.text,
                                        idKelas: selectedKelasId!,
                                        noAbsen: int.parse(
                                            noAbsenController.text),
                                      );
                                      try {
                                        await _mahasiswaService
                                            .tambahMahasiswa(newMahasiswa);
                                        if (context.mounted) {
                                          Navigator.pop(context);
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.success,
                                            title: 'Berhasil!',
                                            text:
                                                'Mahasiswa berhasil ditambahkan.',
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
                                    icon: const Icon(Icons.check,
                                        color: Colors.white),
                                    label: Text(
                                      'Simpan',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 14.h),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () =>
                                        Navigator.pop(context),
                                    icon: const Icon(Icons.close,
                                        color: Colors.white),
                                    label: Text(
                                      'Batal',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 14.h),
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
            ),
          );
        },
      );
    },
  );
}
// Helper Widget untuk dropdown
Widget _buildDropdown({
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
      filled: true,
      fillColor: const Color(0xFFEEEEEE),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: Color(0xFF9A9393)),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
    icon: Image.asset('assets/icons/down_arrow_icon.png', width: 24, height: 24),
    borderRadius: BorderRadius.circular(8.r),
  );
}
