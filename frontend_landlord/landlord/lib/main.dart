import 'package:flutter/material.dart';
import 'package:landlord/features/auth/presentation/screens/welcome_screen.dart';
import 'package:landlord/features/main/presentation/screens/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LandlordApp());
}

class LandlordApp extends StatelessWidget {
  const LandlordApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ketib Landlord',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2B6CEE), // Màu xanh Primary giống Renter
          primary: const Color(0xFF2B6CEE),
        ),
        fontFamily: 'Manrope',
      ),
      home: const MainScreen(),
    );
  }
}