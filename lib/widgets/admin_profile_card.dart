// Widget kartu profil admin yang berisi:
// - Info admin (foto dan jabatan)
// - Statistik (jumlah kelas, mahasiswa, dll)

import 'package:flutter/material.dart';
import 'package:simpadu/daftar_kelas.dart';
import 'package:simpadu/mahasiswa.dart';
import 'admin_stat_card.dart';
import 'package:simpadu/tahun_akademik.dart';

class AdminProfileCard extends StatelessWidget {
  final double screenWidth;

  const AdminProfileCard({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
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
              const SizedBox(width: 16),
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
                        actionLabel: 'Kelola Tahun Akademik',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TahunAkademikPage()),
                          );
                        },
                        iconArrowPath: 'assets/icons/arrowThn.png',
                        screenWidth: screenWidth,
                        backgroundColor: const Color(0xFFA3C0FF),
                        buttonColor: const Color(0xFFA3C0FF),
                        alignTextToStart: true,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: AdminStatCard(
                        title: 'Kelas Tidak Aktif',
                        value: '22',
                        iconPath: 'assets/icons/kelas.png',
                        iconColor: const Color(0xFF472259),
                        actionLabel: 'Kelola Daftar Kelas',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DaftarKelasPage()),
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
                            MaterialPageRoute(builder: (context) => DaftarMahasiswaPage()),
                          );
                      },
                      iconArrowPath: 'assets/icons/arrowThn.png',
                      screenWidth: screenWidth,
                      backgroundColor: const Color(0xFFFFA587),
                      buttonColor: const Color(0xFFFFA587),
                      alignTextToStart: true,
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
