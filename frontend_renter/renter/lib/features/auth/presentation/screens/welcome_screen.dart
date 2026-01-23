import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  // Định nghĩa màu sắc từ HTML config
  static const Color primaryColor = Color(0xFF2B6CEE);
  static const Color backgroundColor = Colors.white;
  static const Color textDark = Color(0xFF101622);
  static const Color textGrey = Color(0xFF64748B);
  static const Color backgroundLight = Color(0xFFF6F6F8);

  @override
  Widget build(BuildContext context) {
    // Sử dụng SafeArea để tránh tai thỏ/camera
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // --- 1. Top Bar ---
                _buildTopBar(),
                
                const SizedBox(height: 24),

                // --- 2. Hero Image Section ---
                _buildHeroSection(context),

                const SizedBox(height: 32),

                // --- 3. Headline Text ---
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.manrope(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: textDark,
                      height: 1.2,
                    ),
                    children: const [
                      TextSpan(text: 'Chào mừng đến với\n'),
                      TextSpan(
                        text: 'Renter',
                        style: TextStyle(color: primaryColor),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // --- 4. Subtitle Text ---
                Text(
                  'Giải pháp tìm phòng trọ và ký hợp đồng điện tử minh bạch, an toàn và nhanh chóng nhất hiện nay.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: textGrey,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 32),

                // --- 5. Features Grid ---
                Row(
                  children: [
                    Expanded(
                      child: _buildFeatureCard(
                        icon: Icons.manage_search_rounded, // search_check
                        label: 'Tìm kiếm nhanh',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildFeatureCard(
                        icon: Icons.edit_document, // history_edu
                        label: 'Hợp đồng Online',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // --- 6. Action Buttons ---
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Xử lý sự kiện đăng ký
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      shadowColor: primaryColor.withOpacity(0.25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Bắt đầu - Đăng ký',
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward_rounded, size: 20),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Xử lý sự kiện đăng nhập
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: backgroundLight,
                      foregroundColor: textDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Đăng nhập',
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // --- 7. Terms Link ---
                GestureDetector(
                  onTap: () {
                    // TODO: Mở điều khoản
                  },
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        color: textGrey.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                      ),
                      children: const [
                        TextSpan(text: 'Bằng việc tiếp tục, bạn đồng ý với '),
                        TextSpan(
                          text: 'Điều khoản dịch vụ',
                          style: TextStyle(
                            color: primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget: Top Bar (Logo + Tên App)
  Widget _buildTopBar() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Icon bên trái
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.apartment_rounded,
              color: primaryColor,
              size: 24,
            ),
          ),
        ),
        // Chữ ở giữa
        Text(
          'Renter',
          style: GoogleFonts.manrope(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: textDark,
          ),
        ),
      ],
    );
  }

  // Widget: Hero Section (Ảnh lớn + Overlay text)
  Widget _buildHeroSection(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Ảnh nền (Dùng NetworkImage làm ví dụ, bạn có thể thay bằng AssetImage)
          Image.network(
            'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=2070&auto=format&fit=crop',
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(color: Colors.grey[200]);
            },
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[300],
              child: const Center(child: Icon(Icons.broken_image)),
            ),
          ),

          // 2. Lớp phủ Gradient đen mờ dần từ dưới lên
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.0),
                  Colors.black.withOpacity(0.8),
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
          ),

          // 3. Nội dung trên ảnh
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Badge "An tâm tuyệt đối"
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.verified_user_rounded, color: Colors.white, size: 14),
                      const SizedBox(width: 6),
                      Text(
                        'AN TÂM TUYỆT ĐỐI',
                        style: GoogleFonts.manrope(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                
                // Headline trên ảnh
                Text(
                  'Tìm phòng ưng ý,\nKý kết trong tích tắc',
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Pagination Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDot(isActive: true),
                    _buildDot(isActive: false),
                    _buildDot(isActive: false),
                    _buildDot(isActive: false),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper tạo Pagination Dot
  Widget _buildDot({required bool isActive}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: isActive ? primaryColor : Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  // Helper tạo Feature Card (ô vuông nhỏ)
  Widget _buildFeatureCard({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryColor.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Icon(icon, color: primaryColor, size: 32),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: textDark,
            ),
          ),
        ],
      ),
    );
  }
}