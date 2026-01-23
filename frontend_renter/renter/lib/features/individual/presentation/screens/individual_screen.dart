import 'package:flutter/material.dart';
import 'dart:math' as math; // Dùng để vẽ viền đứt đoạn (dashed border)

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // --- COLOR CONSTANTS (Theo HTML/Tailwind config) ---
  static const Color kPrimaryColor = Color(0xFF2B6CEE);
  static const Color kBackgroundColor = Color(0xFFF6F6F8);
  static const Color kSurfaceColor = Colors.white;
  static const Color kTextPrimary = Color(0xFF0F172A); // Slate 900
  static const Color kTextSecondary = Color(0xFF64748B); // Slate 500
  static const Color kDangerColor = Color(0xFFEF4444); // Red 500
  static const Color kBorderColor = Color(0xFFF1F5F9); // Gray 100

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 100), // Padding cho bottom nav
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildMenuSection(
              title: "TÀI KHOẢN",
              children: [
                _buildMenuItem(
                  icon: Icons.person,
                  iconColor: kPrimaryColor,
                  iconBg: const Color(0xFFEFF6FF), // Blue 50
                  title: "Thông tin cá nhân",
                  subtitle: "Chỉnh sửa hồ sơ của bạn",
                  onTap: () {},
                ),
                _buildDivider(),
                _buildMenuItem(
                  icon: Icons.home,
                  iconColor: const Color(0xFF6366F1), // Indigo 500
                  iconBg: const Color(0xFFEEF2FF), // Indigo 50
                  title: "Thông tin phòng trọ",
                  subtitle: "Hợp đồng & tiện ích",
                  onTap: () {},
                ),
                _buildDivider(),
                _buildMenuItem(
                  icon: Icons.history,
                  iconColor: const Color(0xFF14B8A6), // Teal 500
                  iconBg: const Color(0xFFF0FDFA), // Teal 50
                  title: "Lịch sử thuê trọ",
                  subtitle: "Lịch sử thanh toán & hóa đơn",
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildMenuSection(
              title: "HỆ THỐNG",
              children: [
                _buildMenuItem(
                  icon: Icons.logout,
                  iconColor: kDangerColor,
                  iconBg: const Color(0xFFFEF2F2), // Red 50
                  title: "Đăng xuất",
                  subtitle: null, // Không có subtitle
                  onTap: () {},
                  isDestructive: true,
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              "Phiên bản 1.0.2",
              style: TextStyle(
                color: kTextSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // 1. App Bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: kBackgroundColor.withOpacity(0.9),
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.transparent, 
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back, color: kTextPrimary),
        ),
        onPressed: () => Navigator.pop(context), // Logic quay lại
      ),
      title: const Text(
        "Cá nhân",
        style: TextStyle(
          color: kTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Plus Jakarta Sans',
        ),
      ),
    );
  }

  // 2. Profile Header (Avatar + Name)
  Widget _buildProfileHeader() {
    return Column(
      children: [
        const SizedBox(height: 16),
        // Avatar with Dashed Border
        Stack(
          children: [
            // Custom Paint cho viền đứt đoạn
            CustomPaint(
              painter: DashedCirclePainter(color: kPrimaryColor, strokeWidth: 2, gap: 5),
              child: Container(
                margin: const EdgeInsets.all(6), // Khoảng cách giữa viền và ảnh
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                // TODO: User Avatar Image
                child: const Icon(Icons.person, size: 60, color: Colors.white),
              ),
            ),
            // Edit Button Badge
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: kBackgroundColor, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Name & Phone Placeholder
        const Text(
          "Tên người dùng", // Placeholder Name
          style: TextStyle(
            color: kTextPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Plus Jakarta Sans',
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          "Số điện thoại", // Placeholder Phone
          style: TextStyle(
            color: kTextSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // 3. Menu Group Component
  Widget _buildMenuSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              color: kTextSecondary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: kSurfaceColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: kBorderColor),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.01),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  // 4. Single Menu Item Component
  Widget _buildMenuItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16), // Để hiệu ứng ripple đẹp
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Icon Box
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 16),
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isDestructive ? kDangerColor : kTextPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: kTextSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // Arrow Icon
            Icon(
              Icons.chevron_right,
              color: isDestructive ? kDangerColor.withOpacity(0.5) : Colors.grey.shade400,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1, color: kBorderColor, indent: 70);
  }

  // 5. Bottom Navigation Bar (Visual only)
  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        currentIndex: 3, // Đặt cứng là 3 (Cá nhân)
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.grey.shade400,
        selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
        unselectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Trang chủ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: "Đã lưu",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: "Tin nhắn",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), // Filled icon for active state
            activeIcon: Icon(Icons.person),
            label: "Cá nhân",
          ),
        ],
        onTap: (index) {},
      ),
    );
  }
}

// Class hỗ trợ vẽ viền đứt đoạn tròn quanh Avatar
class DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  DashedCirclePainter({required this.color, required this.strokeWidth, required this.gap});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double radius = size.width / 2;
    final double circumference = 2 * math.pi * radius;
    final double dashWidth = 5.0; // Độ dài mỗi vạch
    final int dashCount = (circumference / (dashWidth + gap)).floor();
    final double initialOffset = -math.pi / 2; // Bắt đầu từ đỉnh

    for (int i = 0; i < dashCount; i++) {
      final double startAngle = initialOffset + (2 * math.pi * i / dashCount);
      final double sweepAngle = (2 * math.pi / dashCount) * (dashWidth / (dashWidth + gap));
      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}