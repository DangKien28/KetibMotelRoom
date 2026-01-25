import 'package:flutter/material.dart';
import '../../core/constants/ketib_AppColors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: KetibAppcolors.primary,
      scaffoldBackgroundColor: KetibAppcolors.background,
      fontFamily: 'Roboto', // Font mặc định, có thể đổi thành 'Plus Jakarta Sans' nếu đã thêm font
      
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent, // HTML: bg-background-light/95 backdrop-blur
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: KetibAppcolors.textMain),
        titleTextStyle: TextStyle(
          color: KetibAppcolors.textMain,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      
      // Cấu hình Input theo HTML: h-14 (56px), rounded-2xl (16px)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: KetibAppcolors.inputBackground,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20), // Padding rộng hơn chút để text không sát
        hintStyle: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.normal),
        
        // Border mặc định
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16), // rounded-2xl
          borderSide: const BorderSide(color: KetibAppcolors.inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: KetibAppcolors.inputBorder),
        ),
        // Khi focus: focus:border-primary focus:ring-4
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: KetibAppcolors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}