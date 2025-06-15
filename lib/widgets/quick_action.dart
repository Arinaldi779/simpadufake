import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helper/add_tahun_akademik_dialog.dart';
import '../helper/add_kelas_dialog.dart';
import '../helper/add_mahasiswa_dialog.dart';
// Service API
// import '../services/auth_helper.dart'; // Fungsi handle unauthorized

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                QuickActionCard(
                  iconPath: 'assets/icons/aksiKelas.png',
                  label: 'Buat Daftar Kelas',
                  backgroundColor: Color(0xFFBA7CFF),
                  onTap: () => showAddKelasDialog(context),
                ),
                QuickActionCard(
                  iconPath: 'assets/icons/buatAksi.png',
                  label: 'Buat Tahun Akademik',
                  backgroundColor: Color(0xFF7FAAFF),
                  iconColor: Colors.white,
                  onTap: () => showAddTahunAkademikDialog(context),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Center(
            child: Wrap(
              spacing: 30.w,
              runSpacing: 13.h,
              crossAxisAlignment: WrapCrossAlignment.center,
              children:  [
                SizedBox(
                  child: QuickActionCard(
                    iconPath: 'assets/icons/tambahAksi.png',
                    label: 'Tambah Mahasiswa',
                    backgroundColor: Color(0xFFF8A7E5),
                    iconColor: Colors.white,
                    onTap: () => showAddMahasiswaDialog(context),
                    isSpecial: true,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          const Divider(
            height: 7,
            thickness: 10,
            color: Color.fromARGB(255, 240, 241, 241),
          ),
        ],
      ),
    );
  }
}

class QuickActionCard extends StatelessWidget {
  final String iconPath;
  final String label;
  final Color backgroundColor;
  final Color? iconColor;
  final bool isSpecial;
  final VoidCallback? onTap;

  const QuickActionCard({
    super.key,
    required this.iconPath,
    required this.label,
    required this.backgroundColor,
    this.iconColor,
    this.isSpecial = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: SizedBox(
        width: isSpecial ? 170.14.w : 170.14.w,
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
              const SizedBox(width: 7),
              Expanded(
                child: Center(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 7.7.sp,
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
