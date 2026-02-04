import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/ketib_AppColors.dart';
import '../../../../core/widgets/ketib_button.dart';
import '../../../../core/widgets/ketib_text_field.dart';
import 'register_screen.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_state.dart';
import '../bloc/login_event.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin()
  {
    context.read<LoginBloc>().add(
        LoginSubmitted(
            phoneNumber: _emailController.text.trim(),
            password: _passwordController.text,
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: KetibAppcolors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: KetibAppcolors.textMain),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // TIÊU ĐỀ
                const Text(
                  "Chào mừng trở lại! 👋",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: KetibAppcolors.textMain,
                    fontFamily: 'Manrope',
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Vui lòng đăng nhập để tiếp tục sử dụng dịch vụ của Ketib Renter.",
                  style: TextStyle(
                    fontSize: 16,
                    color: KetibAppcolors.textLight,
                    fontFamily: 'Manrope',
                  ),
                ),
                
                const SizedBox(height: 40),

                // EMAIL FIELD
                KetibTextField(
                  label: "Email",
                  hintText: "Nhập email của bạn",
                  controller: _emailController,
                  icon: Icons.email_outlined,
                  isIconLeft: true, // Icon bên trái theo yêu cầu Login
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Vui lòng nhập email";
                    if (!value.contains("@")) return "Email không hợp lệ";
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // PASSWORD FIELD
                KetibTextField(
                  label: "Mật khẩu",
                  hintText: "Nhập mật khẩu",
                  controller: _passwordController,
                  icon: Icons.lock_outline,
                  isIconLeft: true, // Icon bên trái theo yêu cầu Login
                  isPassword: true, // Hiển thị con mắt ẩn/hiện mật khẩu
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Vui lòng nhập mật khẩu";
                    if (value.length < 6) return "Mật khẩu phải từ 6 ký tự";
                    return null;
                  },
                ),

                // QUÊN MẬT KHẨU
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Xử lý quên mật khẩu
                    },
                    child: const Text(
                      "Quên mật khẩu?",
                      style: TextStyle(
                        color: KetibAppcolors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // NÚT ĐĂNG NHẬP
                KetibButton(
                  text: "Đăng nhập",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _onLogin;
                    }
                  },
                ),

                const SizedBox(height: 24),

                // CHƯA CÓ TÀI KHOẢN?
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 15,
                        color: KetibAppcolors.textLight,
                        fontFamily: 'Manrope',
                      ),
                      children: [
                        const TextSpan(text: "Bạn chưa có tài khoản? "),
                        TextSpan(
                          text: "Đăng ký ngay",
                          style: const TextStyle(
                            color: KetibAppcolors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => const RegisterScreen()),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}