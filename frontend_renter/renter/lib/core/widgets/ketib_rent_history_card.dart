import 'package:flutter/material.dart';
import '../constants/ketib_AppColors.dart';

class KetibRentHistoryCard extends StatelessWidget {
  final String roomName;
  final String contractId;
  final String address;
  final String dateRange;
  final String price;
  final String status; // "Đang thuê" hoặc "Đã hoàn tất"
  final VoidCallback onTap;

  const KetibRentHistoryCard({
    Key? key,
    required this.roomName,
    required this.contractId,
    required this.address,
    required this.dateRange,
    required this.price,
    required this.status,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isActive = status == "Đang thuê";

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: isActive ? Border.all(color: AppColors.primary.withOpacity(0.3), width: 1) : null,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        roomName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textMain,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isActive ? AppColors.success.withOpacity(0.1) : Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isActive ? AppColors.success : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Mã hợp đồng: #$contractId',
                  style: const TextStyle(fontSize: 12, color: AppColors.textLight),
                ),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.location_on, address),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.calendar_today, dateRange),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.monetization_on, '$price/tháng', isBold: true),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            child: Center(
              child: Text(
                isActive ? 'Xem chi tiết' : 'Xem hóa đơn cũ',
                style: TextStyle(
                  color: isActive ? AppColors.primary : AppColors.textLight,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, {bool isBold = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.textLight),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: isBold ? AppColors.textMain : AppColors.textLight,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}