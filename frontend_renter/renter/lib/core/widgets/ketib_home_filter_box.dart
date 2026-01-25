import 'package:flutter/material.dart';
import '../constants/ketib_AppColors.dart';
import 'ketib_button.dart'; // Import file button của bạn

class KetibHomeFilterBox extends StatelessWidget {
  final VoidCallback onSearchTap;

  const KetibHomeFilterBox({Key? key, required this.onSearchTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          _buildDropdownLabel('KHU VỰC'),
          _buildFakeDropdown('Quận Cầu Giấy, Hà Nội', Icons.map),
          const SizedBox(height: 16),
          _buildDropdownLabel('KHOẢNG GIÁ'),
          _buildFakeDropdown('3 - 5 triệu / tháng', Icons.monetization_on_outlined),
          const SizedBox(height: 20),
          KetibButton(
            text: 'Tìm trọ ngay',
            icon: Icons.search,
            onPressed: onSearchTap,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.textLight,
        ),
      ),
    );
  }

  Widget _buildFakeDropdown(String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textMain,
              ),
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, color: AppColors.textLight),
        ],
      ),
    );
  }
}