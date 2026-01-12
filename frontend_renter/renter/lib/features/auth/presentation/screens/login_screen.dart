import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Import Core
import '../../../../core/constants/ketib_AppColors.dart';
import '../../../../core/widgets/ketib_text_field.dart';
import '../../../../core/widgets/ketib_button.dart';

// Import Feature Home
import '../../../home/presentation/screens/home_screen.dart'; // Import màn hình Home

// Import Auth Logic
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  // Hàm xử lý khi bấm nút Đăng nhập
  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      // Gửi sự kiện LoginSubmitted vào Bloc
      context.read<AuthBloc>().add(LoginSubmitted(
            email: _emailController.text,
            password: _passController.text,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocListener<AuthBloc, AuthState>(
        // Lắng nghe trạng thái từ Bloc
        listener: (context, state) {
          if (state is AuthSuccess) {
            // 1. Thông báo thành công
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Đăng nhập thành công!"),
                backgroundColor: Colors.green,
              ),
            );
            
            // 2. Chuyển hướng sang HomeScreen (Xóa các màn hình trước đó để không back lại login được)
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
            );
            
          } else if (state is AuthFailure) {
            // Hiển thị lỗi
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              children: [
                // ... (Phần Header, Logo, Title giữ nguyên như code cũ) ...
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: AppColors.textMain),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const Text("Đăng nhập", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textMain)),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Logo Area
                Container(
                  width: 128, height: 128,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.eco, size: 40, color: Colors.green[400]),
                        const SizedBox(height: 8),
                        Text("Ap Naturel", style: TextStyle(fontSize: 12, color: Colors.grey[800], fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text("Chào mừng trở lại!", textAlign: TextAlign.center, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.textMain)),
                const SizedBox(height: 8),
                const Text("Tìm phòng trọ ưng ý ngay hôm nay", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: AppColors.textLight, fontWeight: FontWeight.w500)),
                const SizedBox(height: 32),

                // Form Login
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      KetibTextField(
                        label: "Email hoặc SĐT",
                        hintText: "Nhập email hoặc số điện thoại",
                        controller: _emailController,
                        icon: Icons.mail_outline,
                        isIconLeft: true,
                        validator: (val) => val!.isEmpty ? "Vui lòng nhập email" : null,
                      ),
                      const SizedBox(height: 20),
                      KetibTextField(
                        label: "Mật khẩu",
                        hintText: "Nhập mật khẩu",
                        controller: _passController,
                        isPassword: true,
                        icon: Icons.lock_outline,
                        isIconLeft: true,
                        validator: (val) => val!.isEmpty ? "Vui lòng nhập mật khẩu" : null,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text("Quên mật khẩu?", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Nút Đăng nhập kết nối Bloc state
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return KetibButton(
                            text: "Đăng nhập",
                            icon: Icons.arrow_forward,
                            isLoading: state is AuthLoading, // Hiển thị vòng xoay khi đang gọi API
                            onPressed: _onLoginPressed,      // Gọi hàm login
                          );
                        },
                      ),
                    ],
                  ),
                ),
                
                // ... (Phần Footer, Social Buttons giữ nguyên như code cũ) ...
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Row(children: [
                    const Expanded(child: Divider(color: AppColors.inputBorder)),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text("Hoặc đăng nhập với", style: TextStyle(color: Colors.grey[400], fontSize: 13, fontWeight: FontWeight.w500))),
                    const Expanded(child: Divider(color: AppColors.inputBorder)),
                  ]),
                ),
                Row(children: [
                  Expanded(child: _buildSocialButton("Google", Icons.g_mobiledata, Colors.red)), 
                  const SizedBox(width: 16),
                  Expanded(child: _buildSocialButton("Facebook", Icons.facebook, Colors.blue)),
                ]),
                const SizedBox(height: 40),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Chưa có tài khoản? ", style: TextStyle(color: Colors.grey[600], fontSize: 15)),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen())),
                    child: const Text("Đăng ký ngay", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                ]),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper cho Social Button (Tái sử dụng)
  Widget _buildSocialButton(String text, IconData icon, Color color) {
    return Container(
      height: 48,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.inputBorder)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(color: AppColors.textMain, fontWeight: FontWeight.w600, fontSize: 14)),
        ]),
      ),
    );
  }
}