import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isRememberMeChecked = false; // Tambahkan state untuk checkbox

  void _login() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // Memastikan lebar penuh
        height: MediaQuery.of(context).size.height, // Memastikan tinggi penuh layar
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF412FB7), // Warna gradasi atas
              Colors.white, // Warna gradasi bawah
            ],
          ),
          image: const DecorationImage(
            image: AssetImage(
              'assets/images/backgroundLog.png',
            ), // Path ke gambar pola
            fit: BoxFit.cover, // Memastikan gambar memenuhi area
            alignment: Alignment.topCenter, // Menempatkan gambar di atas
          ),
        ),
        child: Column(
          children: [
            // Tambahkan gradasi biru di bagian atas
            Container(
              width: double.infinity,
              height: 57, // Tinggi gradasi biru
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF0000FF), // Biru terang
                    Color(0xFF412FB7), // Biru gelap
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 70), // Tambahkan jarak dari atas
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Image.asset(
                            'assets/images/LogoLoginSignIn.png',
                            width: 95,
                            height: 95,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'SIMPADU',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const Text(
                          'Sistem Informasi Terpadu',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 28),
                        const Text(
                          'Selamat Datang Kembali',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const Text(
                          'Silahkan masuk ke akun Anda',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Input Email/NIP
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Email/NIP',
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
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
                              hintStyle: const TextStyle(
                                color: Color(0xFF797979),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color(0xFFBDBDBD),
                                  width: 2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color(0xFFBDBDBD),
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color(0xFFBDBDBD),
                                  width: 2,
                                ),
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 21.0, right: 4.0),
                                child: SizedBox(
                                  width: 16, // Ukuran ikon tetap
                                  height: 16,
                                  child: Image.asset(
                                    'assets/icons/Email.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12.0, // Tinggi text box
                                horizontal: 10.0,
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email/NIP tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Input Password
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Password',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                                color: Color(0xFF000000),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                offset: const Offset(0, 4),
                                blurRadius: 6,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Masukan Password',
                              filled: true,
                              fillColor: Colors.white,
                              hintStyle: const TextStyle(
                                color: Color(0xFF797979),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color(0xFFBDBDBD),
                                  width: 2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color(0xFFBDBDBD),
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color(0xFFBDBDBD),
                                  width: 2,
                                ),
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 21.0, right: 4.0),
                                child: SizedBox(
                                  width: 16, // Ukuran ikon tetap
                                  height: 16,
                                  child: Image.asset(
                                    'assets/icons/LockPw.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 17.0),
                                child: Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                  size: 24,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12.0, // Tinggi text box
                                horizontal: 10.0,
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 1.5,
                                  child: Checkbox(
                                    value: _isRememberMeChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        _isRememberMeChecked = value ?? false;
                                      });
                                    },
                                    side: const BorderSide(
                                      color: Color(0xFFB2B0B0),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  'Ingat Saya',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF000000),
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Lupa Password?',
                                style: TextStyle(
                                  color: Color(0xFF3D61A8),
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: const Color(0xFF412FB7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'Masuk',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          '2025 SIMPADU - Politeknik Negeri Banjarmasin',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}