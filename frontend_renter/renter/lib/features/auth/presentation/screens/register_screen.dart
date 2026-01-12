import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Import các file Ketib vừa tạo
import '../../../../core/constants/ketib_AppColors.dart';
import '../../../../core/widgets/ketib_text_field.dart';
import '../../../../core/widgets/ketib_button.dart';

// Import Bloc
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  void _onRegisterPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(RegisterSubmitted(
            name: _nameController.text,
            phone: _phoneController.text,
            email: _emailController.text,
            password: _passController.text,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      
      // TopAppBar
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Đăng ký"),
      ),
      
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Đăng ký thành công!")));
            Navigator.pop(context);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message), backgroundColor: Colors.red));
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 10, 24, 30), // px-6 pb-12 pt-2
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Tag "NGƯỜI THUÊ"
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), // px-3 py-1
                  decoration: BoxDecoration(
                    color: AppColors.tagBackground, // bg-blue-100
                    borderRadius: BorderRadius.circular(999), // rounded-full
                    border: Border.all(color: Colors.blue.shade200), // border-blue-200
                  ),
                  child: const Text(
                    "NGƯỜI THUÊ",
                    style: TextStyle(
                      color: AppColors.tagText, // text-primary
                      fontWeight: FontWeight.bold,
                      fontSize: 12, // text-xs
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 2. Headline & Subtitle
                const Text(
                  "Tạo tài khoản mới",
                  style: TextStyle(
                    fontSize: 30, // text-3xl
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMain,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Đăng ký ngay để tìm phòng trọ ưng ý và quản lý hợp đồng dễ dàng.",
                  style: TextStyle(
                    fontSize: 16, // text-base
                    color: AppColors.textLight,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32), // mb-8

                // --- FORM FIELDS (space-y-5 -> khoảng cách 20px) ---

                // Họ và tên (Icon Person bên phải)
                KetibTextField(
                  label: "Họ và tên",
                  hintText: "Nhập họ tên của bạn",
                  controller: _nameController,
                  icon: Icons.person_outline, // material-symbols: person
                  validator: (val) => val!.isEmpty ? "Vui lòng nhập họ tên" : null,
                ),
                const SizedBox(height: 20),

                // Số điện thoại (Icon Phone bên phải)
                KetibTextField(
                  label: "Số điện thoại",
                  hintText: "0901234567",
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  icon: Icons.phone_outlined, // material-symbols: phone
                  validator: (val) => val!.length < 9 ? "SĐT không hợp lệ" : null,
                ),
                const SizedBox(height: 20),

                // Email (Icon Mail bên phải)
                KetibTextField(
                  label: "Email",
                  hintText: "example@gmail.com",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.mail_outline, // material-symbols: mail
                  validator: (val) => !val!.contains("@") ? "Email không hợp lệ" : null,
                ),
                const SizedBox(height: 20),

                // Mật khẩu (Nút Visibility bên phải)
                KetibTextField(
                  label: "Mật khẩu",
                  hintText: "••••••••",
                  controller: _passController,
                  isPassword: true,
                  validator: (val) => val!.length < 6 ? "Mật khẩu quá ngắn" : null,
                ),
                const SizedBox(height: 20),

                // Xác nhận mật khẩu
                KetibTextField(
                  label: "Xác nhận mật khẩu",
                  hintText: "••••••••",
                  controller: _confirmPassController,
                  isPassword: true,
                  validator: (val) => val != _passController.text ? "Mật khẩu không khớp" : null,
                ),
                const SizedBox(height: 32), // pt-6

                // 3. Primary Action Button
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return KetibButton(
                      text: "Đăng ký",
                      isLoading: state is AuthLoading,
                      onPressed: _onRegisterPressed,
                    );
                  },
                ),
                
                // 4. Social Login Divider
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Row(
                    children: [
                      const Expanded(child: Divider(color: AppColors.inputBorder)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "HOẶC ĐĂNG KÝ VỚI",
                          style: TextStyle(
                            color: Colors.grey[400], // text-gray-400
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider(color: AppColors.inputBorder)),
                    ],
                  ),
                ),

                // 5. Social Buttons (Grid 2 cột)
                Row(
                  children: [
                    Expanded(child: _buildSocialButton(Icons.g_mobiledata, const Color(0xFFEA4335))), // Google Red
                    const SizedBox(width: 16),
                    Expanded(child: _buildSocialButton(Icons.facebook, const Color(0xFF1877F2))),    // FB Blue
                  ],
                ),
                const SizedBox(height: 32),

                // 6. Footer Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bạn đã có tài khoản? ",
                      style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        "Đăng nhập",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24), // Bottom safe area
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget con cho Social Button (Style theo HTML: h-14 rounded-2xl border)
  Widget _buildSocialButton(IconData icon, Color color) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Center(
          child: Icon(icon, size: 32, color: color), // Icon to hơn chút cho đẹp
        ),
      ),
    );
  }
}