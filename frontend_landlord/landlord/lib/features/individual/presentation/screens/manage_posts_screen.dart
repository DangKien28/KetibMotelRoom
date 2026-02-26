// frontend_landlord/landlord/lib/features/individual/presentation/screens/manage_posts_screen.dart
import 'package:flutter/material.dart';

class ManagePostsScreen extends StatelessWidget {
  const ManagePostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF2B6CEE);

    return DefaultTabController(
      length: 3, // Có 3 tab trạng thái bài đăng
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F8),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Quản lý bài đăng',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelColor: primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: primaryColor,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: 'Đang hiển thị'),
              Tab(text: 'Chờ duyệt'),
              Tab(text: 'Đã ẩn'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: Đang hiển thị (Active)
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildPostCard(
                  title: 'Phòng trọ cao cấp Q.3, Full nội thất',
                  price: '4.500.000 đ/tháng',
                  address: '123 CMT8, P.10, Q.3, TP.HCM',
                  views: 124,
                  likes: 12,
                  status: 'Đang hiển thị',
                  statusColor: Colors.green,
                ),
              ],
            ),
            // Tab 2: Chờ duyệt (Pending)
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildPostCard(
                  title: 'Căn hộ mini mới xây Q.Tân Bình',
                  price: '5.000.000 đ/tháng',
                  address: '45 Cộng Hòa, P.4, Q.Tân Bình',
                  views: 0,
                  likes: 0,
                  status: 'Chờ admin duyệt',
                  statusColor: Colors.orange,
                ),
              ],
            ),
            // Tab 3: Đã ẩn / Bị từ chối
            const Center(
              child: Text('Không có bài đăng nào bị ẩn', style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }

  // Widget hiển thị từng thẻ bài đăng
  Widget _buildPostCard({
    required String title,
    required String price,
    required String address,
    required int views,
    required int likes,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Column(
        children: [
          // Phần thông tin chính
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://via.placeholder.com/150',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15), maxLines: 2, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Text(price, style: const TextStyle(color: Color(0xFF2B6CEE), fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Expanded(child: Text(address, style: const TextStyle(color: Colors.grey, fontSize: 12), overflow: TextOverflow.ellipsis)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          // Phần Footer (Trạng thái và Nút hành động)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Trạng thái và lượt xem
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(status, style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.remove_red_eye_outlined, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text('$views view', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        const SizedBox(width: 12),
                        const Icon(Icons.favorite_border, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text('$likes thích', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                // Nút Chỉnh sửa
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    minimumSize: const Size(0, 32),
                  ),
                  child: const Text('Tùy chỉnh', style: TextStyle(color: Colors.black87, fontSize: 12)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}