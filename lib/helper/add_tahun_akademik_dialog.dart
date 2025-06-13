import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simpadu/models/tahun_akademik_model.dart';

class AddTahunAkademikDialog extends StatelessWidget {
  final Function(TahunAkademik) onSave;

  const AddTahunAkademikDialog({super.key, required this.onSave});

  Future<void> _selectDate(BuildContext context, Function(DateTime) onDateSelected) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && context.mounted) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final idController = TextEditingController();
    final tahunController = TextEditingController();
    String? selectedSemester = 'Ganjil';
    DateTime? startDate, endDate;
    bool isAktif = false;

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tambah Tahun Akademik',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: idController,
              decoration: InputDecoration(labelText: 'Kode Tahun *'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: tahunController,
              decoration: InputDecoration(labelText: 'Tahun Ajaran *'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedSemester,
              items: ['Ganjil', 'Genap'].map((s) {
                return DropdownMenuItem<String>(value: s, child: Text(s));
              }).toList(),
              onChanged: (value) => selectedSemester = value,
              decoration: const InputDecoration(labelText: 'Semester *'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _selectDate(context, (date) => startDate = date),
                    child: InputDecorator(
                      decoration: const InputDecoration(labelText: 'Tanggal Mulai'),
                      child: Text(startDate != null
                          ? DateFormat('dd/MM/yyyy').format(startDate!)
                          : 'Pilih Tanggal'),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: () => _selectDate(context, (date) => endDate = date),
                    child: InputDecorator(
                      decoration: const InputDecoration(labelText: 'Tanggal Selesai'),
                      child: Text(endDate != null
                          ? DateFormat('dd/MM/yyyy').format(endDate!)
                          : 'Pilih Tanggal'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: isAktif ? 'Aktif' : 'Tidak Aktif',
              items: ['Aktif', 'Tidak Aktif'].map((status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (value) => isAktif = value == 'Aktif',
              decoration: const InputDecoration(labelText: 'Status'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    if (idController.text.isEmpty ||
                        tahunController.text.isEmpty ||
                        selectedSemester == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Harap isi semua field wajib!'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    final newTahunAkademik = TahunAkademik(
                      idThnAk: idController.text,
                      tahun: tahunController.text,
                      semester: selectedSemester!,
                      startDate: startDate,
                      endDate: endDate,
                      isAktif: isAktif,
                    );

                    onSave(newTahunAkademik);
                  },
                  icon: Icon(Icons.check, size: 16),
                  label: Text('Simpan'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: Navigator.of(context).pop,
                  icon: Icon(Icons.close, size: 16),
                  label: Text('Batal'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}