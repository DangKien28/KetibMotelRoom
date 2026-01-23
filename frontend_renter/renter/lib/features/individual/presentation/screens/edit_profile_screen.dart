import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // --- COLOR CONSTANTS ---
  static const Color kPrimaryColor = Color(0xFF2B6CEE);
  static const Color kBackgroundColor = Color(0xFFF6F6F8);
  static const Color kSurfaceColor = Colors.white;
  static const Color kTextPrimary = Color(0xFF0F172A);
  static const Color kTextSecondary = Color(0xFF64748B);
  static const Color kBorderColor = Color(0xFFCFD7E7);

  // State quản lý ẩn/hiện mật khẩu
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            _buildAvatarSection(),
            const SizedBox(height: 30),
            _buildForm(),
            // Khoảng trống dưới cùng để tránh bị nút che
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomButton(),
    );
  }

  // 1. App Bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: kTextPrimary),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        "Chỉnh sửa thông tin",
        style: TextStyle(
          color: kTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Plus Jakarta Sans',
        ),
      ),
    );
  }

  // 2. Avatar Change Section
  Widget _buildAvatarSection() {
    return Column(
      children: [
        Stack(
          children: [
            // Avatar Placeholder
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
                border: Border.all(color: kSurfaceColor, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.person, size: 60, color: Colors.white),
              // TODO: Thay bằng Image.network khi có dữ liệu
            ),
            
            // Camera Icon Badge
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: kSurfaceColor, width: 3),
                ),
                child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: () {
            // Logic đổi ảnh
          },
          child: const Text(
            "Đổi ảnh đại diện",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  // 3. Form Fields
  Widget _buildForm() {
    return Column(
      children: [
        _buildTextField(
          label: "Họ và tên",
          hintText: "Nhập họ và tên của bạn",
        ),
        const SizedBox(height: 20),
        _buildTextField(
          label: "Số điện thoại",
          hintText: "Nhập số điện thoại",
          prefixIcon: Icons.call,
          inputType: TextInputType.phone,
        ),
        const SizedBox(height: 20),
        _buildTextField(
          label: "Email",
          hintText: "Nhập địa chỉ email",
          prefixIcon: Icons.email,
          inputType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        _buildTextField(
          label: "Địa chỉ",
          hintText: "Nhập địa chỉ của bạn",
          prefixIcon: Icons.location_on,
          maxLines: 3, // Cho phép nhập nhiều dòng
        ),
        const SizedBox(height: 20),
        _buildTextField(
          label: "Mật khẩu",
          hintText: "********",
          prefixIcon: Icons.lock,
          isPassword: true,
        ),
      ],
    );
  }

  // Helper Widget: Input Field Generic
  Widget _buildTextField({
    required String label,
    required String hintText,
    IconData? prefixIcon,
    bool isPassword = false,
    int maxLines = 1,
    TextInputType inputType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: kTextPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Plus Jakarta Sans',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: kSurfaceColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: TextField(
            keyboardType: inputType,
            obscureText: isPassword ? _obscurePassword : false,
            maxLines: maxLines,
            style: const TextStyle(
              color: kTextPrimary,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              prefixIcon: prefixIcon != null 
                  ? Icon(prefixIcon, color: Colors.grey.shade500, size: 22) 
                  : null,
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey.shade400,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: kBorderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: kBorderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: kPrimaryColor, width: 1.5),
              ),
              filled: true,
              fillColor: kSurfaceColor,
            ),
          ),
        ),
      ],
    );
  }

  // 4. Bottom Button
  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(16).copyWith(
        bottom: MediaQuery.of(context).padding.bottom + 16
      ),
      decoration: BoxDecoration(
        color: kBackgroundColor,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            // Logic lưu thay đổi
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
            shadowColor: kPrimaryColor.withOpacity(0.4),
          ),
          child: const Text(
            "Lưu thay đổi",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Plus Jakarta Sans',
            ),
          ),
        ),
      ),
    );
  }
}