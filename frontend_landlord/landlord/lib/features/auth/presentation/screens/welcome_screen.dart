import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  // Định nghĩa màu sắc trực tiếp nếu chưa có file constants riêng
  static const Color primaryColor = Color(0xFF2B6CEE);
  static const Color textMain = Color(0xFF1E293B);
  static const Color textLight = Color(0xFF64748B);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    // 1. LOGO (Sử dụng chung asset hoặc thay bằng logo chủ trọ nếu có)
                    Container(
                      height: size.height * 0.25,
                      alignment: Alignment.center,
                      child: const Icon(Icons.maps_home_work_outlined, size: 100, color: primaryColor),
                      // Sau này thay bằng: Image.asset('assets/images/logo_landlord.png')
                    ),
                    const SizedBox(height: 32),

                    // 2. TIÊU ĐỀ
                    const Text(
                      "Quản lý hiệu quả với",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: textMain),
                    ),
                    const Text(
                      "Ketib Landlord",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: primaryColor),
                    ),
                    const SizedBox(height: 16),

                    // 3. MÔ TẢ
                    const Text(
                      "Đăng tin cho thuê, quản lý khách thuê và ký hợp đồng số chỉ trong vài thao tác.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: textLight, height: 1.5),
                    ),
                    const SizedBox(height: 40),

                    // 4. TÍNH NĂNG CHO CHỦ TRỌ
                    Row(
                      children: [
                        _buildFeature(Icons.add_business, "Đăng tin\ndễ dàng"),
                        _buildFeature(Icons.people_alt, "Quản lý\nkhách thuê"),
                        _buildFeature(Icons.assignment_turned_in, "Hợp đồng\nan toàn"),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // 5. NÚT BẤM
            Container(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {}, // Điều hướng đến Register sau này
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Bắt đầu ngay", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: TextButton(
                      onPressed: () {}, // Điều hướng đến Login sau này
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFF1F5F9),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Đăng nhập", style: TextStyle(color: textMain, fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(IconData icon, String label) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: primaryColor, size: 32),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: textMain)),
        ],
      ),
    );
  }
}