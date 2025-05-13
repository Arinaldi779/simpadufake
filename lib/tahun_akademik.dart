import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:simpadu/dashboard_admin_akademik.dart';

class TahunAkademikPage extends StatelessWidget {
  const TahunAkademikPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2103FF), Color(0xFF140299)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.71],
            ),
          ),
        ),
        title: Row(
          children: [
            Image.asset('assets/images/logo2.png', width: 60, height: 60),
            const SizedBox(width: 10),
            const Text(
              'SIMPADU',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumb
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashboardAdmin(),
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 30.0, left: 10.0),
                      child: Text(
                        'Dashboard',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF686868),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    ' > ',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF686868),
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text(
                      'Tahun Akademik',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Title
              const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text(
                  'Tahun Akademik',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Search Field
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: SizedBox(
                  width: 324,
                  height: 36,
                  child: TextField(
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 12,
                      ),
                      hintText: ' Cari Tahun...',
                      hintStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: Color(0xFF999999),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: Image.asset(
                          'assets/icons/search.png',
                          width: 23,
                          height: 23,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF999999),
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF0B0B0B),
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 60,
              ), // Spacer agar tombol tidak nempel ke atas
            ],
          ),
        ),
      ),

      // Tombol di bawah
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(35.0),
        child: SizedBox(
          width: 335,
          height: 60,
          child: ElevatedButton.icon(
            onPressed: () {
              // Tampilkan dialog tambah tahun akademik
              showDialog(
                context: context,
                builder: (context) {
                  final TextEditingController tahunController =
                      TextEditingController();
                  DateTime? startDate;
                  DateTime? endDate;
                  String? selectedSemester;
                  bool isAktif = false;

                  return AlertDialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    titlePadding: EdgeInsets.zero,
                    title: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Color(0xFF392A9F),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Tambah Tahun Akademik',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    content: StatefulBuilder(
                      builder: (context, setState) {
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: tahunController,
                                decoration: const InputDecoration(
                                  labelText: 'Tahun Ajaran *',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 12),
                              DropdownButtonFormField<String>(
                                value: selectedSemester,
                                decoration: const InputDecoration(
                                  labelText: 'Semester *',
                                  border: OutlineInputBorder(),
                                ),
                                items:
                                    ['Ganjil', 'Genap'].map((semester) {
                                      return DropdownMenuItem<String>(
                                        value: semester,
                                        child: Text(semester),
                                      );
                                    }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedSemester = value!;
                                  });
                                },
                              ),
                              const Divider(height: 32),
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {
                                        DateTime? picked = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2100),
                                        );
                                        if (picked != null) {
                                          setState(() {
                                            startDate = picked;
                                          });
                                        }
                                      },
                                      child: InputDecorator(
                                        decoration: const InputDecoration(
                                          labelText: 'Start Date',
                                          border: OutlineInputBorder(),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.calendar_today,
                                              size: 18,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              startDate != null
                                                  ? '${startDate!.day.toString().padLeft(2, '0')}/${startDate!.month.toString().padLeft(2, '0')}/${startDate!.year}'
                                                  : '01/01/2000',
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {
                                        DateTime? picked = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2100),
                                        );
                                        if (picked != null) {
                                          setState(() {
                                            endDate = picked;
                                          });
                                        }
                                      },
                                      child: InputDecorator(
                                        decoration: const InputDecoration(
                                          labelText: 'End Date',
                                          border: OutlineInputBorder(),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.calendar_today,
                                              size: 18,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              endDate != null
                                                  ? '${endDate!.day.toString().padLeft(2, '0')}/${endDate!.month.toString().padLeft(2, '0')}/${endDate!.year}'
                                                  : '01/01/2000',
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              DropdownButtonFormField<String>(
                                value: isAktif ? 'Aktif' : 'Tidak Aktif',
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      isAktif
                                          ? const Color(0xFFDFF5E1)
                                          : Colors.grey[200],
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color:
                                          isAktif ? Colors.green : Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color:
                                          isAktif ? Colors.green : Colors.grey,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: isAktif ? Colors.green : Colors.grey,
                                ),
                                style: TextStyle(
                                  color:
                                      isAktif ? Colors.green : Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                                items:
                                    ['Aktif', 'Tidak Aktif'].map((status) {
                                      return DropdownMenuItem<String>(
                                        value: status,
                                        child: Text(
                                          status + '*',
                                          style: TextStyle(
                                            color:
                                                status == 'Aktif'
                                                    ? Colors.green
                                                    : Colors.black,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    isAktif = value == 'Aktif';
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    actionsPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    actions: [
                      Center(
                        child: Row(
                          mainAxisSize:
                              MainAxisSize
                                  .min, // agar tombol menyesuaikan lebar isinya
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                String tahun = tahunController.text;
                                String semester = selectedSemester ?? '';
                                Navigator.pop(context);

                                Future.delayed(
                                  const Duration(milliseconds: 100),
                                  () {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.success,
                                      animType: AnimType.leftSlide,
                                      title: 'Berhasil',
                                      desc:
                                          'Tahun Akademik berhasil ditambahkan!',
                                    ).show();
                                  },
                                );

                                print(
                                  'Tahun: $tahun, Semester: $semester, Aktif: $isAktif',
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[400],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              icon: const Icon(Icons.check),
                              label: const Text('Simpan'),
                            ),
                            const SizedBox(width: 16), // Jarak antar tombol
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              icon: const Icon(Icons.close),
                              label: const Text('Batalkan'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Image.asset(
              'assets/icons/plus_icon.png',
              width: 20,
              height: 20,
            ),
            label: const Text(
              'Tambah Tahun Akademik',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 19,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF392A9F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
            ),
          ),
        ),
      ),
    );
  }
}
