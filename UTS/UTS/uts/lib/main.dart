// Lokasi: lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal (e.g., "May 27")
import 'package:uts/medications_screen.dart';

import 'home_controller.dart';     // Impor Controller
import 'medication_model.dart'; // Impor Model

void main() {
  runApp(
    // 1. Sediakan Controller di level tertinggi
    ChangeNotifierProvider(
      create: (context) => HomeController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medication Reminder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue, // Sesuai gambar, biru tua
          elevation: 0,
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const MainAppShell(),
    );
  }
}

// Ini adalah "Rumah" utama aplikasi, berisi BottomNav dan FAB
class MainAppShell extends StatefulWidget {
  const MainAppShell({Key? key}) : super(key: key);

  @override
  State<MainAppShell> createState() => _MainAppShellState();
}

class _MainAppShellState extends State<MainAppShell> {
  int _selectedIndex = 0;

  // --- UPDATE 1: Tambahkan file medications_screen.dart ---
  // (Anda harus membuat file ini di Langkah 2)
  static const List<Widget> _pages = <Widget>[
    HomeScreen(), // Tab "Home"
    MedicationsScreen(), // <-- GANTI INI (dari placeholder)
    // Center(child: Text('List Page')),
    // Center(child: Text('Profile Page')),
  ];

  // --- UPDATE 2: Buat daftar judul untuk AppBar ---
  static const List<String> _pageTitles = [
    'Home',
    'Medicines'
    // 'List',
    // 'Profile'
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showAddMedicineSheet(BuildContext context) {
    // ... (Fungsi ini tidak berubah, biarkan saja)
  }

  @override
  Widget build(BuildContext context) {
    // --- UPDATE 3: Cek apakah kita di HomePage ---
    final bool isHomePage = _selectedIndex == 0;

    return Scaffold(
      resizeToAvoidBottomInset: false,

      // --- UPDATE 4: AppBar dinamis ---
      appBar: AppBar(
        title: Text(_pageTitles[_selectedIndex]), // Judul dinamis
        backgroundColor: const Color(0xFF003D80), // Biru tua
        elevation: 0,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      
      body: _pages.elementAt(_selectedIndex),

      // --- UPDATE 5: FAB dinamis (hanya tampil di Home) ---
      // floatingActionButton: isHomePage
      //     ? FloatingActionButton(
      //         onPressed: () {
      //           _showAddMedicineSheet(context);
      //         },
      //         child: const Icon(Icons.add),
      //         backgroundColor: const Color(0xFF003D80),
      //       )
      //     : null, // Sembunyikan FAB di halaman lain
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // --- UPDATE 6: BottomAppBar dinamis (shape berubah) ---
      bottomNavigationBar: BottomAppBar(
        shape: isHomePage
            ? const CircularNotchedRectangle() // "Bolong" saat di Home
            : null, // Rata/flat di halaman lain
        notchMargin: 8.0,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.medical_services_outlined),
              label: 'Medicines',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.list_alt),
            //   label: 'List',
            // ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.person_outline),
            //   label: 'Profile',
            // ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.blue[800],
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 13,
          unselectedFontSize: 13,
        ),
      ),
    );
  }
}

// class _MainAppShellState extends State<MainAppShell> {
//   int _selectedIndex = 0; // Mengatur tab mana yang aktif

//   // Nanti, ini bisa diisi dengan screen lain (Medications, List, Profile)
//   static const List<Widget> _pages = <Widget>[
//     HomeScreen(), // Tab "Home"
//     Center(child: Text('Medications Page')), // Tab "Medications"
//     Center(child: Text('List Page')),       // Tab "List"
//     Center(child: Text('Profile Page')),     // Tab "Profile"
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   // Fungsi untuk menampilkan BottomSheet (seperti di gambar terakhir)
//   void _showAddMedicineSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true, // Agar bisa set tinggi
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return Container(
//           padding: const EdgeInsets.all(24),
//           // Set tinggi 30% layar
//           height: MediaQuery.of(context).size.height * 0.3, 
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Add Medicine',
//                 style: Theme.of(context).textTheme.headlineSmall,
//               ),
//               const SizedBox(height: 10),
//               const Text('Set reminders and more'),
//               const Spacer(),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: const Size(double.infinity, 50),
//                 ),
//                 onPressed: () {
//                   Navigator.pop(context); // Tutup sheet
//                 },
//                 child: const Text('Continue'),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // AppBar hanya muncul di halaman Home (sesuai gambar)
//       appBar: _selectedIndex == 0
//           ? AppBar(
//               title: const Text('Home'),
//               backgroundColor: const Color(0xFF003D80), // Biru tua
//             )
//           : null,
      
//       body: _pages.elementAt(_selectedIndex),

//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _showAddMedicineSheet(context);
//         },
//         child: const Icon(Icons.add),
//         backgroundColor: const Color(0xFF003D80), // Biru tua
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(), // Bentuk "bolong"
//         child: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed, // Selalu tampilkan label
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.medical_services_outlined),
//               label: 'Medications',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.list_alt),
//               label: 'List',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person_outline),
//               label: 'Profile',
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           onTap: _onItemTapped,
//           selectedItemColor: Colors.blue[800],
//           unselectedItemColor: Colors.grey,
//           showSelectedLabels: true,
//           showUnselectedLabels: true,

