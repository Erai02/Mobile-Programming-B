// Lokasi: lib/medication_detail_screen.dart

import 'package:flutter/material.dart';

class MedicationDetailScreen extends StatelessWidget {
  final String medicationName;
  final String schedule;
  final bool isActive;

  const MedicationDetailScreen({
    Key? key,
    required this.medicationName,
    required this.schedule,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Tentukan warna berdasarkan status aktif/inaktif
    final Color pillColor = isActive ? const Color(0xFF4A00E0) : Colors.grey;

    return Scaffold(
      // 1. AppBar untuk menampilkan nama obat
      appBar: AppBar(
        title: Text(medicationName),
        backgroundColor: const Color(0xFF003D80), // Biru tua
      ),
      
      // 2. Body untuk menampilkan semua detail
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.medication, color: pillColor, size: 40),
                const SizedBox(width: 16),
                Text(
                  medicationName,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(),

            // Info Detail (Data dummy tambahan)
            _DetailRow(title: 'Status', value: isActive ? 'Active' : 'Inactive'),
            _DetailRow(title: 'Schedule', value: schedule),
            _DetailRow(title: 'Dosage', value: '1 tablet / once a day'),
            _DetailRow(title: 'Doctor', value: 'Dr. Amanda'),
            _DetailRow(title: 'Notes', value: 'Take after meal.'),
          ],
        ),
      ),
    );
  }
}

// Widget helper untuk menampilkan baris detail
class _DetailRow extends StatelessWidget {
  final String title;
  final String value;
  const _DetailRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}