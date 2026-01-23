import 'package:flutter/material.dart';

class RentalHistoryScreen extends StatefulWidget {
  const RentalHistoryScreen({super.key});

  @override
  State<RentalHistoryScreen> createState() => _RentalHistoryScreenState();
}

class _RentalHistoryScreenState extends State<RentalHistoryScreen> {
  // --- COLOR CONSTANTS (Theo HTML/Design) ---
  static const Color kPrimaryColor = Color(0xFF2B6CEE);
  static const Color kBackgroundColor = Color(0xFFF6F6F8);
  static const Color kSurfaceColor = Colors.white;
  static const Color kTextPrimary = Color(0xFF0F172A); // Slate 900
  static const Color kTextSecondary = Color(0xFF64748B); // Slate 500
  static const Color kSuccessColor = Color(0xFF22C55E); // Green 500
  static const Color kSuccessBg = Color(0xFFF0FDF4); // Green 50

  // --- MOCK STRUCTURE (Khung dữ liệu mẫu) ---
  // status: 'active' (Đang thuê) hoặc 'completed' (Đã hoàn tất)
  final List<Map<String, dynamic>> _historyItems = [
    {'id': 1, 'status': 'active'},    // Mô phỏng phòng đang thuê
    {'id': 2, 'status': 'completed'}, // Mô phỏng phòng đã trả
    {'id': 3, 'status': 'completed'}, // Mô phỏng phòng đã trả
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSummaryStats(),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              itemCount: _historyItems.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return _buildHistoryCard(_historyItems[index]);
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
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: kTextPrimary),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        "Lịch sử thuê trọ",
        style: TextStyle(
          color: kTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Plus Jakarta Sans',
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_list, color: kTextPrimary),
          onPressed: () {},
        ),
      ],
    );
  }

  // 2. Summary Stats (3 Đã thuê - 1 Đang ở)
  Widget _buildSummaryStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildStatCard("3", "Đã thuê", kPrimaryColor),
          const SizedBox(width: 12),
          _buildStatCard("1", "Đang ở", kSuccessColor),
        ],
      ),
    );
  }

  Widget _buildStatCard(String count, String label, Color countColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: kSurfaceColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.01),
              blurRadius: 4,
            )
          ],
        ),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                color: countColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Plus Jakarta Sans',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: kTextSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 3. Rental History Card
  Widget _buildHistoryCard(Map<String, dynamic> item) {
    bool isActive = item['status'] == 'active';

    return Container(
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Name & Status Badge
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Tên phòng / Căn hộ", // Placeholder
                        style: TextStyle(
                          color: kTextPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Plus Jakarta Sans',
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Mã hợp đồng: #HDxxxx-xxx", // Placeholder
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isActive ? kSuccessBg : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isActive ? kSuccessColor.withOpacity(0.2) : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    isActive ? "● ĐANG THUÊ" : "ĐÃ HOÀN TẤT",
                    style: TextStyle(
                      color: isActive ? kSuccessColor : kTextSecondary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Body: Info Rows
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildInfoRow(Icons.location_on, "Địa chỉ", "Địa chỉ chi tiết hiển thị ở đây..."),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.calendar_month, "Thời gian thuê", "dd/mm/yyyy - Hiện tại"),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.payments, "Giá thuê", "0.000.000đ/tháng", isPrice: true),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Footer Action
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isActive ? kSuccessBg.withOpacity(0.5) : Colors.grey.shade50,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
              border: Border(top: BorderSide(color: Colors.grey.shade100)),
            ),
            child: Row(
              mainAxisAlignment: isActive ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
              children: [
                if (isActive)
                  const Text(
                    "Đến hạn thanh toán: dd/mm/yyyy",
                    style: TextStyle(fontSize: 12, color: kTextSecondary, fontWeight: FontWeight.w500),
                  ),
                
                InkWell(
                  onTap: () {},
                  child: Text(
                    isActive ? "Xem chi tiết" : "Xem hóa đơn cũ",
                    style: TextStyle(
                      color: isActive ? kPrimaryColor : kTextSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, {bool isPrice = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: kTextSecondary, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 11, color: kTextSecondary),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isPrice ? FontWeight.bold : FontWeight.w500,
                  color: isPrice ? kTextPrimary : kTextPrimary.withOpacity(0.9),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 4. Bottom Nav (Visual only)
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
        currentIndex: 3, // Giả lập tab Cá nhân (Profile) active vì màn này thường nằm trong Profile
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.grey.shade400,
        selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
        unselectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Tìm phòng",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: "Đã lưu",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: "Tin nhắn",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Cá nhân",
          ),
        ],
        onTap: (index) {},
      ),
    );
  }
}