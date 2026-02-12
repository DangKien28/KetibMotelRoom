import 'package:flutter/material.dart';
import 'package:renter/features/individual/presentation/screens/individual_screen.dart';
import 'package:renter/features/message/presentation/screens/message_screen.dart';
// Import các màn hình con
import '../../../home/presentation/screens/home_screen.dart';
import '../../../saved_rooms/presentation/screens/saved_rooms_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Chỉ số tab hiện tại (0: Home, 1: Saved, 2: Message, 3: Profile)
  int _currentIndex = 0;

  // Danh sách các màn hình tương ứng với từng tab
  final List<Widget> _pages = [
    const HomeScreen(),      // Tab 0
    const SavedRoomsScreen(),// Tab 1
    const MessagesScreen(), // Tab 2
    const ProfileScreen(),  // Tab 3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Hiển thị màn hình tương ứng với index hiện tại
      // Dùng IndexedStack để giữ trạng thái của màn hình khi chuyển tab (không bị load lại)
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      
      // Thanh điều hướng dùng chung cho toàn bộ ứng dụng
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF2B6CEE),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Trang chủ"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Đã lưu"),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: "Tin nhắn"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Cá nhân"),
        ],
      ),
    );
  }
}