import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/ketib_AppColors.dart';
import '../../../../core/widgets/ketib_button.dart';
import '../../../../core/widgets/ketib_text_field.dart';
import '../../../../core/utils/validators.dart';
import '../bloc/register_bloc.dart';
import '../bloc/register_event.dart';
import '../bloc/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Khởi tạo Controllers để quản lý text nhập vào
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Giải phóng bộ nhớ khi thoát màn hình
  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegister() {
    // Chỉ gọi Bloc khi Form hợp lệ (không có lỗi đỏ)
    if (_formKey.currentState!.validate()) {
      context.read<RegisterBloc>().add(
            RegisterSubmitted(
              fullName: _fullNameController.text.trim(),
              email: _emailController.text.trim(),
              phoneNumber: _phoneController.text.trim(),
              password: _passwordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Đăng Ký",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      // BlocConsumer giúp vừa lắng nghe state để show thông báo, vừa vẽ lại UI
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          } else if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.green),
            );
            Navigator.pop(context); // Quay lại màn hình trước đó (Welcome/Login)
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/logo_TK.png', // Đảm bảo bạn đã có ảnh này
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // 1. Họ và tên
                  KetibTextField(
                    label: "Họ và tên",
                    hintText: "Nhập họ và tên",
                    controller: _fullNameController,
                    icon: Icons.person_outline,
                    isIconLeft: true, // Icon nằm bên trái
                    validator: (val) => Validators.validateRequired(val, 'Họ và tên'),
                  ),
                  const SizedBox(height: 16),

                  // 2. Email
                  KetibTextField(
                    label: "Email",
                    hintText: "Nhập địa chỉ email",
                    controller: _emailController,
                    icon: Icons.email_outlined,
                    isIconLeft: true,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.validateEmail, // Sử dụng validator từ Core
                  ),
                  const SizedBox(height: 16),

                  // 3. Số điện thoại
                  KetibTextField(
                    label: "Số điện thoại",
                    hintText: "Nhập số điện thoại",
                    controller: _phoneController,
                    icon: Icons.phone_android_outlined,
                    isIconLeft: true,
                    keyboardType: TextInputType.phone,
                    validator: Validators.validatePhone, // Sử dụng validator mới thêm
                  ),
                  const SizedBox(height: 16),

                  // 4. Mật khẩu
                  KetibTextField(
                    label: "Mật khẩu",
                    hintText: "Nhập mật khẩu",
                    controller: _passwordController,
                    icon: Icons.lock_outline,
                    isIconLeft: true,
                    isPassword: true, // Tự động hiện nút mắt ẩn/hiện
                    validator: Validators.validatePassword,
                  ),
                  const SizedBox(height: 16),

                  // 5. Xác nhận mật khẩu
                  KetibTextField(
                    label: "Nhập lại mật khẩu",
                    hintText: "Nhập lại mật khẩu",
                    controller: _confirmPasswordController,
                    icon: Icons.lock_outline,
                    isIconLeft: true,
                    isPassword: true,
                    validator: (val) => Validators.validateConfirmPassword(
                      val, 
                      _passwordController.text, // So sánh với mật khẩu gốc
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Nút Đăng ký (Hiển thị Loading khi đang gọi API)
                  state is RegisterLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: KetibButton(
                            text: "Đăng Ký",
                            onPressed: _onRegister,
                          ),
                        ),

                  const SizedBox(height: 20),
                  
                  // Dẫn hướng sang màn hình đăng nhập
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Đã có tài khoản? ", style: TextStyle(color: Colors.grey)),
                      GestureDetector(
                        onTap: () {
                          // Điều hướng sẽ được xử lý sau khi làm xong màn Login
                          Navigator.pop(context); 
                        },
                        child: const Text(
                          "Đăng nhập ngay",
                          style: TextStyle(
                            color: KetibAppcolors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}