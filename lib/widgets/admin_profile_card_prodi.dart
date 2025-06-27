import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/admin_stat_card_prodi.dart';

class AdminProfileCardProdi extends StatefulWidget {
  final double screenWidth;
  const AdminProfileCardProdi({Key? key, required this.screenWidth})
    : super(key: key);

  @override
  State<AdminProfileCardProdi> createState() => _AdminProfileCardProdiState();
}

class _AdminProfileCardProdiState extends State<AdminProfileCardProdi> {
  // bool _showSecondContent = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Bagian Profil Admin
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/admin.png'),
              ),
              SizedBox(width: 16.w),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Daffa Ramadhan Nugraha',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Admin Prodi - Teknik Informatika',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 24, thickness: 1, color: Colors.black),

          // Konten Utama (Animated)
          SizedBox(
            // height: 250.h, // atau sesuaikan tinggi sesuai desain Anda
            child: _buildFirstContent(widget.screenWidth),
          ),
        ],
      ),
    );
  }

  // Konten Pertama (Default)
  Widget _buildFirstContent(double screenWidth) {
    return Column(
      key: const ValueKey('first_content'),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: AdminStatCardProdi(
                title: 'Tahun Akademik Aktif',
                value: '2025/2026',
                iconPath: 'assets/icons/callender.png',
                iconColor: const Color(0xFF12303D),
                actionLabel:
                    'Date : ${DateFormat("dd MMM yyyy").format(DateTime.now())}',
                onPressed: () {},
                iconArrowPath: 'assets/icons/arrowThn.png',
                screenWidth: screenWidth,
                backgroundColor: const Color(0xFFA3C0FF),
                buttonColor: const Color(0xFFA3C0FF),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: AdminStatCardProdi(
                title: 'Kulikulum Aktif',
                value: '2025/2026',
                iconPath: 'assets/icons/callender.png',
                iconColor: const Color(0xFFC2D5FF),
                actionLabel: 'Kelola Kurikulum',
                onPressed: () {
                  Navigator.pushNamed(context, '/kurikulum');
                },
                iconArrowPath: 'assets/icons/arrowThn.png',
                backgroundColor: const Color(0xFF6092FF),
                buttonColor: const Color(0xFF6092FF),
                screenWidth: screenWidth,
                showCustomValueDesign: false,
              ),
            ),
          ],
        ),
        // onst SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: AdminStatCardProdi(
                title: 'Mata Kuliah Aktif',
                value: '22',
                iconPath: 'assets/icons/kelas.png',
                iconColor: const Color(0xFF6251A2),
                actionLabel: 'Lihat Daftar Mata Kuliah',
                onPressed: () {
                  Navigator.pushNamed(context, '/matakuliah');
                },
                iconArrowPath: 'assets/icons/arrowThn.png',
                backgroundColor: const Color(0xFFE5A7FF),
                buttonColor: const Color(0xFFE5A7FF),
                screenWidth: screenWidth,
                showCustomValueDesign: false,
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: AdminStatCardProdi(
                title: 'Dosen Aktif',
                value: '27',
                iconPath: 'assets/icons/kelasAktif.png',
                iconColor: const Color(0xFF48742C),
                actionLabel: 'Dosen Ajar',
                onPressed: () {
                  Navigator.pushNamed(context, '/dosenAjar');
                },
                iconArrowPath: 'assets/icons/arrowThn.png',
                backgroundColor: const Color(0xFF7EFFC7),
                buttonColor: const Color(0xFF7EFFC7),
                screenWidth: screenWidth,
                showCustomValueDesign: false,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
