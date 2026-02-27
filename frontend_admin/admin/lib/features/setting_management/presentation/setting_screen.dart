import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color bgColor = const Color(0xFFF6F6F8);
    final Color primaryColor = const Color(0xFF2B6CEE);

    return Scaffold(
      backgroundColor: bgColor,
      // Sử dụng SafeArea và Header tự tạo thay vì AppBar mặc định để giống hệt bản thiết kế
      body: SafeArea(
        child: Column(
          children: [
            // --- HEADER ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Cài đặt',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade300),
                      image: const DecorationImage(
                        image: NetworkImage('https://via.placeholder.com/150'), // Avatar admin giả lập
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- NỘI DUNG CUỘN ---
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                children: [
                  // 1. Thanh tìm kiếm
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2))
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm cài đặt...',
                        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                        prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 2. Nhóm: Tài khoản
                  _buildSectionTitle('Tài khoản'),
                  _buildSettingsGroup([
                    _buildSettingsItem(
                      icon: Icons.manage_accounts,
                      iconColor: primaryColor,
                      iconBgColor: Colors.blue.shade50,
                      title: 'Quản lý tài khoản Admin',
                    ),
                    _buildSettingsItem(
                      icon: Icons.admin_panel_settings,
                      iconColor: Colors.indigo.shade600,
                      iconBgColor: Colors.indigo.shade50,
                      title: 'Quản lý quyền truy cập',
                    ),
                  ]),
                  const SizedBox(height: 24),

                  // 3. Nhóm: Hệ thống
                  _buildSectionTitle('Hệ thống'),
                  _buildSettingsGroup([
                    _buildSettingsItem(
                      icon: Icons.tune,
                      iconColor: Colors.orange.shade600,
                      iconBgColor: Colors.orange.shade50,
                      title: 'Cài đặt chung',
                      subtitle: 'Ngôn ngữ, Chủ đề',
                    ),
                    _buildSettingsItem(
                      icon: Icons.notifications_active,
                      iconColor: Colors.red.shade600,
                      iconBgColor: Colors.red.shade50,
                      title: 'Cài đặt thông báo',
                    ),
                  ]),
                  const SizedBox(height: 24),

                  // 4. Nhóm: Thông tin
                  _buildSectionTitle('Thông tin'),
                  _buildSettingsGroup([
                    _buildSettingsItem(
                      icon: Icons.gavel,
                      iconColor: Colors.green.shade600,
                      iconBgColor: Colors.green.shade50,
                      title: 'Chính sách và điều khoản',
                    ),
                    _buildSettingsItem(
                      icon: Icons.info,
                      iconColor: Colors.grey.shade700,
                      iconBgColor: Colors.grey.shade200,
                      title: 'Thông tin về ứng dụng',
                      trailingText: 'v1.0.4',
                    ),
                  ]),
                  const SizedBox(height: 32),

                  // 5. Nút Đăng xuất
                  InkWell(
                    onTap: () {
                      // TODO: Thêm logic đăng xuất
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2))
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Đăng xuất',
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Text phiên bản
                  const Center(
                    child: Text(
                      'Phiên bản Admin System 2.1',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Hàm tạo Tiêu đề cho từng phần
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  // Hàm nhóm các ô cài đặt lại với nhau trong một Card trắng
  Widget _buildSettingsGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        children: children.asMap().entries.map((entry) {
          int index = entry.key;
          Widget child = entry.value;
          // Thêm Divider ở giữa các item, nhưng không thêm ở dòng cuối
          if (index < children.length - 1) {
            return Column(
              children: [
                child,
                Divider(height: 1, color: Colors.grey.shade100, indent: 56),
              ],
            );
          }
          return child;
        }).toList(),
      ),
    );
  }

  // Hàm tạo từng dòng cài đặt (ListTile)
  Widget _buildSettingsItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    String? subtitle,
    String? trailingText,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Icon
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(color: iconBgColor, shape: BoxShape.circle),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              
              // Tiêu đề & Phụ đề
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87)),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ]
                  ],
                ),
              ),
              
              // Dữ liệu đuôi (nếu có) + Dấu mũi tên
              if (trailingText != null) ...[
                Text(trailingText, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                const SizedBox(width: 4),
              ],
              const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}