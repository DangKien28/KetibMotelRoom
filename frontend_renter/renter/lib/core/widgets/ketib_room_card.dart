import 'package:flutter/material.dart';
import '../constants/ketib_AppColors.dart';

class KetibRoomCard extends StatelessWidget {
  final String title;
  final String address;
  final String price;
  final String imageUrl;
  final String hostName;
  final String? hostAvatarUrl;
  final String? timeAgo; // Ví dụ: "3 tháng +"
  final bool isFavorite;
  final VoidCallback onTap;

  const KetibRoomCard({
    Key? key,
    required this.title,
    required this.address,
    required this.price,
    required this.imageUrl,
    required this.hostName,
    this.hostAvatarUrl,
    this.timeAgo,
    this.isFavorite = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PHẦN 1: ẢNH + TAG GIÁ + TIM
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    imageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, _, __) => Container(
                      height: 180,
                      color: Colors.grey[200],
                      child: const Center(child: Icon(Icons.image, size: 50, color: Colors.grey)),
                    ),
                  ),
                ),
                // Nút Tim
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? AppColors.error : AppColors.textLight,
                      size: 20,
                    ),
                  ),
                ),
                // Tag Giá (Style: Xanh dương góc phải dưới như trang chủ)
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      price,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                // Tag "Mới đăng" (Optional - ví dụ)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'MỚI ĐĂNG',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            // PHẦN 2: THÔNG TIN
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMain,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: AppColors.textLight),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          address,
                          style: const TextStyle(fontSize: 13, color: AppColors.textLight),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Divider(),
                  // const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Host info
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundImage: hostAvatarUrl != null ? NetworkImage(hostAvatarUrl!) : null,
                            child: hostAvatarUrl == null ? const Icon(Icons.person, size: 12) : null,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            hostName,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textMain,
                            ),
                          ),
                        ],
                      ),
                      // Time ago
                      if (timeAgo != null)
                        Text(
                          timeAgo!,
                          style: const TextStyle(fontSize: 12, color: AppColors.textLight),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}