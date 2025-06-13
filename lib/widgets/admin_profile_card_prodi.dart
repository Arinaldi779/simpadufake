import 'package:flutter/material.dart';
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
  bool _showSecondContent = false;

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
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.2, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
              layoutBuilder:
                  (currentChild, previousChildren) =>
                      currentChild ?? const SizedBox.shrink(),
              child:
                  _showSecondContent
                      ? _buildSecondContent(widget.screenWidth)
                      : _buildFirstContent(widget.screenWidth),
            ),
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
                title: 'Kulikulum Aktif',
                value: '2025/2026',
                iconPath: 'assets/icons/callender.png',
                iconColor: const Color(0xFFC2D5FF),
                actionLabel: 'Kelola Dosen',
                onPressed: () {},
                iconArrowPath: 'assets/icons/arrowThn.png',
                backgroundColor: const Color(0xFF6092FF),
                buttonColor: const Color(0xFF6092FF),
                screenWidth: screenWidth,
                showCustomValueDesign: false,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: AdminStatCardProdi(
                title: 'Mata Kuliah Aktif',
                value: '22',
                iconPath: 'assets/icons/kelas.png',
                iconColor: const Color(0xFF6251A2),
                actionLabel: 'Lihat Daftar Mata Kuliah',
                onPressed: () {},
                iconArrowPath: 'assets/icons/arrowThn.png',
                backgroundColor: const Color(0xFFE5A7FF),
                buttonColor: const Color(0xFFE5A7FF),
                screenWidth: screenWidth,
                showCustomValueDesign: false,
              ),
            ),
          ],
        ),
        // const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _showSecondContent = !_showSecondContent;
              });
            },
            child: Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
               color: Color(0xFF473EAC),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 10.w,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: AdminStatCardProdi(
                title: 'Dosen Aktif',
                value: '27',
                iconPath: 'assets/icons/kelasAktif.png',
                iconColor: const Color(0xFF48742C),
                actionLabel: 'Kelola Kelas',
                onPressed: () {},
                iconArrowPath: 'assets/icons/arrowThn.png',
                backgroundColor: const Color(0xFF7EFFC7),
                buttonColor: const Color(0xFF7EFFC7),
                screenWidth: screenWidth,
                showCustomValueDesign: false,
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: AdminStatCardProdi(
                title: 'Presensi Dosen-Mahasiwa',
                value: '23 Prensensi belum\ndilakukan',
                iconPath: 'assets/icons/mahasiswa.png',
                iconColor: const Color(0xFF922017),
                actionLabel: 'Lihat Mahasiswa',
                onPressed: () {},
                iconArrowPath: 'assets/icons/arrowThn.png',
                backgroundColor: const Color(0xFFFFA587),
                buttonColor: const Color(0xFFFFA587),
                screenWidth: screenWidth,
                showCustomValueDesign: true,
                valueBackgroundColor: Color(0xFFFFCFC1),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Konten Kedua (Custom)
  Widget _buildSecondContent(double screenWidth) {
    return Column(
      key: const ValueKey('second_content'),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: AdminStatCardProdi(
                title: 'Nilai',
                value: '15 Nilai belum\ndi input',
                iconPath: 'assets/icons/nilai.png',
                iconColor: const Color(0xFF531818),
                actionLabel: 'Lihat Daftar Nilai',
                onPressed: () {},
                iconArrowPath: 'assets/icons/arrowThn.png',
                backgroundColor: const Color(0xFFFF6262),
                buttonColor: const Color(0xFFFF6262),
                screenWidth: screenWidth,
                showCustomValueDesign: true,
                valueBackgroundColor: Color(0xFFFF9898),
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: AdminStatCardProdi(
                title: 'KHS&KRS',
                value: '2 KRS Tesedia\n3 KHS Belum Terisi',
                iconPath: 'assets/icons/krsKhs.png',
                iconColor: const Color(0xFF645029),
                actionLabel: 'Lihat Mahasiswa',
                onPressed: () {},
                iconArrowPath: 'assets/icons/arrowThn.png',
                backgroundColor: const Color(0xFFFFF7AC),
                buttonColor: const Color(0xFFFFF7AC),
                screenWidth: screenWidth,
                showCustomValueDesign: true,
                valueBackgroundColor: Color(0xFFFFF8D0),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
       Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _showSecondContent = !_showSecondContent;
              });
            },
            child: Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF473EAC),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 10.w,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
