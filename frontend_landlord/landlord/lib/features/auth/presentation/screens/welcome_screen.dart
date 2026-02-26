import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import '../../../../core/constants/ketib_AppColors.dart';
import '../../../../core/widgets/ketib_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KetibAppcolors.background, // Sử dụng màu nền từ hằng số
      body: SafeArea(
        child: Column(
          children: [
            // Nội dung chính có thể cuộn
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Top App Bar - Mô phỏng header trong code.html
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: KetibAppcolors.primary.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.apartment, color: KetibAppcolors.primary),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Renter",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800, // Đã sửa từ extrabold thành w800
                              color: KetibAppcolors.textMain,
                              fontFamily: 'Manrope',
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Hero Section - Hình ảnh và tiêu đề chính
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        height: 380,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                            image: NetworkImage("https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?q=80&w=2070&auto=format&fit=crop"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                            ),
                          ),
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: KetibAppcolors.primary.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.verified, color: Colors.white, size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      "An tâm tuyệt đối", 
                                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Tìm phòng ưng ý,\nKý kết trong tích tắc",
                                style: TextStyle(
                                  color: Colors.white, 
                                  fontSize: 24, 
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Manrope',
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Pagination Dots
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(width: 24, height: 6, decoration: BoxDecoration(color: KetibAppcolors.primary, borderRadius: BorderRadius.circular(3))),
                                  const SizedBox(width: 4),
                                  Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.white.withOpacity(0.4), shape: BoxShape.circle)),
                                  const SizedBox(width: 4),
                                  Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.white.withOpacity(0.4), shape: BoxShape.circle)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Headline Text
                    const Padding(
                      padding: EdgeInsets.only(top: 32, bottom: 8),
                      child: Text.rich(
                        TextSpan(
                          text: "Chào mừng đến với ",
                          children: [
                            TextSpan(text: "Renter", style: TextStyle(color: KetibAppcolors.primary)),
                          ],
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32, 
                          fontWeight: FontWeight.w800, // Đã sửa thành w800
                          color: KetibAppcolors.textMain,
                          fontFamily: 'Manrope',
                        ),
                      ),
                    ),

                    // Body Text
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        "Giải pháp tìm phòng trọ và ký hợp đồng điện tử minh bạch, an toàn và nhanh chóng nhất hiện nay.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16, 
                          color: KetibAppcolors.textLight, 
                          height: 1.5,
                          fontFamily: 'Manrope',
                        ),
                      ),
                    ),

                    // Features Grid
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        children: [
                          _buildFeatureBox(Icons.search, "Tìm kiếm nhanh"),
                          const SizedBox(width: 16),
                          _buildFeatureBox(Icons.history_edu, "Hợp đồng Online"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Nhóm nút bấm cố định ở dưới
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade100)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Nút Đăng ký sử dụng KetibButton tùy chỉnh
                  KetibButton(
                    text: "Bắt đầu - Đăng ký",
                    icon: Icons.arrow_forward,
                    onPressed: () => Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (_) => const RegisterLandlordScreen())
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Nút Đăng nhập
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFF1F5F9),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () => Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (_) => const LandlordLoginScreen())
                      ),
                      child: const Text(
                        "Đăng nhập", 
                        style: TextStyle(
                          color: KetibAppcolors.textMain, 
                          fontSize: 18, 
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Manrope',
                        )
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Điều khoản dịch vụ
                  Text.rich(
                    TextSpan(
                      text: "Bằng việc tiếp tục, bạn đồng ý với ",
                      style: const TextStyle(fontSize: 12, color: KetibAppcolors.textLight, fontFamily: 'Manrope'),
                      children: [
                        TextSpan(
                          text: "Điều khoản dịch vụ",
                          style: const TextStyle(
                            color: KetibAppcolors.primary, 
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            // Xử lý khi bấm vào điều khoản
                          },
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget phụ cho các hộp tính năng
  Widget _buildFeatureBox(IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: KetibAppcolors.primary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: KetibAppcolors.primary.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Icon(icon, color: KetibAppcolors.primary, size: 32),
            const SizedBox(height: 8),
            Text(
              label, 
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 14,
                fontFamily: 'Manrope',
              )
            ),
          ],
        ),
      ),
    );
  }
}