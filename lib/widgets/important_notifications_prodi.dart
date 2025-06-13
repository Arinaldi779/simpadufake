// important_notifications_prodi.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImportantNotificationsProdi extends StatelessWidget {
  const ImportantNotificationsProdi({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Notifikasi Penting',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                ),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF1D03DC),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                onPressed: () {},
                label: Row(
                  children: const [
                    Text(
                      "Selengkapnya",
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward, size: 14),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Container(
            margin: EdgeInsets.only(bottom: 10.h),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/warning.png',
                  width: 24.w,
                  height: 24.h,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    "Belum input nilai untuk 5 kelas",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: const Color(0xFFBB271A),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/info.png',
                  width: 24.w,
                  height: 24.h,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    "12 Mahasiswa belum melakukan KRS",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: const Color(0xFF4E84C1),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}