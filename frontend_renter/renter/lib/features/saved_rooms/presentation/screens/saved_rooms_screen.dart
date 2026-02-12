import 'package:flutter/material.dart';

class SavedRoomsScreen extends StatelessWidget {
  const SavedRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8), // background-light
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(),
            const SizedBox(height: 20),
            _buildSavedList(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white.withOpacity(0.9),
      elevation: 0.5,
      centerTitle: false,
      title: const Text(
        "Phòng đã lưu",
        style: TextStyle(
          color: Color(0xFF0D121B),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: Colors.black),
          onPressed: () {},
        ),
        const Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuAajLU1vro0qfn8-rCJkGEt5Uy9N2VIhd9n1aadZjHqW0ft_Y7p0en-vpT0rwEucbV_7TrhruaYs4pKHbKJ1Yo_6167IiNp48Hvk-sfHH_FENlypeEym1MySox9i-QmWMdqR0zsaVCXeGbqnzC4t5zwdZFwMtSsYl2zDHPRyisY1ZnFYYlangw3dbUWbjzWicPt_czNONwGTEBMOFu950uZVoed5GdZk_a8qhF-vJRwPmhHC8FYmXSJJ8EGxNWdp6AKxgGDbfWHNFU"), // avatar
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "3 phòng đã lưu", // Text từ file HTML
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Text(
            "Mới nhất",
            style: TextStyle(color: Color(0xFF2B6CEE), fontWeight: FontWeight.bold),
          ),
          label: const Icon(Icons.sort, color: Color(0xFF2B6CEE), size: 18),
        ),
      ],
    );
  }

  Widget _buildSavedList() {
    // Dữ liệu mẫu dựa trên renterphongtrodaluu.html
    final List<Map<String, String>> savedRooms = [
      {
        "title": "Căn hộ Studio Full nội thất",
        "price": "4.5 triệu/tháng",
        "location": "Ngõ 165 Cầu Giấy, Quan Hoa",
        "owner": "A. Tuấn Anh",
        "image": "https://lh3.googleusercontent.com/aida-public/AB6AXuDk6qSkfrcKwV537DEHKjUDv7CW5X8ZQrzpu6crELxu2DVoHIhKKY52mVy3OQ9_tPpOog5PezJ2WvZg_iAU82Jrqg_eYXEZCQ48QKj3hL9yn1T7N6_Cec0cUCCjV00_kCl1bJ0EI6LjKqR0ld4GH1r__BMx0AZ-7YnsCXOObsKe-kJtYLGXzmHhgkX3EqmJl_6krV91qruNPgCl5V8Sk_R4HhQdVjL007v0cBk_mkVUiudeFN9VictOMqjdr1JW61walV9N-3XAUBM"
      },
      {
        "title": "Phòng trọ khép kín gần ĐH Giao Thông",
        "price": "3.2 triệu/tháng",
        "location": "Số 10, Ngách 2, Láng Hạ, Đống Đa",
        "owner": "Chị Lan",
        "image": "https://lh3.googleusercontent.com/aida-public/AB6AXuC0XWFl0FASC2WPI_c9GI4tm0BAtXkydilMbvUMfuCLx5pQkbhAQRyuPhCSpTpo6FKCSp19hSx3RTES-OXTVXt2N0Plu3uQCrSEjPtFqSqtmthvd33bvhF4yWWjncY8z8WXwgRCw_Gsgsia0UP-167HxMtTzsZNtPPoJtbj_4KKRVbVcK0LwsyxKTf2X7W0Ba_pUjHzzlZVx9XqG-Ohe8Gy9ko0dHDjSr15_VLfwDHlXsIIQ7xNHBCrfpkrdXdpZAFSC6D-b4D6NlQ"
      },
      {
        "title": "Chung cư mini cao cấp - Đống Đa",
        "price": "5.0 triệu/tháng",
        "location": "123 Đường Láng, Phường Láng Thượng",
        "owner": "Cô Hạnh",
        "image": "https://lh3.googleusercontent.com/aida-public/AB6AXuB2lOh0PysHvIPu2HGuKHw0DS6b1CHfOtt1rXVOgIUT_sFfSleKR4eHlZaZhVZYEwN_sGrhEcYHWdEnOMn7EOHUx1oqP-2xQEJhnSEtat3eKq-aM9BHZ4JuAzdEzLkznYMaEhKTDOarFmCv98PhBSUshxGiDyJbC6gSbg3a3PMsF5M7ua-B-q-Bxr-mygXI5mlh8BkvxgEhSO-Z9bqSUynS3SpH1qTiQmgsB03lmidq7jG6aqR1-hbAoXVcTcVLQQVVUWNtOd-njM8"
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: savedRooms.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final room = savedRooms[index];
        return _buildSavedRoomCard(
          room['title']!,
          room['price']!,
          room['location']!,
          room['owner']!,
          room['image']!,
        );
      },
    );
  }

  Widget _buildSavedRoomCard(String title, String price, String location, String owner, String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // Nút Favorite luôn ở trạng thái Active (màu đỏ)
              Positioned(
                top: 12,
                right: 12,
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  radius: 18,
                  child: const Icon(Icons.favorite, size: 20, color: Colors.red),
                ),
              ),
              // Badge giá tiền
              Positioned(
                bottom: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.payments, color: Colors.white, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        price,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: const TextStyle(color: Colors.grey, fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(height: 1),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 12,
                          backgroundColor: Color(0xFFE2E8F0),
                          child: Icon(Icons.person, size: 14, color: Colors.grey),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          owner,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4A5568),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Chi tiết",
                        style: TextStyle(
                          color: Color(0xFF2B6CEE),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}