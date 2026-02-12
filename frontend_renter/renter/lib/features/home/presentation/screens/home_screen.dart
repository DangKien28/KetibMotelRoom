import 'package:flutter/material.dart';
import 'room_detail_screen.dart';
import '../../../notification/presentation/screens/notification_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8), // background-light
      // Truyền context vào _buildAppBar để dùng Navigator
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader("Nơi ở hiện tại", onDetailTap: () {}),
            const SizedBox(height: 12),
            _buildCurrentResidence(),
            const SizedBox(height: 24),
            const Text(
              "Tìm phòng trọ mới",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildSearchFilter(),
            const SizedBox(height: 24),
            _buildSectionHeader("Phòng trọ phù hợp", hasFilterIcon: true),
            const SizedBox(height: 16),
            _buildRoomList(context), // Truyền context để điều hướng chi tiết phòng
          ],
        ),
      ),
    );
  }

  // --- WIDGETS CON ---

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white.withOpacity(0.9),
      elevation: 0.5,
      scrolledUnderElevation: 0,
      title: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuAajLU1vro0qfn8-rCJkGEt5Uy9N2VIhd9n1aadZjHqW0ft_Y7p0en-vpT0rwEucbV_7TrhruaYs4pKHbKJ1Yo_6167IiNp48Hvk-sfHH_FENlypeEym1MySox9i-QmWMdqR0zsaVCXeGbqnzC4t5zwdZFwMtSsYl2zDHPRyisY1ZnFYYlangw3dbUWbjzWicPt_czNONwGTEBMOFu950uZVoed5GdZk_a8qhF-vJRwPmhHC8FYmXSJJ8EGxNWdp6AKxgGDbfWHNFU"),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Xin chào,", style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text("Minh Tú", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
            ],
          ),
        ],
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined, color: Colors.black),
              onPressed: () {
                // Điều hướng sang màn hình Thông báo khi bấm chuông
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotificationScreen()),
                );
              },
            ),
            // Chấm đỏ thông báo
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onDetailTap, bool hasFilterIcon = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        if (onDetailTap != null)
          TextButton(
            onPressed: onDetailTap,
            child: const Text("Chi tiết", style: TextStyle(color: Color(0xFF2B6CEE))),
          ),
        if (hasFilterIcon)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: const Icon(Icons.tune, size: 20, color: Colors.grey),
          ),
      ],
    );
  }

  Widget _buildCurrentResidence() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 140,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  image: DecorationImage(
                    image: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuB2lOh0PysHvIPu2HGuKHw0DS6b1CHfOtt1rXVOgIUT_sFfSleKR4eHlZaZhVZYEwN_sGrhEcYHWdEnOMn7EOHUx1oqP-2xQEJhnSEtat3eKq-aM9BHZ4JuAzdEzLkznYMaEhKTDOarFmCv98PhBSUshxGiDyJbC6gSbg3a3PMsF5M7ua-B-q-Bxr-mygXI5mlh8BkvxgEhSO-Z9bqSUynS3SpH1qTiQmgsB03lmidq7jG6aqR1-hbAoXVcTcVLQQVVUWNtOd-njM8"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Hợp đồng đến 12/2024", style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w500)),
                        SizedBox(height: 2),
                        Text("Phòng 302 - Nhà cô Hạnh", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.green.withOpacity(0.5)),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.circle, size: 8, color: Colors.greenAccent),
                          SizedBox(width: 4),
                          Text("Đang thuê", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 10,
                          backgroundImage: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuCjC1iUUJBNo1oqh3M5_OFsZ9qhDFShhyotrz8hUf4yEosszw7_MNimHCD56OMb2wRX5tEcS-_sptHheo9whx0zNbljRGyewvex3Ksc3pZIdefs2oHqid5c--Lkub8uUqWOYkFDwXpeBNCJKWYET4GJu4YU9tErUjulpAMGidEp5vjFYjwi1Rjd_1bEtk2zm8gCRvqMynoKPPTB6-SOxEFShp-zde9TWC0kUa5aAufoFhPWhaubRHBq5_L_S9tiX9nz5ta64nqbN1A"),
                        ),
                        const SizedBox(width: 6),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Chủ nhà", style: TextStyle(fontSize: 10, color: Colors.grey)),
                            Text("Cô Hạnh", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                    Container(height: 24, width: 1, color: Colors.grey.shade200),
                    Row(
                      children: const [
                        Icon(Icons.calendar_month, size: 16, color: Colors.orange),
                        SizedBox(width: 4),
                        Text("Đã ở: 8 tháng", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 18, color: Colors.grey),
                    const SizedBox(width: 6),
                    const Expanded(
                      child: Text(
                        "123 Đường Láng, Đống Đa, Hà Nội",
                        style: TextStyle(fontSize: 13, color: Color(0xFF4B5563), fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2B6CEE).withOpacity(0.1),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      icon: const Icon(Icons.chat_bubble, size: 16, color: Color(0xFF2B6CEE)),
                      label: const Text("Liên hệ", style: TextStyle(color: Color(0xFF2B6CEE), fontSize: 12, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSearchFilter() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8)],
      ),
      child: Column(
        children: [
          _buildDropdownField("Khu vực", "Quận Cầu Giấy, Hà Nội", Icons.map),
          const SizedBox(height: 16),
          _buildDropdownField("Khoảng giá", "3 - 5 triệu / tháng", Icons.payments),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2B6CEE),
                elevation: 4,
                shadowColor: const Color(0xFF2B6CEE).withOpacity(0.4),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.search, color: Colors.white),
                  SizedBox(width: 8),
                  Text("Tìm trọ ngay", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDropdownField(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF6F6F8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: const Color(0xFF2B6CEE)),
              const SizedBox(width: 12),
              Expanded(child: Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF0D121B)))),
              const Icon(Icons.expand_more, color: Colors.grey),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildRoomList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return _buildRoomCard(
          context,
          index == 0 ? "Căn hộ Studio Full nội thất - Cầu Giấy" : "Phòng trọ khép kín gần ĐH Giao Thông",
          index == 0 ? "A. Tuấn Anh" : "Chị Lan",
          index == 0 ? "4.5 tr" : "3.2 tr",
          index == 0 ? "6 tháng trước" : "3 tháng trước",
          index == 0 ? "https://lh3.googleusercontent.com/aida-public/AB6AXuDk6qSkfrcKwV537DEHKjUDv7CW5X8ZQrzpu6crELxu2DVoHIhKKY52mVy3OQ9_tPpOog5PezJ2WvZg_iAU82Jrqg_eYXEZCQ48QKj3hL9yn1T7N6_Cec0cUCCjV00_kCl1bJ0EI6LjKqR0ld4GH1r__BMx0AZ-7YnsCXOObsKe-kJtYLGXzmHhgkX3EqmJl_6krV91qruNPgCl5V8Sk_R4HhQdVjL007v0cBk_mkVUiudeFN9VictOMqjdr1JW61walV9N-3XAUBM" : "https://lh3.googleusercontent.com/aida-public/AB6AXuC0XWFl0FASC2WPI_c9GI4tm0BAtXkydilMbvUMfuCLx5pQkbhAQRyuPhCSpTpo6FKCSp19hSx3RTES-OXTVXt2N0Plu3uQCrSEjPtFqSqtmthvd33bvhF4yWWjncY8z8WXwgRCw_Gsgsia0UP-167HxMtTzsZNtPPoJtbj_4KKRVbVcK0LwsyxKTf2X7W0Ba_pUjHzzlZVx9XqG-Ohe8Gy9ko0dHDjSr15_VLfwDHlXsIIQ7xNHBCrfpkrdXdpZAFSC6D-b4D6NlQ",
          index == 0 ? "https://lh3.googleusercontent.com/aida-public/AB6AXuCKhDl_uBuKhrhcrAClhkOZxkYC-to0LRoKWxDyMUzmjbco5Tw-9gSKtFSnDv83gNa11bsPIHqTENjyZQQ6ovnEMUjuFq_8Ph7YkqsiGxm3nfq4_mFjOBtKOrcQQfQb7ImGRd3ACNS-NgiypXiLu39rjJ5CQvPocTxH_S8UnjagmxY3z-KTys8EPXhE4XSGsoRl3lhw_VLh1NIfpl9CaDd04paXBP8h9yU1LFLFuSN4mK8fcWGYC5yfTF0aPXp3sSHDr8rXBC7tBCI" : "https://lh3.googleusercontent.com/aida-public/AB6AXuAMC3BPbDlae4YFomGKr_KbJ6OqFgx1tCLQbIsZVVkQlJhT1K9dckaCC4mmmup7aDFKNK2sfEvCo8kkzeY1QbOakTbo9TiAQoQWTeXrUQgk-uKxF268vZ_T3MWpHVzIAJxw6S15KTJyFRmUHI0ycjS9ANCrB2jULE4TT7mi5ApNjCjt-wPwiYPf89ms89QaUmjHH2Ww1Y9Bs8LXWdkFRu9EIKXrYAxbyGf8o_06yMn6HFNGgFCJjqR_gM-lsV6u4H1A7bo8FiR2GWg",
        );
      },
    );
  }

  Widget _buildRoomCard(
      BuildContext context,
      String title,
      String owner,
      String price,
      String time,
      String imageUrl,
      String ownerAvatarUrl
  ) {
    return GestureDetector(
      onTap: () {
        // Điều hướng sang màn hình Chi tiết phòng trọ
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoomDetailScreen(
              title: title,
              price: price,
            ),
          ),
        );
      },
      child: Container(
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
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)],
                    ),
                    child: const Text("MỚI ĐĂNG", style: TextStyle(color: Color(0xFF2B6CEE), fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite_border, size: 20, color: Colors.grey),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2B6CEE),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [BoxShadow(color: const Color(0xFF2B6CEE).withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 4))],
                    ),
                    child: Text("$price/tháng", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0D121B))),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          title.contains("Cầu Giấy") ? "Ngõ 165 Cầu Giấy, Quan Hoa" : "Số 10, Ngách 2, Láng Hạ",
                          style: const TextStyle(color: Colors.grey, fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundImage: NetworkImage(ownerAvatarUrl),
                          ),
                          const SizedBox(width: 6),
                          Text(owner, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF4B5563))),
                        ],
                      ),
                      Text(time, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}