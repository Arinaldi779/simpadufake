import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../tahun_akademik.dart'; // Model Tahun Akademik
import '../services/tahun_akademik_service.dart'; // Service API
import '../services/auth_helper.dart'; // Service API
import '../helper/add_tahun_akademik_dialog.dart'; // Service API
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quickalert/quickalert.dart';
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
                const QuickActionCard(
                  iconPath: 'assets/icons/aksiKelas.png',
                  label: 'Buat Daftar Kelas',
                  backgroundColor: Color(0xFFBA7CFF),
                ),
                QuickActionCard(
                  iconPath: 'assets/icons/buatAksi.png',
                  label: 'Buat Tahun Akademik',
                  backgroundColor: Color(0xFF7FAAFF),
                  iconColor: Colors.white,
                  // onTap: () => _showAddTahunAkademikDialog(context),
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
              children: const [
                SizedBox(
                  child: QuickActionCard(
                    iconPath: 'assets/icons/tambahAksi.png',
                    label: 'Tambah Mahasiswa',
                    backgroundColor: Color(0xFFF8A7E5),
                    iconColor: Colors.white,
                    isSpecial: true,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          const Divider(height: 7, thickness: 10, color: Color.fromARGB(255, 240, 241, 241)),
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
        width: isSpecial ? 158.14.w : 158.14.w,
        height: isSpecial ? 39.17.h : 39.17.h,
        child: ElevatedButton(
          onPressed: onTap ?? () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
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