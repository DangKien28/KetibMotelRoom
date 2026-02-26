import 'package:flutter/material.dart';
import 'package:landlord/features/home/presentation/screens/home_screen.dart';
// Lưu ý: Các import dưới đây giả định bạn sẽ tạo các tệp này tương tự bên renter
// import '../../../manage/presentation/screens/manage_rooms_screen.dart';
// import '../../../message/presentation/screens/message_screen.dart';
// import '../../../individual/presentation/screens/individual_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Danh sách các màn hình chính cho chủ trọ
  final List<Widget> _pages = [
    const LandlordHomeScreen(),       // Tab 0: Tổng quan
    const Center(child: Text("Quản lý phòng")), // Tab 1: Danh sách phòng
    const Center(child: Text("Tin nhắn")),    // Tab 2: Chat với khách
    const Center(child: Text("Cá nhân")),     // Tab 3: Hồ sơ chủ trọ
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF2B6CEE), // primary color
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: "Tổng quan"),
          BottomNavigationBarItem(icon: Icon(Icons.meeting_room_rounded), label: "Phòng trọ"),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: "Tin nhắn"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Cá nhân"),
        ],
      ),
    );
  }
}