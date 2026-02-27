// frontend_landlord/landlord/lib/features/individual/presentation/screens/individual_screen.dart
import 'package:flutter/material.dart';

class IndividualScreen extends StatelessWidget {
  const IndividualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF2B6CEE);
    final Color bgColor = const Color(0xFFF6F6F8); // background-light

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Tài khoản',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black54),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100), // Khoảng trống cho NavBar
        child: Column(
          children: [
            // 1. Phần thông tin hồ sơ (Profile Section)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                children: [
                  // Avatar & Badge
                  Stack(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 2)),
                          ],
                          image: const DecorationImage(
                            image: NetworkImage('https://via.placeholder.com/150'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.green[500],
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.check, size: 14, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  
                  // Thông tin Text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Trần Văn Nam',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '0912 345 678',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Chủ trọ uy tín',
                            style: TextStyle(color: primaryColor, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Nút Sửa
                  TextButton(
                    onPressed: () {},
                    child: Text('Sửa', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),

            // 2. Thẻ Doanh thu (Revenue Card)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: primaryColor.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Doanh thu tháng này', style: TextStyle(color: Colors.blue[100], fontSize: 14, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  const Text('24.500.000 đ', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.white24, height: 1),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildRevenueStat('12', 'Tổng phòng')),
                      Container(width: 1, height: 40, color: Colors.white24),
                      Expanded(child: _buildRevenueStat('4', 'Còn trống')),
                      Container(width: 1, height: 40, color: Colors.white24),
                      Expanded(child: _buildRevenueStat('4.8 ⭐', 'Đánh giá')),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 3. Các Nhóm Menu (Menu Sections)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- TÀI CHÍNH ---
                  const Padding(
                    padding: EdgeInsets.only(left: 16, bottom: 8),
                    child: Text('TÀI CHÍNH', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2)),
                  ),
                  _buildMenuCard([
                    _buildMenuItem(icon: Icons.account_balance_wallet, title: 'Ví của tôi', iconColor: Colors.orange, trailingText: '1.200.000 đ'),
                    _buildMenuItem(icon: Icons.history, title: 'Lịch sử giao dịch', iconColor: Colors.green),
                    _buildMenuItem(icon: Icons.credit_card, title: 'Tài khoản ngân hàng', iconColor: Colors.purple, showDivider: false),
                  ]),
                  
                  const SizedBox(height: 20),

                  // --- QUẢN LÝ & CÀI ĐẶT ---
                  const Padding(
                    padding: EdgeInsets.only(left: 16, bottom: 8),
                    child: Text('QUẢN LÝ & CÀI ĐẶT', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2)),
                  ),
                  _buildMenuCard([
                    _buildMenuItem(icon: Icons.verified_user, title: 'Xác thực tài khoản', iconColor: primaryColor, trailingWidget: _buildStatusBadge('Đã xác thực', Colors.green)),
                    _buildMenuItem(icon: Icons.notifications, title: 'Cài đặt thông báo', iconColor: Colors.grey[600]!, iconBgColor: Colors.grey[200]),
                    _buildMenuItem(icon: Icons.lock, title: 'Đổi mật khẩu', iconColor: Colors.grey[600]!, iconBgColor: Colors.grey[200], showDivider: false),
                  ]),

                  const SizedBox(height: 20),

                  // --- HỖ TRỢ ---
                  _buildMenuCard([
                    _buildMenuItem(icon: Icons.help, title: 'Trung tâm trợ giúp', iconColor: Colors.teal),
                    _buildMenuItem(icon: Icons.description, title: 'Điều khoản & Chính sách', iconColor: Colors.grey[600]!, iconBgColor: Colors.grey[200], showDivider: false),
                  ]),

                  const SizedBox(height: 12),

                  // 4. Nút Đăng xuất
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFF0F0F0)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout, color: Colors.redAccent),
                          SizedBox(width: 8),
                          Text('Đăng xuất', style: TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  
                  // Phiên bản
                  const Center(
                    child: Text('Phiên bản 1.0.2', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget hiển thị cột thống kê trong Thẻ Doanh thu
  Widget _buildRevenueStat(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(color: Colors.blue[100], fontSize: 12)),
      ],
    );
  }

  // Widget khung Card bọc ngoài danh sách menu
  Widget _buildMenuCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Column(children: children),
    );
  }

  // Widget hiển thị từng dòng Menu
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required Color iconColor,
    Color? iconBgColor,
    String? trailingText,
    Widget? trailingWidget,
    bool showDivider = true,
  }) {
    // Nếu không truyền iconBgColor, tự động lấy iconColor với opacity 10%
    final bgColor = iconBgColor ?? iconColor.withOpacity(0.1);

    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // Icon tròn
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: bgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const SizedBox(width: 16),
                
                // Tiêu đề
                Expanded(
                  child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)),
                ),
                
                // Phần tử bên phải (Số dư, Badge...)
                if (trailingText != null)
                  Text(trailingText, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey)),
                if (trailingWidget != null) trailingWidget,
                
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
              ],
            ),
          ),
        ),
        if (showDivider)
          const Divider(height: 1, color: Color(0xFFF0F0F0), indent: 68),
      ],
    );
  }

  // Widget Badge "Đã xác thực"
  Widget _buildStatusBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}