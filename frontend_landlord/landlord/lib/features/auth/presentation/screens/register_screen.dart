import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RegisterLandlordScreen(),
  ));
}

class RegisterLandlordScreen extends StatefulWidget {
  const RegisterLandlordScreen({super.key});

  @override
  State<RegisterLandlordScreen> createState() => _RegisterLandlordScreenState();
}

class _RegisterLandlordScreenState extends State<RegisterLandlordScreen> {
  // Biến trạng thái
  bool _isPasswordVisible = false;
  bool _isAgreed = false;

  // Màu sắc chủ đạo (Lấy từ ảnh mẫu)
  final Color primaryColor = const Color(0xFF2B6CEE);
  final Color backgroundColor = const Color(0xFFF6F6F8);
  final Color textDark = const Color(0xFF101622);
  final Color textGrey = const Color(0xFF64748B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      // AppBar đơn giản
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textDark),
          onPressed: () {
            // Xử lý quay lại
          },
        ),
        title: Text(
          "Đăng ký đối tác",
          style: TextStyle(
              color: textDark, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HERO SECTION ---
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(Icons.real_estate_agent_rounded,
                  color: primaryColor, size: 30),
            ),
            const SizedBox(height: 16),
            Text(
              "Đăng ký làm chủ trọ",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: textDark,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Quản lý phòng trọ hiệu quả & Tìm kiếm khách thuê nhanh chóng cùng hệ thống của chúng tôi.",
              style: TextStyle(fontSize: 15, color: textGrey, height: 1.5),
            ),
            const SizedBox(height: 32),

            // --- FORM FIELDS ---
            _buildTextField(
              label: "Tên chủ trọ",
              hint: "Nguyễn Văn A",
              icon: Icons.person_outline_rounded,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              label: "Số điện thoại",
              hint: "0912 345 678",
              icon: Icons.phone_android_rounded,
              inputType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              label: "Email",
              hint: "example@email.com",
              icon: Icons.mail_outline_rounded,
              inputType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            // Mật khẩu
            _buildTextField(
              label: "Mật khẩu",
              hint: "••••••••",
              icon: Icons.lock_outline_rounded,
              isPassword: true,
              isVisible: _isPasswordVisible,
              onVisibilityToggle: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            const SizedBox(height: 20),
            // Xác nhận mật khẩu (Không cần nút toggle cho ô này theo thiết kế, nhưng có thể thêm nếu muốn)
            _buildTextField(
              label: "Xác nhận mật khẩu",
              hint: "••••••••",
              icon: Icons.lock_reset_rounded,
              isPassword: true,
              isVisible: true, // Luôn ẩn (true ở đây nghĩa là obscureText = true)
            ),
            const SizedBox(height: 20),
            // Mã số thuế (Có badge Tùy chọn)
            _buildTextField(
              label: "Mã số thuế / Doanh nghiệp",
              isOptional: true,
              hint: "Nhập mã số thuế (nếu có)",
              icon: Icons.domain_rounded,
            ),

            // --- CHECKBOX TERMS ---
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    value: _isAgreed,
                    activeColor: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                    onChanged: (value) {
                      setState(() {
                        _isAgreed = value ?? false;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 13.5, color: textGrey, height: 1.4),
                      children: [
                        const TextSpan(text: "Tôi đồng ý với "),
                        TextSpan(
                          text: "Điều khoản sử dụng",
                          style: TextStyle(
                              color: primaryColor, fontWeight: FontWeight.w600),
                        ),
                        const TextSpan(text: " và "),
                        TextSpan(
                          text: "Chính sách bảo mật",
                          style: TextStyle(
                              color: primaryColor, fontWeight: FontWeight.w600),
                        ),
                        const TextSpan(text: " dành cho đối tác."),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // --- BUTTON ---
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shadowColor: primaryColor.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Đăng ký ngay",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // --- FOOTER ---
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Bạn đã có tài khoản? ",
                    style: TextStyle(color: textGrey)),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Đăng nhập",
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40), // Safe area bottom
          ],
        ),
      ),
    );
  }

  // --- REUSABLE WIDGET: TEXT FIELD ---
  // Hàm này giúp tạo ra các ô nhập liệu giống nhau mà không cần viết lại code
  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool isVisible = false,
    bool isOptional = false,
    TextInputType inputType = TextInputType.text,
    VoidCallback? onVisibilityToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label Row
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w500, color: textDark),
            ),
            if (isOptional) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  "Tùy chọn",
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
              )
            ]
          ],
        ),
        const SizedBox(height: 8),
        // Input Field
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: TextField(
            obscureText: isPassword && !isVisible,
            keyboardType: inputType,
            style: TextStyle(color: textDark),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400),
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              prefixIcon: Icon(icon, color: Colors.grey.shade400),
              suffixIcon: isPassword && onVisibilityToggle != null
                  ? IconButton(
                      icon: Icon(
                        isVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.grey.shade400,
                      ),
                      onPressed: onVisibilityToggle,
                    )
                  : null,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: primaryColor, width: 1.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}