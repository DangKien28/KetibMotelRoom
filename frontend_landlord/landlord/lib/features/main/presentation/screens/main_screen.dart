import 'package:flutter/material.dart';
import 'package:landlord/features/individual/presentation/screens/individual_screen.dart';
import 'package:landlord/features/message/presentation/screens/message_screen.dart';
// Lưu ý: Các import dưới đây giả định bạn sẽ tạo các tệp này tương tự bên renter
import '../../../room_management/presentation/screens/room_management_screen.dart';
// import '../../../individual/presentation/screens/individual_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Danh sách các màn hình chính cho chủ trọ
  final List<Widget> _pages = [    // Tab 0: Tổng quan
    const ManageRoomsScreen(),         // Tab 1: Danh sách phòng
    const MessageScreen(),    // Tab 2: Chat với khách
    const IndividualScreen(),     // Tab 3: Hồ sơ chủ trọ
  ];

  void _onItemTapped(int index)
  {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF2B6CEE), // primary color
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.meeting_room_rounded), label: "Quản lý"),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: "Tin nhắn"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Cá nhân"),
        ],
      ),
    );
  }
}