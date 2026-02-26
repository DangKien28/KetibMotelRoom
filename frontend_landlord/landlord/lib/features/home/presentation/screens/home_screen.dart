import 'package:flutter/material.dart';
import '../../../../core/constants/ketib_AppColors.dart'; // Copy từ bên renter sang

class LandlordHomeScreen extends StatelessWidget {
  const LandlordHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KetibAppcolors.background,
      appBar: AppBar(
        title: const Text("Ketib Landlord", style: TextStyle(fontWeight: FontWeight.bold, color: KetibAppcolors.textMain)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none, color: KetibAppcolors.textMain), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Tổng quan hệ thống", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: KetibAppcolors.textMain)),
            const SizedBox(height: 20),
            
            // Hàng 1: Thống kê nhanh
            Row(
              children: [
                _buildStatCard("Số phòng", "12", Icons.home, Colors.blue),
                const SizedBox(width: 16),
                _buildStatCard("Đang trống", "03", Icons.vpn_key, Colors.green),
              ],
            ),
            const SizedBox(height: 16),
            
            // Hàng 2: Thống kê nhanh
            Row(
              children: [
                _buildStatCard("Hợp đồng", "09", Icons.description, Colors.orange),
                const SizedBox(width: 16),
                _buildStatCard("Sắp hết hạn", "02", Icons.alarm, Colors.red),
              ],
            ),
            
            const SizedBox(height: 32),
            const Text("Hoạt động gần đây", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            
            // Danh sách hoạt động mô phỏng
            _buildActivityItem("Nguyễn Văn A vừa gửi tin nhắn", "Phòng 102", "2 phút trước"),
            _buildActivityItem("Hợp đồng phòng 305 đã được ký", "Thành công", "1 giờ trước"),
          ],
        ),
      ),
      // Nút đăng tin nhanh giống phong cách của KetibButton
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: KetibAppcolors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Đăng phòng mới", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 12),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(title, style: const TextStyle(color: KetibAppcolors.textLight, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(String title, String subtitle, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: KetibAppcolors.primary.withOpacity(0.1), child: const Icon(Icons.history, color: KetibAppcolors.primary, size: 20)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(color: KetibAppcolors.textLight, fontSize: 12)),
            ]),
          ),
          Text(time, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        ],
      ),
    );
  }
}