import 'package:flutter/material.dart';
import '../../../../core/constants/ketib_AppColors.dart';
import '../../../../core/widgets/ketib_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Index cho BottomNavBar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // --- HEADER & BODY (Cuộn được) ---
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0), // Padding chuẩn px-6
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 24),
                    
                    _buildSectionTitle("Nơi ở hiện tại", showAction: true),
                    const SizedBox(height: 12),
                    _buildCurrentRoomCard(),
                    
                    const SizedBox(height: 32),
                    _buildSectionTitle("Tìm phòng trọ mới"),
                    const SizedBox(height: 12),
                    _buildSearchSection(),

                    const SizedBox(height: 32),
                    _buildSectionTitle("Phòng trọ phù hợp", showFilter: true),
                    const SizedBox(height: 12),
                    _buildRoomList(),
                  ],
                ),
              ),
            ),
            
            // --- BOTTOM NAVIGATION BAR ---
            _buildBottomNavBar(),
          ],
        ),
      ),
    );
  }

  // 1. Header: Avatar + Xin chào + Notification
  Widget _buildHeader() {
    return Row(
      children: [
        // Avatar Placeholder
        Stack(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.grey, // Placeholder màu xám
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, color: Colors.white),
            ),
            // Status Dot
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: AppColors.success,
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
             Text(
              "Xin chào,",
              style: TextStyle(fontSize: 12, color: AppColors.textLight),
            ),
             Text(
              "", // TÊN NGƯỜI DÙNG ĐỂ TRỐNG
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textMain),
            ),
          ],
        ),
        const Spacer(),
        // Notification Button
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined, color: AppColors.textMain),
              onPressed: () {},
            ),
            Positioned(
              right: 8,
              top: 8,
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
        )
      ],
    );
  }

  // 2. Section Title (Tiêu đề các mục)
  Widget _buildSectionTitle(String title, {bool showAction = false, bool showFilter = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textMain,
          ),
        ),
        if (showAction)
          TextButton(
            onPressed: () {},
            child: const Text("Chi tiết", style: TextStyle(color: AppColors.primary)),
          ),
        if (showFilter)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.inputBorder),
            ),
            child: const Icon(Icons.tune, size: 20, color: AppColors.textLight),
          )
      ],
    );
  }

  // 3. Current Room Card (Thẻ nơi ở hiện tại)
  Widget _buildCurrentRoomCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Image Area
          Container(
            height: 140,
            decoration: const BoxDecoration(
              color: Colors.grey, // IMAGE PLACEHOLDER
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Stack(
              children: [
                // Gradient Overlay
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                    ),
                  ),
                ),
                // Content Overlay
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "", // HẠN HỢP ĐỒNG ĐỂ TRỐNG
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppColors.success.withOpacity(0.5)),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.circle, size: 8, color: AppColors.success),
                                SizedBox(width: 4),
                                Text(
                                  "Đang thuê",
                                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "", // TÊN PHÒNG ĐỂ TRỐNG
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Details Area
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: const [
                    Icon(Icons.location_on_outlined, color: AppColors.textLight, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "", // ĐỊA CHỈ ĐỂ TRỐNG
                        style: TextStyle(color: AppColors.textMain, fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(height: 1, color: AppColors.inputBorder),
                const SizedBox(height: 16),
                Row(
                  children: [
                    // Avatar Chủ nhà
                    Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Colors.grey, // PLACEHOLDER
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Chủ nhà", style: TextStyle(fontSize: 10, color: AppColors.textLight)),
                        Text(
                          "", // TÊN CHỦ NHÀ ĐỂ TRỐNG
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Nút Liên hệ
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.chat_bubble, size: 16),
                      label: const Text("Liên hệ"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(color: Colors.transparent),
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // 4. Search Section (Khung tìm kiếm)
  Widget _buildSearchSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDropdownInput("KHU VỰC", Icons.map_outlined),
          const SizedBox(height: 16),
          _buildDropdownInput("KHOẢNG GIÁ", Icons.payments_outlined),
          const SizedBox(height: 20),
          KetibButton(
            text: "Tìm trọ ngay",
            icon: Icons.search,
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget _buildDropdownInput(String label, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: AppColors.textLight,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 20),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  "", // GIÁ TRỊ DROPDOWN ĐỂ TRỐNG
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: AppColors.textLight),
            ],
          ),
        ),
      ],
    );
  }

  // 5. Room List (Danh sách phòng)
  Widget _buildRoomList() {
    return Column(
      children: [
        // Tạo 2 item mẫu nhưng rỗng dữ liệu
        _buildRoomItem(),
        const SizedBox(height: 16),
        _buildRoomItem(),
      ],
    );
  }

  Widget _buildRoomItem() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Stack(
            children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.grey, // IMAGE PLACEHOLDER
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
              ),
              // Tag Mới đăng
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "MỚI ĐĂNG",
                    style: TextStyle(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // Fav Button
              Positioned(
                top: 12,
                right: 12,
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  radius: 16,
                  child: const Icon(Icons.favorite_border, size: 18, color: AppColors.textLight),
                ),
              ),
              // Price Tag
              Positioned(
                bottom: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(color: AppColors.primary.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 4))
                    ]
                  ),
                  child: const Text(
                    "", // GIÁ TIỀN ĐỂ TRỐNG
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              )
            ],
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "", // TIÊU ĐỀ PHÒNG ĐỂ TRỐNG
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textMain),
                ),
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Icon(Icons.location_on_outlined, size: 16, color: AppColors.textLight),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "", // ĐỊA CHỈ ĐỂ TRỐNG
                        style: TextStyle(fontSize: 12, color: AppColors.textLight),
                        maxLines: 1, overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: AppColors.inputBorder),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 24, height: 24,
                          decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "", // TÊN CHỦ NHÀ ITEM ĐỂ TRỐNG
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const Text(
                      "", // THỜI GIAN ĐĂNG ĐỂ TRỐNG
                      style: TextStyle(fontSize: 10, color: AppColors.textLight),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // 6. Bottom Navigation Bar
  Widget _buildBottomNavBar() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.inputBorder)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, "Trang chủ", 0),
          _buildNavItem(Icons.favorite_border, "Đã lưu", 1),
          _buildNavItem(Icons.chat_bubble_outline, "Tin nhắn", 2),
          _buildNavItem(Icons.person_outline, "Cá nhân", 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.primary : AppColors.textLight,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? AppColors.primary : AppColors.textLight,
            ),
          )
        ],
      ),
    );
  }
}