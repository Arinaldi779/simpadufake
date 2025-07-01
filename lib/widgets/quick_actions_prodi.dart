// quick_actions_prodi.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helper/add_kurikulum_dialog.dart';
import '../helper/add_matakuliah_dialog.dart';

class QuickActionsProdi extends StatelessWidget {
  const QuickActionsProdi({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Text(
                  'Aksi Cepat',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Center(
                child: Wrap(
                  spacing: 30.w,
                  runSpacing: 13.h,
                  children: [
                    QuickActionProdiCard(
                      iconPath: 'assets/icons/aksiKelas.png',
                      label: 'Tambah Kurikulum',
                      backgroundColor: const Color(0xFFBA7CFF),
                      onTap: () {
                        showAddKurikulumDialog(context);
                      },
                    ),
                    QuickActionProdiCard(
                      iconPath: 'assets/icons/tambahDosen.png',
                      label: 'Tambah MataKuliah',
                      backgroundColor: const Color(0xFF7BCA5F),
                      onTap: () {
                        showAddMatakuliahDialog(context);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              Center(
                child: Wrap(
                  spacing: 30.w,
                  runSpacing: 13.h,
                  children: const [
                    QuickActionProdiCard(
                      iconPath: 'assets/icons/aksiKelas.png',
                      label: 'Tambah Kurikulum',
                      backgroundColor: Color(0xFFBA7CFF),
                    ),
                    QuickActionProdiCard(
                      iconPath: 'assets/icons/buatAksi.png',
                      label: 'Input Presensi',
                      backgroundColor: Color(0xFF7FAAFF),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
        const Divider(
          height: 7,
          thickness: 10,
          color: Color.fromARGB(255, 240, 241, 241),
          indent: 0,
          endIndent: 0,
        ),
      ],
    );
  }
}

class QuickActionProdiCard extends StatelessWidget {
  final String iconPath;
  final String label;
  final Color backgroundColor;
  final Color? iconColor; // ✅ Diperbaiki dari bool? ke Color?
  final bool isSpecial;
  final VoidCallback? onTap;

  const QuickActionProdiCard({
    super.key,
    required this.iconPath,
    this.iconColor,
    required this.label,
    required this.backgroundColor,
    this.isSpecial = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: SizedBox(
        width: isSpecial ? 168.14.w : 168.14.w,
        height: isSpecial ? 39.17.h : 39.17.h,
        child: ElevatedButton(
          onPressed: onTap ?? () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
            elevation: 6,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                iconPath,
                width: 22.w,
                height: 22.h,
                color: iconColor,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
