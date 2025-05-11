import 'package:flutter/material.dart';

class DashboardAdmin extends StatelessWidget {
  const DashboardAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SingleChildScrollView(
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF2103FF), Color(0xFF140299)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 0.71],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 4,
                  right: 4,
                  child: Container(
                    height: 75,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(top: 5, left: 13),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/images/LogoDash.png',
                              ),
                              radius: 20,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'SIMPADU',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.notifications,
                          color: Color(0xFFFFFF00),
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Transform.translate(
              offset: const Offset(0, -180),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
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
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            child: CircleAvatar(
                              radius: 29,
                              backgroundColor: Colors.black,
                              child: CircleAvatar(
                                radius: 28,
                                backgroundImage: AssetImage(
                                  'assets/images/admin.png',
                                ),
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
                      const Divider(
                        height: 24,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                  ),
                                  child: _buildStatCard(
                                    'Tahun Akademik Aktif',
                                    '2025/2026',
                                    'assets/icons/callender.png',
                                    const Color(0xFF12303D),
                                    'Kelola Tahun Akademik',
                                    () {},
                                    'assets/icons/arrowThn.png',
                                    screenWidth,
                                    Color(0xFFA3C0FF),
                                    Color(0xFFA3C0FF),
                                    alignTextToStart: true,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                  ),
                                  child: _buildStatCard(
                                    'Kelas Tidak Aktif',
                                    '22',
                                    'assets/icons/kelas.png',
                                    const Color(0xFF472259),
                                    'Kelola Daftar Kelas',
                                    () {},
                                    'assets/icons/arrowThn.png',
                                    screenWidth,
                                    Color(0xFFE5A7FF),
                                    Color(0xFFE5A7FF),
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                  ),
                                  child: _buildStatCard(
                                    'Kelas Aktif',
                                    '27',
                                    'assets/icons/kelasAktif.png',
                                    const Color(0xFF48742C),
                                    'Kelola Daftar Kelas',
                                    () {},
                                    'assets/icons/arrowThn.png',
                                    screenWidth,
                                    Color(0xFF7EFFC7),
                                    Color(0xFF7EFFC7),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: .0,
                                  ),
                                  child: _buildStatCard(
                                    'Mahasiswa Aktif',
                                    '3.321',
                                    'assets/icons/mahasiswa.png',
                                    const Color(0xFF762717),
                                    'Kelola Data Mahasiswa',
                                    () {},
                                    'assets/icons/arrowThn.png',
                                    screenWidth,
                                    Color(0xFFFFA587),
                                    Color(0xFFFFA587),
                                    alignTextToStart: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  static Widget _buildStatCard(
    String title,
    String value,
    String iconPath,
    Color iconColor,
    String actionLabel,
    VoidCallback onPressed,
    String iconArrowPath,
    double screenWidth,
    Color backgroundColor,
    Color buttonColor, {
    bool alignTextToStart =
        false, // default false, bisa diatur saat pemanggilan
  }) {
    double fontTitleSize = 9.5;
    double fontValueSize = 12;
    double fontButtonSize = 10;

    if (screenWidth < 350) {
      fontTitleSize = 6.0;
      fontValueSize = 10;
      fontButtonSize = 8;
    } else if (screenWidth < 450) {
      fontTitleSize = 7;
      fontValueSize = 11;
      fontButtonSize = 8;
    }

    return Container(
      padding: const EdgeInsets.all(13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                  color: iconColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.right,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: fontTitleSize,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      value,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: fontValueSize,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity, // Agar tombol selebar container
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                elevation: 0,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: Size.zero,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Align(
                      alignment: alignTextToStart
                          ? Alignment.centerLeft
                          : Alignment.center,
                      child: Text(
                        actionLabel,
                        maxLines: 1, // Membatasi teks menjadi satu baris
                        overflow: TextOverflow.ellipsis, // Menggunakan ellipsis jika teks terlalu panjang
                        style: TextStyle(
                          fontSize: fontButtonSize,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Image.asset(
                    iconArrowPath,
                    width: 10,
                    height: 10,
                    color: iconColor,
                  ),
                ],
              ),
            ),
          ),
          // ... existing code ...
        ],
      ),
    );
  }
}
