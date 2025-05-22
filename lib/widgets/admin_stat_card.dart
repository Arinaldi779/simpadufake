// Widget reusable untuk menampilkan kartu statistik (title, angka, ikon, tombol)

import 'package:flutter/material.dart';

class AdminStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String iconPath;
  final Color iconColor;
  final String actionLabel;
  final VoidCallback onPressed;
  final String iconArrowPath;
  final double screenWidth;
  final Color backgroundColor;
  final Color buttonColor;
  final bool alignTextToStart;

  const AdminStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.iconPath,
    required this.iconColor,
    required this.actionLabel,
    required this.onPressed,
    required this.iconArrowPath,
    required this.screenWidth,
    required this.backgroundColor,
    required this.buttonColor,
    this.alignTextToStart = false,
  });

  @override
  Widget build(BuildContext context) {
    double fontTitleSize = 9.5;
    double fontValueSize = 12;
    double fontButtonSize = 8.5;

    // Responsif untuk ukuran layar kecil
    if (screenWidth < 350) {
      fontTitleSize = 6.0;
      fontValueSize = 10;
      fontButtonSize = 7;
    } else if (screenWidth < 450) {
      fontTitleSize = 7;
      fontValueSize = 11;
      fontButtonSize = 7.5;
    }

    return Container(
      padding: const EdgeInsets.all(13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Baris ikon dan teks
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
                      textAlign: TextAlign.center,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: fontTitleSize,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      value,
                      textAlign: TextAlign.center,
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
          // Tombol aksi
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                padding:
                    const EdgeInsets.symmetric(horizontal:16, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                elevation: 0,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: const Size(40, 30),
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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
        ],
      ),
    );
  }
}
