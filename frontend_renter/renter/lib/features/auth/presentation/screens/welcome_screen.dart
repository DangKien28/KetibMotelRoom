import 'package:flutter/gestures.dart'; // Cần import thư viện này để bắt sự kiện bấm vào chữ
import 'package:flutter/material.dart';
import '../../../../core/constants/ketib_AppColors.dart';
import '../../../../core/widgets/ketib_button.dart';
// import 'login_screen.dart';
import 'register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: KetibAppcolors.background,
      body: SafeArea(
        child: Column(
          children: [
            // --- PHẦN 1: NỘI DUNG CHÍNH ---
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    
                    // 1. LOGO
                    Container(
                      height: size.height * 0.30,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/logo_TK.png',
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 2. TIÊU ĐỀ
                    const Text(
                      "Chào mừng đến với", 
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: KetibAppcolors.textMain,
                        fontFamily: 'Manrope',
                      ),
                    ),

                    const Text(
                      "Ketib Renter", 
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: KetibAppcolors.primary,
                        fontFamily: 'Manrope',
                      ),
                    ),
                    
                    const SizedBox(height: 12),

                    // 3. MÔ TẢ
                    const Text(
                      "Giải pháp tìm phòng trọ và ký hợ đồng điện tử minh bạch, an toàn và nhanh chóng nhất hiện nay.", 
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: KetibAppcolors.textLight,
                        height: 1.5,
                        fontFamily: 'Manrope',
                      ),
                    ),

                    const SizedBox(height: 32),

                    // 4. TÍNH NĂNG
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildFeatureItem(
                          icon: Icons.verified_user_outlined,
                          label: "An toàn\ntuyệt đối", 
                        ),
                        _buildFeatureItem(
                          icon: Icons.search,
                          label: "Tìm kiếm\nnhanh",
                        ),
                        _buildFeatureItem(
                          icon: Icons.history_edu,
                          label: "Hợp đồng\nOnline",
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // --- PHẦN 2: BUTTONS & ĐIỀU KHOẢN ---
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Nút Đăng ký
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: KetibButton(
                      text: "Bắt đầu - Đăng ký",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RegisterScreen()),
                        );
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 12),

                  // Nút Đăng nhập
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RegisterScreen()),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFF1F5F9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Đăng nhập",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: KetibAppcolors.textMain,
                          fontFamily: 'Manrope',
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // --- SỬA ĐỔI: RICH TEXT (CHỮ THƯỜNG + LINK) ---
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      // Style mặc định cho cả dòng (chữ thường)
                      style: const TextStyle(
                        fontSize: 12,
                        color: KetibAppcolors.textLight, // Màu xám (#6B7280)
                        fontFamily: 'Manrope',
                      ),
                      children: [
                        const TextSpan(
                          text: "Bằng việc tiếp tục, bạn đồng ý với ",
                        ),
                        TextSpan(
                          text: "điều khoản dịch vụ",
                          style: const TextStyle(
                            color: KetibAppcolors.primary, // Màu xanh (#2B6CEE) để báo hiệu là Link
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline, // Gạch chân (tùy chọn)
                          ),
                          // Sự kiện bấm vào chữ
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Điều hướng đến màn hình Điều khoản (được tạo tạm ở dưới)
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TermsOfServiceScreen(),
                                ),
                              );
                            },
                        ),
                      ],
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

  Widget _buildFeatureItem({required IconData icon, required String label}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          color: KetibAppcolors.primary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: KetibAppcolors.primary.withOpacity(0.1),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: KetibAppcolors.primary,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: KetibAppcolors.textMain,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- MÀN HÌNH TRỐNG: ĐIỀU KHOẢN DỊCH VỤ (Tạo tạm để test link) ---
class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Điều khoản dịch vụ"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: const Center(
        child: Text("Nội dung điều khoản sẽ hiển thị ở đây"),
      ),
    );
  }
}