import 'package:flutter/material.dart';
import 'package:renter/features/individual/presentation/screens/current_room_screen.dart';
import 'package:renter/features/individual/presentation/screens/rental_history_screen.dart';

// Import các màn hình chi tiết
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8), // background-light
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildMenuGroup(
              title: "TÀI KHOẢN",
              items: [
                // 1. Điều hướng sang Chỉnh sửa thông tin cá nhân
                _buildMenuItem(
                  context: context,
                  icon: Icons.person,
                  iconColor: const Color(0xFF2B6CEE),
                  iconBgColor: const Color(0xFFEAF2FF),
                  title: "Thông tin cá nhân",
                  subtitle: "Chỉnh sửa hồ sơ của bạn",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfileScreen(),
                      ),
                    );
                  },
                ),
                // 2. Điều hướng sang Thông tin phòng trọ
                _buildMenuItem(
                  context: context,
                  icon: Icons.home,
                  iconColor: const Color(0xFF6366F1), // Indigo
                  iconBgColor: const Color(0xFFEEF2FF),
                  title: "Thông tin phòng trọ",
                  subtitle: "Hợp đồng & tiện ích",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RoomInfoScreen(),
                      ),
                    );
                  },
                ),
                // 3. Điều hướng sang Lịch sử thuê trọ
                _buildMenuItem(
                  context: context,
                  icon: Icons.history,
                  iconColor: const Color(0xFF14B8A6), // Teal
                  iconBgColor: const Color(0xFFF0FDFA),
                  title: "Lịch sử thuê trọ",
                  subtitle: "Lịch sử thanh toán & hóa đơn",
                  isLastItem: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RentalHistoryScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildMenuGroup(
              title: "HỆ THỐNG",
              items: [
                _buildMenuItem(
                  context: context,
                  icon: Icons.logout,
                  iconColor: Colors.red,
                  iconBgColor: const Color(0xFFFEF2F2),
                  title: "Đăng xuất",
                  titleColor: Colors.red,
                  isLastItem: true,
                  onTap: () {
                    // Xử lý đăng xuất tại đây
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              "Phiên bản 1.0.2",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFF6F6F8).withOpacity(0.95),
      elevation: 0,
      centerTitle: true,
      // Trong ngữ cảnh Tabbar, nút back thường không cần thiết trừ khi muốn quay lại login
      automaticallyImplyLeading: false, 
      title: const Text(
        "Cá nhân",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        const SizedBox(height: 16),
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF2B6CEE).withOpacity(0.5), width: 1),
              ),
              child: const CircleAvatar(
                radius: 56,
                backgroundImage: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuAQhf7xqVBTAP8rO1FFv7o_hhzyqu7q2We_7Jvg0eJ14G_zxPaTAjO2SRotD3W4AhygmRhC_7cu7knP-8wJGtU5l03V9_3nnaK59drhkHrAaF37JPPEmA0H1ohz0FDF7aD8eMSJKmRMucbnu6_LN0aC205eOYM0ohpC_3JkKo5miAZOyYuKGHrnavGVD4O-uPniZybghYZu428kZO5XtGViN9MpInwH13F5DYXi5dqGLMfHnu2prscA27WDkgldw9dswEbbBziD6BA"),
                backgroundColor: Colors.grey,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFF2B6CEE),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 16),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          "Nguyễn Văn A",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D121B),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          "0912 *** ***",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuGroup({required String title, required List<Widget> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    String? subtitle,
    Color titleColor = const Color(0xFF0D121B),
    bool isLastItem = false,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: isLastItem
            ? const BorderRadius.vertical(bottom: Radius.circular(16))
            : const BorderRadius.vertical(top: Radius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: isLastItem
                ? null
                : Border(bottom: BorderSide(color: Colors.grey.shade100)),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: titleColor,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}