// admin_stat_card_prodi.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminStatCardProdi extends StatelessWidget {
  final String title;
  final String value;
  final String iconPath;
  final Color iconColor;
   final String iconArrowPath;
  final String actionLabel;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color buttonColor;
  final double screenWidth;

  final bool showCustomValueDesign;
  final Color valueBackgroundColor;

  const AdminStatCardProdi({
    super.key,
    required this.title,
    required this.value,
    required this.iconPath,
    required this.iconColor,
    required this.actionLabel,
    required this.iconArrowPath,
    required this.onPressed,
    required this.backgroundColor,
    required this.buttonColor,
    required this.screenWidth,
    this.showCustomValueDesign = false,
    this.valueBackgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(13.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              SizedBox(width: 5.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 9.5.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                   if (showCustomValueDesign && value.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: valueBackgroundColor,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 7.sp, // Ukuran font lebih besar
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      )
                    else if (value.isNotEmpty)
                      Text(
                        value,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
              elevation: 0,
              minimumSize: const Size(40, 30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      actionLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 8.5.sp,
                        fontFamily: 'Poppins',
                        color: iconColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 5.w)),
                Image.asset(
                    iconArrowPath,
                    width: 10.w,
                    height: 10.h,
                    color: iconColor,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}