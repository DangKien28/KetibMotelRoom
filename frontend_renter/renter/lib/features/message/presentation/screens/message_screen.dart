import 'package:flutter/material.dart';
import 'detail_message_screen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8), // background-light
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Phần tiêu đề và tìm kiếm
          Container(
            color: const Color(0xFFF6F6F8),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tin nhắn",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0D121B),
                  ),
                ),
                const SizedBox(height: 16),
                _buildSearchBar(),
              ],
            ),
          ),
          // Danh sách tin nhắn
          Expanded(
            child: _buildMessageList(),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFF6F6F8).withOpacity(0.95),
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Row(
        children: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuAajLU1vro0qfn8-rCJkGEt5Uy9N2VIhd9n1aadZjHqW0ft_Y7p0en-vpT0rwEucbV_7TrhruaYs4pKHbKJ1Yo_6167IiNp48Hvk-sfHH_FENlypeEym1MySox9i-QmWMdqR0zsaVCXeGbqnzC4t5zwdZFwMtSsYl2zDHPRyisY1ZnFYYlangw3dbUWbjzWicPt_czNONwGTEBMOFu950uZVoed5GdZk_a8qhF-vJRwPmhHC8FYmXSJJ8EGxNWdp6AKxgGDbfWHNFU"),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              )
            ],
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
              onPressed: () {},
            ),
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

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Tìm kiếm tin nhắn...",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    // Dữ liệu giả lập
    final List<Map<String, dynamic>> messages = [
      {
        "name": "Cô Hạnh - Chủ nhà",
        "message": "Cháu ơi, cuối tuần này cô qua thu tiền nhà nhé!",
        "time": "10:30",
        "avatar": "https://lh3.googleusercontent.com/aida-public/AB6AXuCjC1iUUJBNo1oqh3M5_OFsZ9qhDFShhyotrz8hUf4yEosszw7_MNimHCD56OMb2wRX5tEcS-_sptHheo9whx0zNbljRGyewvex3Ksc3pZIdefs2oHqid5c--Lkub8uUqWOYkFDwXpeBNCJKWYET4GJu4YU9tErUjulpAMGidEp5vjFYjwi1Rjd_1bEtk2zm8gCRvqMynoKPPTB6-SOxEFShp-zde9TWC0kUa5aAufoFhPWhaubRHBq5_L_S9tiX9nz5ta64nqbN1A",
        "isOnline": true,
        "isUnread": true,
        "isSystem": false,
      },
      {
        "name": "A. Tuấn Anh",
        "message": "Ok em, anh đã nhận được cọc rồi nhé, có gì...",
        "time": "Hôm qua",
        "avatar": "https://lh3.googleusercontent.com/aida-public/AB6AXuCKhDl_uBuKhrhcrAClhkOZxkYC-to0LRoKWxDyMUzmjbco5Tw-9gSKtFSnDv83gNa11bsPIHqTENjyZQQ6ovnEMUjuFq_8Ph7YkqsiGxm3nfq4_mFjOBtKOrcQQfQb7ImGRd3ACNS-NgiypXiLu39rjJ5CQvPocTxH_S8UnjagmxY3z-KTys8EPXhE4XSGsoRl3lhw_VLh1NIfpl9CaDd04paXBP8h9yU1LFLFuSN4mK8fcWGYC5yfTF0aPXp3sSHDr8rXBC7tBCI",
        "isOnline": false,
        "isUnread": false,
        "isSystem": false,
      },
      {
        "name": "Chị Lan (Môi giới)",
        "message": "Em xem phòng lúc mấy giờ được để chị báo...",
        "time": "Thứ 2",
        "avatar": "https://lh3.googleusercontent.com/aida-public/AB6AXuAMC3BPbDlae4YFomGKr_KbJ6OqFgx1tCLQbIsZVVkQlJhT1K9dckaCC4mmmup7aDFKNK2sfEvCo8kkzeY1QbOakTbo9TiAQoQWTeXrUQgk-uKxF268vZ_T3MWpHVzIAJxw6S15KTJyFRmUHI0ycjS9ANCrB2jULE4TT7mi5ApNjCjt-wPwiYPf89ms89QaUmjHH2Ww1Y9Bs8LXWdkFRu9EIKXrYAxbyGf8o_06yMn6HFNGgFCJjqR_gM-lsV6u4H1A7bo8FiR2GWg",
        "isOnline": false,
        "isUnread": false,
        "isSystem": false,
      },
      {
        "name": "Hỗ trợ khách hàng",
        "message": "Chào mừng bạn đến với ứng dụng Thuê phòng...",
        "time": "01/06",
        "avatar": "", // System icon
        "isOnline": false,
        "isUnread": false,
        "isSystem": true,
      },
    ];

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: messages.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final msg = messages[index];
        // Truyền context vào hàm build item
        return _buildMessageItem(context, msg);
      },
    );
  }

  Widget _buildMessageItem(BuildContext context, Map<String, dynamic> msg) {
    bool isUnread = msg['isUnread'];
    bool isSystem = msg['isSystem'];

    // Bọc trong GestureDetector để xử lý sự kiện bấm
    return GestureDetector(
      onTap: () {
        // Điều hướng sang màn hình chi tiết
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailMessageScreen(
              userName: msg['name'],
              // Xử lý avatar cho trường hợp system hoặc user thường
              avatarUrl: isSystem 
                  ? "https://via.placeholder.com/150" // Hoặc icon url mặc định
                  : msg['avatar'],
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
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
        child: Row(
          children: [
            // Left Border Indicator (Nếu chưa đọc)
            if (isUnread)
              Container(
                width: 3,
                height: 40,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF2B6CEE),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

            // Avatar
            Stack(
              children: [
                if (isSystem)
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2B6CEE).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.support_agent, color: Color(0xFF2B6CEE), size: 28),
                  )
                else
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(msg['avatar']),
                  ),

                // Online Dot
                if (msg['isOnline'] == true)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  )
              ],
            ),
            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          msg['name'],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0D121B),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        msg['time'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                          color: isUnread ? const Color(0xFF2B6CEE) : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    msg['message'],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isUnread ? FontWeight.w600 : FontWeight.normal,
                      color: isUnread ? const Color(0xFF0D121B) : Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Unread Dot
            if (isUnread)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2B6CEE),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}