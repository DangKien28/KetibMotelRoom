import 'package:admin/features/main/presentation/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const KetibAdminApp());
}

class KetibAdminApp extends StatelessWidget {
  const KetibAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ketib Admin',
      debugShowCheckedModeBanner: false, // Ẩn chữ "DEBUG" ở góc phải màn hình
      theme: ThemeData(
        primaryColor: const Color(0xFF2B6CEE),
        scaffoldBackgroundColor: const Color(0xFFF6F6F8), // Màu nền chuẩn của hệ thống
        fontFamily: 'Roboto', // Bạn có thể đổi sang font bạn đang dùng (nếu có cấu hình trong pubspec.yaml)
        
        // Thiết lập giao diện mặc định cho AppBar toàn app
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black, 
            fontSize: 18, 
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // Đặt màn hình khởi chạy chính là AdminMainScreen
      home: const AdminMainScreen(), 
    );
  }
}