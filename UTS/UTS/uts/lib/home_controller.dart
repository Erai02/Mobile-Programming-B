// Lokasi: lib/home_controller.dart

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Untuk ChangeNotifier
import 'medication_model.dart';         // Impor Model kita

class HomeController extends ChangeNotifier {
  
  // --- STATE (Data yang akan didengarkan UI) ---

  DateTime _selectedDate = DateTime.now();
  bool _isCalendarOpen = false;

  // --- DUMMY DATABASE ---
  // Kita buat data palsu untuk hari ini dan besok
  final List<MedicationSchedule> _allSchedules = [
    MedicationSchedule(
      id: 'm1',
      name: 'Paracetamol',
      dosage: '1 tablet',
      time: const TimeOfDay(hour: 8, minute: 0),
      // Hanya untuk hari ini
      appliesToDate: DateTime.now(),
    ),
    MedicationSchedule(
      id: 'm2',
      name: 'Vitamin C',
      dosage: '1 tablet',
      time: const TimeOfDay(hour: 12, minute: 30),
      // Hanya untuk hari ini
      appliesToDate: DateTime.now(),
    ),
    MedicationSchedule(
      id: 'm3',
      name: 'Amoxicillin',
      dosage: '1 capsule',
      time: const TimeOfDay(hour: 9, minute: 0),
      // Hanya untuk besok
      appliesToDate: DateTime.now().add(const Duration(days: 1)),
    ),
  ];

  // --- GETTERS (Agar View bisa 'membaca' state) ---

  DateTime get selectedDate => _selectedDate;
  bool get isCalendarOpen => _isCalendarOpen;

  // Ini adalah LOGIKA BISNIS:
  // Mengambil daftar obat yang sesuai dengan tanggal yang dipilih
  List<MedicationSchedule> get medsForSelectedDay {
    return _allSchedules
        .where((schedule) =>
            _isSameDay(schedule.appliesToDate, _selectedDate))
        .toList();
  }

  // --- ACTIONS (Fungsi yang dipanggil oleh View) ---

  // Dipanggil saat user memilih tanggal di kalender
  void selectDate(DateTime newDate) {
    _selectedDate = newDate;
    _isCalendarOpen = false; // Otomatis tutup kalender
    notifyListeners(); // Beri tahu View untuk update
  }

  // Dipanggil saat user memilih "Today"
  void selectToday() {
    _selectedDate = DateTime.now();
    _isCalendarOpen = false;
    notifyListeners();
  }

  // Dipanggil saat user memilih "Tomorrow"
  void selectTomorrow() {
    _selectedDate = DateTime.now().add(const Duration(days: 1));
    _isCalendarOpen = false;
    notifyListeners();
  }

  // Dipanggil saat user menekan icon kalender
  void toggleCalendar() {
    _isCalendarOpen = !_isCalendarOpen;
    notifyListeners();
  }

  // --- PRIVATE HELPER ---
  
  // Fungsi bantuan untuk membandingkan tanggal (tanpa jam/menit)
  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}