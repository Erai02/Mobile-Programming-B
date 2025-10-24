// Lokasi: lib/medication_model.dart

import 'package:flutter/material.dart';

class MedicationSchedule {
  final String id;
  final String name;
  final String dosage;      // Dosis (misal: "1 pil", "5 mg")
  final TimeOfDay time;     // Jam berapa obat harus diminum
  final DateTime appliesToDate; // Untuk dummy data, kita paskan tanggalnya

  MedicationSchedule({
    required this.id,
    required this.name,
    required this.dosage,
    required this.time,
    required this.appliesToDate,
  });
}