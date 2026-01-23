import 'package:flutter/material.dart';

class SavedRoomsScreen extends StatefulWidget {
  const SavedRoomsScreen({super.key});

  @override
  State<SavedRoomsScreen> createState() => _SavedRoomsScreenState();
}

class _SavedRoomsScreenState extends State<SavedRoomsScreen> {
  // --- COLOR CONSTANTS (Theo HTML/Design) ---
  static const Color kPrimaryColor = Color(0xFF2B6CEE);
  static const Color kBackgroundColor = Color(0xFFF6F6F8);
  static const Color kSurfaceColor = Colors.white;
  static const Color kTextPrimary = Color(0xFF0F172A); // Slate 900
  static const Color kTextSecondary = Color(0xFF64748B); // Slate 500
  static const Color kDangerColor = Color(0xFFEF4444); // Red 500

  // --- MOCK STRUCTURE (Khung chứa dữ liệu) ---
  // Dùng để tạo vòng lặp hiển thị danh sách
  final List<Map<String, dynamic>> _savedRooms = [
    {'id': 1}, 
    {'id': 2}, 
    {'id': 3},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Sub-header (Số lượng & Bộ lọc)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${_savedRooms.length} phòng đã lưu", // Placeholder count
                  style: const TextStyle(
                    color: kTextSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: const [
                      Text(
                        "Mới nhất",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.sort, color: kPrimaryColor, size: 20),
                    ],
                  ),
                )
              ],
            ),
          ),
          
          // List Cards
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _savedRooms.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return _buildRoomCard();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // 1. App Bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      title: const Text(
        "Phòng đã lưu",
        style: TextStyle(
          color: kTextPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w800,
          fontFamily: 'Plus Jakarta Sans',
        ),
      ),
      centerTitle: false,
      actions: [
        // Notification Icon
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none, color: kTextPrimary, size: 28),
              onPressed: () {},
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: kDangerColor,
                  shape: BoxShape.circle,
                  border: Border.fromBorderSide(BorderSide(color: kBackgroundColor, width: 2)),
                ),
              ),
            )
          ],
        ),
        // Avatar
        Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 8.0),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(Icons.person, color: Colors.orange),
            // TODO: Load User Avatar Image
          ),
        ),
      ],
    );
  }

  // 2. Room Card Component
  Widget _buildRoomCard() {
    return Container(
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top: Image & Overlay Tags
          Stack(
            children: [
              // Image Placeholder
              Container(
                height: 180,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.image, size: 50, color: Colors.white54),
                // TODO: Replace with Image.network(url)
              ),
              
              // Favorite Button (Top Right)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                      )
                    ],
                  ),
                  child: const Icon(Icons.favorite, color: kDangerColor, size: 20),
                ),
              ),

              // Price Tag (Bottom Left)
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
                    children: const [
                      Icon(Icons.payments, color: Colors.white, size: 14),
                      SizedBox(width: 4),
                      Text(
                        "Giá thuê mẫu/tháng", // Placeholder Price
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Bottom: Info
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const Text(
                  "Tiêu đề phòng trọ mẫu hiển thị ở đây", // Placeholder Title
                  style: TextStyle(
                    color: kTextPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Plus Jakarta Sans',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                
                // Address
                Row(
                  children: const [
                    Icon(Icons.location_on, size: 16, color: kTextSecondary),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "Địa chỉ chi tiết mẫu...", // Placeholder Address
                        style: TextStyle(color: kTextSecondary, fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFE2E8F0)), // Slate 200
                const SizedBox(height: 12),

                // Landlord & Action
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Landlord Info
                    Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            shape: BoxShape.circle,
                          ),
                          // TODO: Landlord Avatar
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "Tên chủ trọ", // Placeholder Landlord Name
                          style: TextStyle(
                            color: kTextPrimary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    
                    // Detail Link
                    InkWell(
                      onTap: () {
                        // Navigate to Detail Screen
                      },
                      child: const Text(
                        "Chi tiết",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 3. Bottom Nav (Visual only - Matching design)
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
        currentIndex: 1, // Đặt cứng là 1 (Đã lưu)
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
            icon: Icon(Icons.favorite), // Filled icon for active state
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