import 'package:intl/intl.dart'; // Import paket intl untuk format tanggal dan waktu
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simpadu/screens/daftar_kelas.dart';
import 'package:simpadu/screens/mahasiswa.dart';
import 'package:simpadu/screens/tahun_akademik.dart';
import 'admin_stat_card.dart';

class AdminProfileCard extends StatelessWidget {
  final double screenWidth;
  const AdminProfileCard({Key? key, required this.screenWidth}) : super(key: key);

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
          // Informasi Admin
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                child: CircleAvatar(
                  radius: 29,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage('assets/images/admin.png'),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Khayla Annisa',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Admin Akademik - Teknik Informatika',
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
          // Kartu Statistik
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: AdminStatCard(
                        title: 'Tahun Akademik Aktif',
                        value: '2025/2026',
                        iconPath: 'assets/icons/callender.png',
                        iconColor: const Color(0xFF12303D),
                        actionLabel: 'Date : ${DateFormat("dd MMM yyyy").format(DateTime.now())}',
                        onPressed: () {},
                        iconArrowPath: 'assets/icons/arrowThn.png',
                        screenWidth: screenWidth,
                        backgroundColor: const Color(0xFFA3C0FF),
                        buttonColor: const Color(0xFFA3C0FF),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: AdminStatCard(
                        title: 'Tahun Akademik Aktif',
                        value: '2025/2026',
                        iconPath: 'assets/icons/callender.png',
                        iconColor: const Color(0xFF472259),
                        actionLabel: 'Kelola Tahun Akademik',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TahunAkademikPage()),
                          );
                        },
                        iconArrowPath: 'assets/icons/arrowThn.png',
                        screenWidth: screenWidth,
                        backgroundColor: const Color(0xFFE5A7FF),
                        buttonColor: const Color(0xFFE5A7FF),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: AdminStatCard(
                        title: 'Kelas Aktif',
                        value: '27',
                        iconPath: 'assets/icons/kelasAktif.png',
                        iconColor: const Color(0xFF48742C),
                        actionLabel: 'Kelola Daftar Kelas',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DaftarKelasPage()),
                          );
                        },
                        iconArrowPath: 'assets/icons/arrowThn.png',
                        screenWidth: screenWidth,
                        backgroundColor: const Color(0xFF7EFFC7),
                        buttonColor: const Color(0xFF7EFFC7),
                      ),
                    ),
                  ),
                  Flexible(
                    child: AdminStatCard(
                      title: 'Mahasiswa Aktif',
                      value: '3.321',
                      iconPath: 'assets/icons/mahasiswa.png',
                      iconColor: const Color(0xFF762717),
                      actionLabel: 'Kelola Data Mahasiswa',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DaftarMasiswaPage()),
                        );
                      },
                      iconArrowPath: 'assets/icons/arrowThn.png',
                      screenWidth: screenWidth,
                      backgroundColor: const Color(0xFFFFA587),
                      buttonColor: const Color(0xFFFFA587),
                    ),  
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}