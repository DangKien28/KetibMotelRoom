import 'package:flutter/material.dart';

// Hàm main để chạy thử giao diện này độc lập
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LandlordLoginScreen(),
  ));
}

class LandlordLoginScreen extends StatefulWidget {
  const LandlordLoginScreen({super.key});

  @override
  State<LandlordLoginScreen> createState() => _LandlordLoginScreenState();
}

class _LandlordLoginScreenState extends State<LandlordLoginScreen> {
  // Trạng thái hiển thị mật khẩu
  bool _isPasswordVisible = false;

  // Định nghĩa màu sắc từ thiết kế
  final Color primaryColor = const Color(0xFF2B6CEE); // Màu xanh chủ đạo
  final Color backgroundColor = const Color(0xFFF6F6F8); // Màu nền xám nhạt
  final Color textDark = const Color(0xFF101622); // Màu chữ tiêu đề
  final Color textGrey = const Color(0xFF64748B); // Màu chữ phụ
  final Color borderColor = const Color(0xFFE2E8F0); // Màu viền nhạt

  // URL hình ảnh tòa nhà (Sử dụng ảnh mẫu từ Unsplash)
  final String imageUrl = "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?q=80&w=800&auto=format&fit=crop";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      // Sử dụng SafeArea để tránh tai thỏ/thanh trạng thái
      body: SafeArea(
        // Center và ConstrainedBox giúp giao diện đẹp trên cả máy tính bảng/web
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  // --- 1. Header Image ---
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // --- 2. Title & Subtitle ---
                  const SizedBox(height: 24),
                  Text(
                    "Chào mừng trở lại!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Dành cho người cho thuê.\nQuản lý phòng trọ của bạn dễ dàng hơn.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: textGrey,
                      height: 1.5,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(height: 32),

                  // --- 3. Login Form ---
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Email/Phone Input
                      _buildLabel("Email hoặc Số điện thoại"),
                      const SizedBox(height: 8),
                      _buildInputField(
                        hint: "nhadautu@example.com",
                        icon: Icons.mail_outline_rounded,
                        inputType: TextInputType.emailAddress,
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Password Input
                      _buildLabel("Mật khẩu"),
                      const SizedBox(height: 8),
                      _buildInputField(
                        hint: "••••••••",
                        icon: Icons.lock_outline_rounded,
                        isPassword: true,
                      ),

                      // Forgot Password Link
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            foregroundColor: primaryColor,
                          ),
                          child: const Text(
                            "Quên mật khẩu?",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // --- 4. Login Button ---
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 8,
                        shadowColor: primaryColor.withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Đăng nhập",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_rounded, size: 20),
                        ],
                      ),
                    ),
                  ),

                  // --- 5. Social Divider ---
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(child: Divider(color: borderColor)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "HOẶC ĐĂNG NHẬP VỚI",
                          style: TextStyle(
                            color: textGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: borderColor)),
                    ],
                  ),

                  // --- 6. Social Buttons ---
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSocialButton(
                          text: "Google",
                          icon: const Text("G", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.red)), // Demo Google Icon
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildSocialButton(
                          text: "Facebook",
                           icon: const Icon(Icons.facebook_rounded, color: Color(0xFF1877F2)),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),

                  // --- 7. Footer ---
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Bạn chưa có tài khoản? ",
                        style: TextStyle(color: textGrey, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Điều hướng đến trang Đăng ký
                        },
                        child: Text(
                          "Đăng ký ngay",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets (Để tái sử dụng code) ---

  // Widget nhãn (Label) phía trên input
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),
    );
  }

  // Widget ô nhập liệu (Input Field)
  Widget _buildInputField({
    required String hint,
    required IconData icon,
    bool isPassword = false,
    TextInputType inputType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: TextField(
        obscureText: isPassword && !_isPasswordVisible,
        keyboardType: inputType,
        style: TextStyle(color: textDark, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.normal),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          prefixIcon: Icon(icon, color: Colors.grey.shade400),
          // Thêm nút toggle nếu là ô mật khẩu
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    color: Colors.grey.shade400,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }

  // Widget nút đăng nhập xã hội (Google/Facebook)
  Widget _buildSocialButton({
    required String text,
    required Widget icon,
    required VoidCallback onTap,
  }) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: textDark,
        backgroundColor: Colors.white,
        side: BorderSide(color: borderColor),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ],
      ),
    );
  }
}