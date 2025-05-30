import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    double fontTitleSize = 9.5.sp;
    double fontValueSize = 12.sp;
    double fontButtonSize = 8.5.sp;

    // Responsif untuk ukuran layar kecil
    if (screenWidth < 350) {
      fontTitleSize = 6.0.sp;
      fontValueSize = 10.sp;
      fontButtonSize = 7.sp;
    } else if (screenWidth < 450) {
      fontTitleSize = 7.sp;
      fontValueSize = 11.sp;
      fontButtonSize = 7.5.sp;
    }

    return Container(
      padding: EdgeInsets.all(13.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Baris ikon dan teks
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Image.asset(
                  iconPath,
                  width: 24.w,
                  height: 24.h,
                  color: iconColor,
                ),
              ),
              SizedBox(width: 12.w),
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
          SizedBox(height: 8.h),
          // Tombol aksi
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
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
                  SizedBox(width: 4.w),
                  Image.asset(
                    iconArrowPath,
                    width: 10.w,
                    height: 10.h,
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