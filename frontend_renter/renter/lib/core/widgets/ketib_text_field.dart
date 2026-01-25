import 'package:flutter/material.dart';
import '../constants/ketib_AppColors.dart';

class KetibTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData? icon; // Icon chính
  final bool isIconLeft; // MỚI: Cho phép đặt icon bên trái (Login) hoặc phải (Register)
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const KetibTextField({
    Key? key,
    required this.label,
    required this.hintText,
    this.icon,
    this.isIconLeft = false, // Mặc định là phải (cho màn Register cũ), set true cho Login
    this.isPassword = false,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> obscureTextNotifier = ValueNotifier(isPassword);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: const TextStyle(
              color: KetibAppcolors.textMain,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: obscureTextNotifier,
          builder: (context, obscureText, child) {
            return TextFormField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              validator: validator,
              style: const TextStyle(
                  color: KetibAppcolors.textMain, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                
                // Logic Icon bên Trái (Prefix) - Dùng cho Login
                prefixIcon: (isIconLeft && icon != null)
                    ? Icon(icon, color: Colors.grey[400])
                    : null,

                // Logic Icon bên Phải (Suffix) - Dùng cho Register hoặc Password Eye
                suffixIcon: isPassword
                    ? IconButton(
                        icon: Icon(
                          obscureText
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey[400],
                        ),
                        onPressed: () =>
                            obscureTextNotifier.value = !obscureTextNotifier.value,
                      )
                    : (!isIconLeft && icon != null // Nếu không phải icon trái thì để phải
                        ? Icon(icon, color: Colors.grey[400])
                        : null),
              ),
            );
          },
        ),
      ],
    );
  }
}