import 'package:flutter/material.dart';
import '../constants/ketib_AppColors.dart';

class KetibMessageTile extends StatelessWidget {
  final String title; // Tên người gửi hoặc tiêu đề
  final String subtitle; // Nội dung tin nhắn
  final String time;
  final String? imageUrl; // Avatar
  final IconData? icon; // Icon (Dùng cho thông báo nếu không có ảnh)
  final Color? iconColor; // Màu nền icon (cho thông báo)
  final bool isUnread;
  final VoidCallback onTap;

  const KetibMessageTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.time,
    this.imageUrl,
    this.icon,
    this.iconColor,
    this.isUnread = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          // border: isUnread ? Border.all(color: AppColors.primary.withOpacity(0.2)) : null,
        ),
        child: Row(
          children: [
            // Avatar hoặc Icon
            if (imageUrl != null)
              Stack(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(imageUrl!),
                  ),
                  if (isUnread) // Chấm xanh trạng thái online (như design)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              )
            else if (icon != null)
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: (iconColor ?? AppColors.primary).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor ?? AppColors.primary, size: 28),
              ),
            
            const SizedBox(width: 16),
            
            // Nội dung
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                          color: AppColors.textMain,
                        ),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 12,
                          color: isUnread ? AppColors.primary : AppColors.textLight,
                          fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: isUnread ? AppColors.textMain : AppColors.textLight,
                          ),
                        ),
                      ),
                      if (isUnread && imageUrl == null) // Chấm xanh thông báo chưa đọc
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}