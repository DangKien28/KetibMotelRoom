import 'package:flutter/material.dart';
import '../constants/ketib_AppColors.dart';

class KetibProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool isDestructive; // Cho nút Đăng xuất (màu đỏ)

  const KetibProfileMenuItem({
    Key? key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.isDestructive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDestructive ? const Color(0xFFFEF2F2) : KetibAppcolors.surface, // Màu nền đỏ nhạt nếu là nút xóa
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDestructive ? Colors.white : KetibAppcolors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isDestructive ? KetibAppcolors.error : KetibAppcolors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDestructive ? KetibAppcolors.error : KetibAppcolors.textMain,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: KetibAppcolors.textLight,
                      ),
                    ),
                  ]
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isDestructive ? KetibAppcolors.error.withOpacity(0.5) : KetibAppcolors.textLight,
            ),
          ],
        ),
      ),
    );
  }
}