import 'package:flutter/material.dart';

class KetibAppcolors {
  // Lấy từ HTML: "primary": "#2b6cee"
  static const Color primary = Color(0xFF2B6CEE); 
  static const Color primaryDark = Color(0xFF1A4FB8); // hover state

  // Lấy từ HTML: "background-light": "#f6f6f8"
  static const Color background = Color(0xFFF6F6F8);

  // Màu chữ
  // Lấy từ HTML: text-gray-900 (gần đúng với #111827)
  static const Color textMain = Color(0xFF111827); 
  // Lấy từ HTML: text-gray-500 (gần đúng với #6B7280)
  static const Color textLight = Color(0xFF6B7280); 

  // Màu Input
  // Lấy từ HTML: "surface-light": "#ffffff"
  static const Color inputBackground = Color(0xFFFFFFFF);
  // Lấy từ HTML: "border-light": "#e2e8f0"
  static const Color inputBorder = Color(0xFFE2E8F0);
  
  // Màu Tag "NGƯỜI THUÊ"
  // HTML dùng bg-blue-100 (#DBEAFE) và text-primary (#2B6CEE)
  static const Color tagBackground = Color(0xFFDBEAFE); 
  static const Color tagText = Color(0xFF2B6CEE);

  // Màu Surface (Nền của các Card/Khung trắng)
  static const Color surface = Color(0xFFFFFFFF);
  
  // Màu Icon/Text phụ
  static const Color iconPrimary = Color(0xFF2B6CEE); // Icon xanh chủ đạo
  static const Color iconSecondary = Color(0xFF9CA3AF); // Icon xám (Location, v.v.)
  
  // Màu trạng thái (Tag "Đang thuê", "Mới đăng")
  static const Color success = Color(0xFF22C55E); // Màu xanh lá
  static const Color error = Color(0xFFEF4444);   // Màu đỏ (yêu thích)
}