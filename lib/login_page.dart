import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:simpadu/dashboard_admin_akademik.dart';
import 'package:quickalert/quickalert.dart';
import 'package:simpadu/dashboard_admin_prodi.dart';
import 'package:simpadu/services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isRememberMeChecked = false;
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    final saved = await ApiService.loadSavedCredentials();
    setState(() {
      _isRememberMeChecked = saved['isRemembered'] ?? false;
      if (_isRememberMeChecked) {
        _emailController.text = saved['email'] ?? '';
        _passwordController.text = saved['password'] ?? '';
      }
    });
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final username = _emailController.text.trim();
      final password = _passwordController.text.trim();

      try {
        final result = await ApiService.login(username, password);

        if (result['success']) {
          await ApiService.saveUserCredentials(
            username,
            password,
            _isRememberMeChecked,
          );

          final role = result['role'] as String?;

          if (!mounted) return;

          if (role == "Super Admin") {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.custom,
              barrierDismissible: false,
              widget: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    'Pilih Ingin Kemana',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      color: const Color(0xFF2103FF),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Anda login sebagai Super Admin.\nSilakan pilih yang ingin Anda tuju.',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.sp,
                      color: const Color(0xFF140299),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2103FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 10.h,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const DashboardAdmin(),
                            ),
                          );
                        },
                        child: Text(
                          'Admin Akademik',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF140299),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 10.h,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const DashboardAdminProdi(),
                            ),
                          );
                        },
                        child: Text(
                          'Admin Prodi',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (role == "Admin Akademik") {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const DashboardAdmin(),
                transitionsBuilder: (_, animation, __, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  final tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: Curves.easeInOut));
                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 800),
              ),
            );
          } else if (role == "Admin Prodi") {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const DashboardAdminProdi(),
                transitionsBuilder: (_, animation, __, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  final tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: Curves.easeInOut));
                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 2000),
              ),
            );
          } else {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'Role Tidak Dikenali',
              text: 'Role tidak dikenali!',
              confirmBtnText: 'OK',
              confirmBtnColor: Colors.red,
              onConfirmBtnTap: () => Navigator.pop(context),
            );
          }
        } else {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Login Gagal',
            text: result['message'],
            confirmBtnText: 'Coba Lagi',
            confirmBtnColor: Colors.red,
            onConfirmBtnTap: () => Navigator.pop(context),
          );
        }
      } catch (e) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Terjadi Kesalahan',
          text: 'Error: $e',
          confirmBtnText: 'Tutup',
          confirmBtnColor: Colors.red,
          onConfirmBtnTap: () => Navigator.pop(context),
        );
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: LoadingAnimationWidget.twistingDots(
                  leftDotColor: const Color(0xFF140299),
                  rightDotColor: const Color(0xFFFFFFFF),
                  size: 50,
                ),
              )
            : LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    width: double.infinity,
                    height: constraints.maxHeight,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 57.h,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Color(0xFF2103FF), Color(0xFF140299)],
                              stops: [0.0, 0.71],
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 15.w),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    SizedBox(height: 100.h),
                                    Image.asset(
                                      'assets/images/LogoLoginSignIn.png',
                                      width: 120.w,
                                      height: 120.w,
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      'SIMPADU',
                                      style: TextStyle(
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    Text(
                                      'Sistem Informasi Terpadu',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    SizedBox(height: 28.h),
                                    Text(
                                      'Selamat Datang Kembali',
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    Text(
                                      'Silahkan masuk ke akun Anda',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    SizedBox(height: 15.h),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 23.w),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Email/NIP',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFF000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 3.h),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 13.w,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.25),
                                              offset: const Offset(0, 4),
                                              blurRadius: 4,
                                              spreadRadius: 0,
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          controller: _emailController,
                                          decoration: InputDecoration(
                                            hintText: 'Masukan Email/NIP',
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintStyle: TextStyle(
                                              color: const Color(0xFF797979),
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              borderSide: const BorderSide(
                                                color: Color(0xFFBDBDBD),
                                                width: 2,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              borderSide: const BorderSide(
                                                color: Color(0xFFBDBDBD),
                                                width: 2,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              borderSide: const BorderSide(
                                                color: Color(0xFFBDBDBD),
                                                width: 2,
                                              ),
                                            ),
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.only(
                                                left: 21.w,
                                                right: 4.w,
                                              ),
                                              child: SizedBox(
                                                width: 16.w,
                                                height: 16.h,
                                                child: Image.asset(
                                                  'assets/icons/Email.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              vertical: 12.h,
                                              horizontal: 10.w,
                                            ),
                                          ),
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.black87,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Email/NIP tidak boleh kosong';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16.h),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 23.w),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Password',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                            color: const Color(0xFF000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 3.h),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 13.w,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.25),
                                              offset: const Offset(0, 4),
                                              blurRadius: 6,
                                              spreadRadius: 0,
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          controller: _passwordController,
                                          obscureText: !_isPasswordVisible,
                                          decoration: InputDecoration(
                                            hintText: 'Masukan Password',
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintStyle: TextStyle(
                                              color: const Color(0xFF797979),
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              borderSide: const BorderSide(
                                                color: Color(0xFFBDBDBD),
                                                width: 2,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              borderSide: const BorderSide(
                                                color: Color(0xFFBDBDBD),
                                                width: 2,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              borderSide: const BorderSide(
                                                color: Color(0xFFBDBDBD),
                                                width: 2,
                                              ),
                                            ),
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.only(
                                                left: 21.w,
                                                right: 4.w,
                                              ),
                                              child: SizedBox(
                                                width: 16.w,
                                                height: 16.h,
                                                child: Image.asset(
                                                  'assets/icons/LockPw.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            suffixIcon: IconButton(
                                              padding: EdgeInsets.only(
                                                right: 10.w,
                                              ),
                                              icon: Icon(
                                                _isPasswordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Colors.grey,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _isPasswordVisible =
                                                      !_isPasswordVisible;
                                                });
                                              },
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              vertical: 12.h,
                                              horizontal: 10.w,
                                            ),
                                          ),
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.black87,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Password tidak boleh kosong';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 13.w,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Transform.scale(
                                                scale: 1.5,
                                                child: Checkbox(
                                                  value: _isRememberMeChecked,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _isRememberMeChecked =
                                                          value ?? false;
                                                    });
                                                  },
                                                  side: const BorderSide(
                                                    color:
                                                        Color(0xFFB2B0B0),
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 5.w),
                                              Text(
                                                'Ingat Saya',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  color: const Color(
                                                    0xFF000000,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              'Lupa Password?',
                                              style: TextStyle(
                                                color:
                                                    const Color(0xFF3D61A8),
                                                fontSize: 12.sp,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 13.w,
                                      ),
                                      child: ElevatedButton(
                                        onPressed: _isLoading ? null : _login,
                                        style: ElevatedButton.styleFrom(
                                          minimumSize:
                                              Size(double.infinity, 50.h),
                                          backgroundColor:
                                              const Color(0xFF412FB7),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                        ),
                                        child: _isLoading
                                            ? const CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                            : Text(
                                                'Masuk',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white,
                                                ),
                                              ),
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Text(
                                      '2025 SIMPADU - Politeknik Negeri Banjarmasin',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}