//           selectedFontSize: 13,
//           unselectedFontSize: 13,
//         ),
//       ),
//     );
//   }
// }

// --- Halaman HOME ---
// Ini adalah isi dari Tab "Home"
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 2. Gunakan Consumer untuk 'mendengarkan' perubahan dari Controller
    return Consumer<HomeController>(
      builder: (context, controller, child) {
        return Column(
          children: [
            // 3. Widget untuk "Today", "Tomorrow", dan Kalender
            _DateSelector(controller: controller),
            
            // 4. Tampilkan Kalender jika isCalendarOpen == true
            if (controller.isCalendarOpen)
              _CalendarView(controller: controller),

            // 5. Tampilkan daftar obat
            // Expanded agar list mengisi sisa ruang
            Expanded(
              child: _MedicationList(controller: controller),
            ),
          ],
        );
      },
    );
  }
}

// Widget untuk Baris Pilihan Tanggal
class _DateSelector extends StatelessWidget {
  final HomeController controller;
  const _DateSelector({Key? key, required this.controller}) : super(key: key);

  // Helper untuk cek tanggal
  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final tomorrow = today.add(const Duration(days: 1));

    final bool isTodaySelected = _isSameDay(controller.selectedDate, today);
    final bool isTomorrowSelected = _isSameDay(controller.selectedDate, tomorrow);
    
    // Tentukan teks untuk tombol ketiga
    String dateButtonText = 'Select Date';
    if (!isTodaySelected && !isTomorrowSelected) {
      dateButtonText = DateFormat('d MMM').format(controller.selectedDate);
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Tombol "Today"
          _DateButton(
            text: 'Today',
            isSelected: isTodaySelected,
            onPressed: () => controller.selectToday(),
          ),
          // Tombol "Tomorrow"
          _DateButton(
            text: 'Tomorrow',
            isSelected: isTomorrowSelected,
            onPressed: () => controller.selectTomorrow(),
          ),
          // Tombol Icon Kalender
          _DateButton(
            text: dateButtonText,
            isSelected: !isTodaySelected && !isTomorrowSelected,
            icon: Icons.calendar_today_outlined,
            onPressed: () => controller.toggleCalendar(),
          ),
        ],
      ),
    );
  }
}

// Button kustom untuk _DateSelector
class _DateButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final IconData? icon;
  final VoidCallback onPressed;

  const _DateButton({
    Key? key,
    required this.text,
    required this.isSelected,
    this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color activeColor = Colors.blue.shade700;
    final Color inactiveColor = Colors.grey.shade600;

    return OutlinedButton.icon(
      icon: icon != null
          ? Icon(icon,
              size: 16, color: isSelected ? activeColor : inactiveColor)
          : const SizedBox.shrink(),
      label: Text(text,
          style: TextStyle(
              color: isSelected ? activeColor : inactiveColor,
              fontWeight:
                  isSelected ? FontWeight.bold : FontWeight.normal)),
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
            color: isSelected ? activeColor : Colors.grey.shade300),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

// Widget untuk Kalender (menggunakan table_calendar)
class _CalendarView extends StatelessWidget {
  final HomeController controller;
  const _CalendarView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: controller.selectedDate, // Hari yang di-fokus
        selectedDayPredicate: (day) {
          // Memberi tanda hari mana yang dipilih
          return isSameDay(controller.selectedDate, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          // 6. Panggil Aksi di Controller saat user memilih tanggal
          controller.selectDate(selectedDay);
        },
        calendarStyle: const CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: Color(0xFF003D80), // Biru tua
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: Colors.blueAccent,
            shape: BoxShape.circle,
          ),
        ),
        headerStyle: const HeaderStyle(
          formatButtonVisible: false, // Sembunyikan tombol "2 weeks"
          titleCentered: true,
        ),
      ),
    );
  }
}

// Widget untuk menampilkan daftar obat atau "Empty State"
class _MedicationList extends StatelessWidget {
  final HomeController controller;
  const _MedicationList({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ambil daftar obat dari controller
    final List<MedicationSchedule> meds = controller.medsForSelectedDay;

    // Tampilan jika tidak ada obat
    if (meds.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment_turned_in_outlined,
              size: 100,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            const Text(
              'No medicines',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Text(
              'Click + to add medicine.',
              style: TextStyle(fontSize: 16, color: Colors.grey[400]),
            ),
          ],
        ),
      );
    }

    // Tampilan jika ADA obat
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: meds.length,
      itemBuilder: (context, index) {
        final med = meds[index];
        return Card(
          child: ListTile(
            leading: const Icon(Icons.medication_liquid, color: Colors.blue),
            title: Text(med.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(med.dosage),
            trailing: Text(
              med.time.format(context), // Format jam (e.g., "8:00 AM")
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF003D80)),
            ),
          ),
        );
      },
    );
  }
}