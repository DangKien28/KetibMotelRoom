import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  // --- COLOR CONSTANTS ---
  static const Color kPrimaryColor = Color(0xFF2B6CEE);
  static const Color kBackgroundColor = Color(0xFFF6F6F8);
  static const Color kSurfaceColor = Colors.white;
  static const Color kTextPrimary = Color(0xFF0F172A); // Slate 900
  static const Color kTextSecondary = Color(0xFF64748B); // Slate 500
  static const Color kBorderColor = Color(0xFFE2E8F0);

  // --- MOCK STRUCTURE (CHỈ CẤU TRÚC, KHÔNG DỮ LIỆU CỤ THỂ) ---
  // isUnread: true -> Hiện thanh xanh bên trái + chấm xanh
  // isOnline: true -> Hiện chấm xanh lá ở avatar
  // isSupport: true -> Hiện icon hỗ trợ thay vì avatar ảnh
  final List<Map<String, dynamic>> _messageStructure = [
    {'isUnread': true, 'isOnline': true, 'isSupport': false}, // Mô phỏng tin nhắn mới nhất
    {'isUnread': false, 'isOnline': false, 'isSupport': false}, // Tin nhắn thường
    {'isUnread': false, 'isOnline': false, 'isSupport': false}, // Tin nhắn thường
    {'isUnread': false, 'isOnline': true, 'isSupport': true},   // Tin nhắn từ CSKH
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildCustomHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      // Title
                      const Text(
                        "Tin nhắn",
                        style: TextStyle(
                          color: kTextPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Plus Jakarta Sans',
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Search Bar
                      _buildSearchBar(),
                      const SizedBox(height: 16),
                      // Message List
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _messageStructure.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          return _buildMessageItem(_messageStructure[index]);
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // 1. Header (Avatar + Greeting)
  Widget _buildCustomHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Avatar Placeholder
              Stack(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person, color: Colors.white), 
                    // TODO: Load User Avatar Image here
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: kSurfaceColor, width: 1.5),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Xin chào,",
                    style: TextStyle(color: kTextSecondary, fontSize: 12),
                  ),
                  Text(
                    "Tên người dùng", // Placeholder Name
                    style: TextStyle(
                      color: kTextPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Plus Jakarta Sans',
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Notification Bell
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none, size: 28, color: kTextPrimary),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  // 2. Search Bar
  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kBorderColor),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Tìm kiếm tin nhắn...",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  // 3. Message Item Frame
  Widget _buildMessageItem(Map<String, dynamic> config) {
    bool isUnread = config['isUnread'];
    bool isOnline = config['isOnline'];
    bool isSupport = config['isSupport'];

    return Container(
      height: 80, // Chiều cao cố định tương đối cho khung
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: kBorderColor.withOpacity(0.5)),
      ),
      // ClipRRect để cắt cái thanh màu xanh bên trái nếu có
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Hiệu ứng thanh xanh bên trái nếu chưa đọc (giống ảnh 1)
            if (isUnread)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: 4,
                child: Container(color: kPrimaryColor),
              ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  if (isUnread) const SizedBox(width: 4), // Padding nhẹ để tránh thanh xanh
                  
                  // Avatar Area
                  Stack(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: isSupport ? Colors.blue.shade50 : Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: isSupport 
                          ? const Icon(Icons.support_agent, color: kPrimaryColor, size: 28)
                          : const Icon(Icons.person, color: Colors.white, size: 28),
                          // TODO: Load User Image Here
                      ),
                      if (isOnline && !isSupport)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(color: kSurfaceColor, width: 2),
                            ),
                          ),
                        )
                    ],
                  ),
                  const SizedBox(width: 14),
                  
                  // Content Area
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Tên người gửi", // Placeholder
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: kTextPrimary,
                              ),
                            ),
                            Text(
                              isUnread ? "10:30" : "Hôm qua", // Placeholder Time
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                                color: isUnread ? kPrimaryColor : kTextSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Nội dung tin nhắn mô phỏng hiển thị ở đây...", // Placeholder Body
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isUnread ? kTextPrimary : kTextSecondary,
                                  fontWeight: isUnread ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ),
                            if (isUnread)
                              Container(
                                margin: const EdgeInsets.only(left: 8),
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: kPrimaryColor,
                                  shape: BoxShape.circle,
                                ),
                              )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 4. Bottom Nav (Visual only - Matching design)
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
        currentIndex: 2, // Đặt cứng là 2 (Tin nhắn) để giống ảnh
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
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: "Cá nhân",
          ),
        ],
        onTap: (index) {},
      ),
    );
  }
}