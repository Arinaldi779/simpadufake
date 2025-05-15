import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:simpadu/dashboard_admin_akademik.dart';
import 'package:intl/intl.dart';

class TahunAkademikPage extends StatefulWidget {
  const TahunAkademikPage({super.key});

  @override
  State<TahunAkademikPage> createState() => _TahunAkademikPageState();
}

class _TahunAkademikPageState extends State<TahunAkademikPage> {
  final List<Map<String, dynamic>> _tahunAkademikList = [];
  final TextEditingController _searchController = TextEditingController();

  void _addTahunAkademik(Map<String, dynamic> tahunAkademik) {
    setState(() {
      // If new year is set as active, deactivate all others
      if (tahunAkademik['isAktif']) {
        for (var item in _tahunAkademikList) {
          item['isAktif'] = false;
        }
      }
      _tahunAkademikList.add(tahunAkademik);
    });
  }

  void _editTahunAkademik(int index, Map<String, dynamic> tahunAkademik) {
    setState(() {
      // If edited year is set as active, deactivate all others
      if (tahunAkademik['isAktif']) {
        for (var item in _tahunAkademikList) {
          item['isAktif'] = false;
        }
      }
      _tahunAkademikList[index] = tahunAkademik;
    });
  }

  void _showAddEditDialog({int? index}) {
    final isEditing = index != null;
    final TextEditingController tahunController = TextEditingController();
    DateTime? startDate;
    DateTime? endDate;
    String? selectedSemester;
    bool isAktif = false;

    if (isEditing) {
      final tahunAkademik = _tahunAkademikList[index];
      tahunController.text = tahunAkademik['tahun'];
      selectedSemester = tahunAkademik['semester'];
      startDate = tahunAkademik['startDate'];
      endDate = tahunAkademik['endDate'];
      isAktif = tahunAkademik['isAktif'];
    }

    showDialog(
      context: context,
      builder: (context) {
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
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Center(
              child: Text(
                isEditing ? 'Edit Tahun Akademik' : 'Tambah Tahun Akademik',
                style: const TextStyle(
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
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: Color(0xFF9A9393),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: selectedSemester,
                      decoration: const InputDecoration(
                        labelText: 'Semester *',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: Color(0xFF9A9393),
                          fontWeight: FontWeight.w700,
                        ),
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
                    const Divider(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: startDate ?? DateTime.now(),
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
                                  Image.asset(
                                    'assets/icons/calendar2.png',
                                    width: 18,
                                    height: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    startDate != null
                                        ? '${startDate!.day.toString().padLeft(2, '0')}/${startDate!.month.toString().padLeft(2, '0')}/${startDate!.year}'
                                        : 'Pilih Tanggal',
                                    style: const TextStyle(
                                      fontSize: 8,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF656464),
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
                                initialDate: endDate ?? DateTime.now(),
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
                                  Image.asset(
                                    'assets/icons/calendar2.png',
                                    width: 18,
                                    height: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    endDate != null
                                        ? '${endDate!.day.toString().padLeft(2, '0')}/${endDate!.month.toString().padLeft(2, '0')}/${endDate!.year}'
                                        : 'Pilih Tanggal',
                                    style: const TextStyle(
                                      fontSize: 8,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF656464),
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
                            color: isAktif ? Colors.green : Colors.grey,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: isAktif ? Colors.green : Colors.grey,
                            width: 1.5,
                          ),
                        ),
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: isAktif ? Colors.green : Colors.grey,
                      ),
                      style: TextStyle(
                        color: isAktif ? Colors.green : Color(0xFF171717),
                        fontWeight: FontWeight.w500,
                      ),
                      items:
                          ['Aktif', 'Tidak Aktif'].map((status) {
                            return DropdownMenuItem<String>(
                              value: status,
                              child: Text(
                                status + '*',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (tahunController.text.isEmpty ||
                            selectedSemester == null ||
                            startDate == null ||
                            endDate == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Harap isi semua field yang wajib!',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        final tahunAkademik = {
                          'tahun': tahunController.text,
                          'semester': selectedSemester!,
                          'startDate': startDate!,
                          'endDate': endDate!,
                          'isAktif': isAktif,
                        };

                        if (isEditing) {
                          _editTahunAkademik(index!, tahunAkademik);
                        } else {
                          _addTahunAkademik(tahunAkademik);
                        }

                        Navigator.pop(context);

                        Future.delayed(const Duration(milliseconds: 200), () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.leftSlide,
                            title: 'Berhasil',
                            desc:
                                isEditing
                                    ? 'Tahun Akademik berhasil diubah!'
                                    : 'Tahun Akademik berhasil ditambahkan!',
                            btnOkOnPress: () {},
                          ).show();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(
                        Icons.check,
                        color: Color(0xFFFFFFFF),
                        size: 16,
                      ),
                      label: const Text(
                        'Simpan',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(
                        Icons.close,
                        color: Color(0xFFFFFFFF),
                        size: 16,
                      ),
                      label: const Text(
                        'Batalkan',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  List<Map<String, dynamic>> get _filteredTahunAkademikList {
    if (_searchController.text.isEmpty) {
      return _tahunAkademikList;
    }
    return _tahunAkademikList.where((tahun) {
      return tahun['tahun'].toLowerCase().contains(
        _searchController.text.toLowerCase(),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.4;

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
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {});
                    },
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
              const SizedBox(height: 20),

              // List of Academic Years
              if (_filteredTahunAkademikList.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Center(
                    child: Text(
                      'Tidak ada data tahun akademik',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _filteredTahunAkademikList.length,
                  itemBuilder: (context, index) {
                    final tahunAkademik = _filteredTahunAkademikList[index];
                    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
                    final String startDateFormatted = dateFormat.format(
                      tahunAkademik['startDate'],
                    );
                    final String endDateFormatted = dateFormat.format(
                      tahunAkademik['endDate'],
                    );

                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),


                      
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: Color(0xFF171717), // Warna border
                            width: 2, // Ketebalan border
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      tahunAkademik['isAktif']
                                          ? const Color(0xFFB2FFB7)
                                          : Color(0xFFD3D3D3),
                                  borderRadius: BorderRadius.circular(12),
                                  //   border: Border.all(
                                  //     color:
                                  //         tahunAkademik['isAktif']
                                  //             ? Color(0xFF31B14E)
                                  //             : Color(0xFFD3D3D3),
                                  //   ),
                                ),
                                child: Text(
                                  tahunAkademik['isAktif']
                                      ? 'AKTIF'
                                      : 'TIDAK AKTIF',
                                  style: TextStyle(
                                    color:
                                        tahunAkademik['isAktif']
                                            ? Color(0xFF31B14E)
                                            : Color(0xFF171717),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'TAHUN AKADEMIK',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF505050),
                                      fontSize: 13,
                                      // color: Colors.grey[600],
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      tahunAkademik['tahun'],
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF171717)
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'SEMESTER',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                       color: Color(0xFF505050),
                                       fontSize: 13,
                                      // color: Colors.grey[600],
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      tahunAkademik['semester'],
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF171717)
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'TANGGAL MULAI -\nSELESAI',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                       color: Color(0xFF505050),
                                       fontSize: 13,
                                      // color: Colors.grey[600],
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      '$startDateFormatted -\n$endDateFormatted',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF171717),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Align(
                                alignment:
                                    Alignment
                                        .bottomCenter, // Align the button to the bottom center
                                child: IconButton(
                                  icon: Image.asset(
                                    'assets/icons/edit.png',
                                    width: 41,
                                    height: 33,
                                  ),
                                  onPressed: () {
                                    _showAddEditDialog(index: index);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              const SizedBox(height: 80), // Space for the bottom button
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(35.0),
        child: SizedBox(
          width: 335,
          height: 60,
          child: ElevatedButton.icon(
            onPressed: _showAddEditDialog,
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
              backgroundColor: const Color(0xFF392A9F),
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

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Color(0xFF666666),
          ),
        ),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16, color: Colors.black)),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
