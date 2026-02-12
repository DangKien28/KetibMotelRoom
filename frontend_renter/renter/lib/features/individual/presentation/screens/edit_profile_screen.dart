import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Controllers để quản lý dữ liệu nhập vào
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _passwordController;

  bool _obscurePassword = true; // Trạng thái ẩn/hiện mật khẩu

  @override
  void initState() {
    super.initState();
    // Khởi tạo giá trị mặc định (giả lập dữ liệu hiện tại của user)
    _nameController = TextEditingController(text: "Nguyễn Văn A");
    _phoneController = TextEditingController(text: "0912 345 678");
    _emailController = TextEditingController(text: "nguyenvan.a@example.com");
    _addressController = TextEditingController(text: "123 Đường Lê Lợi, Quận 1, TP. Hồ Chí Minh");
    _passwordController = TextEditingController(text: "password123");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8), // background-light
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  _buildAvatarSection(),
                  const SizedBox(height: 32),
                  _buildForm(),
                ],
              ),
            ),
          ),
          _buildBottomAction(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFF6F6F8),
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        "Chỉnh sửa thông tin",
        style: TextStyle(
          color: Color(0xFF0D121B),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 56, // Size lớn như thiết kế
                backgroundImage: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuActuspTvAuUiZQf0Ta0Aen6klFM1SrSDzGRhSjcDDewLGch6j3rqdD6_UtpmTQNeNE2bRv3wdNbDgPjRNyn2rMkq4oVxa6-xml6wloFJsrFJedO1YWVa3_semyFRCbFaQxKPfoYkS78S17kgEHE2vBLe7ZYYvRzEDiub4eD-bcdWVw-shgrPRjh9tkyIsp9_RJRKUqs9Hh9J7DSwjJXD4avIupIIqdGngwULI6h5juBro8ViCepQTiKaUB5EDl69D5MInwIb3L46M"),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF2B6CEE),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFF6F6F8), width: 3),
                ),
                child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Đổi ảnh đại diện",
            style: TextStyle(
              color: Color(0xFF2B6CEE),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        _buildTextField(
          label: "Họ và tên",
          controller: _nameController,
          hint: "Nhập họ và tên của bạn",
        ),
        const SizedBox(height: 20),
        _buildTextField(
          label: "Số điện thoại",
          controller: _phoneController,
          icon: Icons.call,
          hint: "Nhập số điện thoại",
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 20),
        _buildTextField(
          label: "Email",
          controller: _emailController,
          icon: Icons.mail,
          hint: "Nhập địa chỉ email",
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        _buildTextField(
          label: "Địa chỉ",
          controller: _addressController,
          icon: Icons.location_on,
          hint: "Nhập địa chỉ của bạn",
          maxLines: 2, // Cho phép nhập nhiều dòng
        ),
        const SizedBox(height: 20),
        _buildTextField(
          label: "Mật khẩu",
          controller: _passwordController,
          icon: Icons.lock,
          hint: "********",
          isPassword: true,
        ),
        const SizedBox(height: 40), // Khoảng trống cuối form
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hint,
    IconData? icon,
    bool isPassword = false,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF0D121B),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFCFD7E7)), // Border xám nhạt
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword && _obscurePassword,
            keyboardType: keyboardType,
            maxLines: maxLines,
            style: const TextStyle(fontSize: 16, color: Color(0xFF0D121B)),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              prefixIcon: icon != null
                  ? Icon(icon, color: Colors.grey, size: 20)
                  : null,
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomAction() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F8),
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2B6CEE),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              shadowColor: const Color(0xFF2B6CEE).withOpacity(0.4),
            ),
            onPressed: () {
              // Xử lý lưu thông tin
              Navigator.pop(context); // Demo: Quay lại màn hình trước
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Đã lưu thay đổi")),
              );
            },
            child: const Text(
              "Lưu thay đổi",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}