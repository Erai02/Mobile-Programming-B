// Lokasi: lib/medications_screen.dart

import 'package:flutter/material.dart';
import 'medication_detail_screen.dart';

class MedicationsScreen extends StatelessWidget {
  const MedicationsScreen({Key? key}) : super(key: key);

  // --- DUMMY DATA ---
  final List<Map<String, String>> activeMedicines = const [
    {'name': 'Atomoxetine', 'schedule': 'Today'},
    {'name': 'Clonidine', 'schedule': 'Today'},
    {'name': 'Guanfacine', 'schedule': 'Today'},
    {'name': 'Intuniv', 'schedule': 'Today'},
    {'name': 'Qelbree', 'schedule': 'Yesterday'},
    {'name': 'Scattera', 'schedule': 'Yesterday'},
  ];

  final List<Map<String, String>> inactiveMedicines = const [
    {'name': 'Dynavel XR', 'schedule': 'N/A'},
  ];
  // --------------------

  @override
  Widget build(BuildContext context) {
    // Kita gunakan `Container` putih agar seragam dengan `AppBar`
    // (atau `Scaffold` tanpa `AppBar` jika Anda mau)
    return Container(
      color: Colors.white, // Background putih seperti di gambar
      child: Column(
        children: [
          // 1. Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search your medicines',
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none, // Tidak ada border
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 0), // Padding vertikal
              ),
            ),
          ),
          
          // 2. Konten List (buat scrollable)
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                // 3. Section: Active Medicines
                _SectionHeader(
                  title: 'Active Medicines',
                  count: activeMedicines.length,
                  showAddButton: false,
                ),
                const SizedBox(height: 8),
                
                // 4. List Active Medicines
                ...activeMedicines.map((med) {
                  return _MedicationCard(
                    name: med['name']!,
                    schedule: med['schedule']!,
                  );
                }),

                const SizedBox(height: 24), // Jarak antar section

                // 5. Section: InActive Medicines
                _SectionHeader(
                  title: 'InActive Medicines',
                  showAddButton: true,
                  onAddPressed: () {
                    // Di sini Anda bisa memanggil
                    // BottomSheet atau halaman baru
                    print('Add Inactive Medicine Tapped');
                  },
                ),
                const SizedBox(height: 8),

                // 6. List InActive Medicines
                ...inactiveMedicines.map((med) {
                  return _MedicationCard(
                    name: med['name']!,
                    schedule: med['schedule']!,
                    isActive: false, // Set false agar ikonnya abu-abu
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Helper Widget untuk Judul Section (Active/Inactive)
class _SectionHeader extends StatelessWidget {
  final String title;
  final int? count;
  final bool showAddButton;
  final VoidCallback? onAddPressed;

  const _SectionHeader({
    Key? key,
    required this.title,
    this.count,
    this.showAddButton = false,
    this.onAddPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            if (count != null)
              Text(
                '   Total: $count',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black45,
                ),
              ),
          ],
        ),
        if (showAddButton)
          CircleAvatar(
            radius: 16,
            // Warna ungu dari gambar
            backgroundColor: const Color(0xFF4A00E0), 
            child: IconButton(
              iconSize: 16,
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: onAddPressed,
            ),
          ),
      ],
    );
  }
}

// Lokasi: lib/medications_screen.dart
// Ganti widget _MedicationCard dengan yang ini:

// Helper Widget untuk Kartu Obat
class _MedicationCard extends StatelessWidget {
  final String name;
  final String schedule;
  final bool isActive;

  const _MedicationCard({
    Key? key,
    required this.name,
    required this.schedule,
    this.isActive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Tentukan warna berdasarkan status aktif/inaktif
    final Color pillColor = isActive ? const Color(0xFF4A00E0) : Colors.grey;
    final Color textColor = isActive ? Colors.black87 : Colors.grey;

    // --- UPDATE: BUNGKUS DENGAN INKWELL ---
    return InkWell(
      onTap: () {
        // Inilah aksi navigasi saat card diklik
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MedicationDetailScreen(
              medicationName: name,
              schedule: schedule,
              isActive: isActive,
            ),
          ),
        );
      },
      // Beri sedikit radius agar efek kliknya rounded
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          // Beri border tipis
          side: BorderSide(color: Colors.grey[200]!),
        ),
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Ikon pil
              Icon(Icons.medication, color: pillColor, size: 20),
              const SizedBox(width: 12),
              // Nama obat
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
              const Spacer(), // Dorong ke kanan
              // Jadwal
              Text(
                schedule,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}