import 'package:flutter/material.dart';

class RentalHistoryScreen extends StatefulWidget {
  const RentalHistoryScreen({super.key});

  @override
  State<RentalHistoryScreen> createState() => _RentalHistoryScreenState();
}

class _RentalHistoryScreenState extends State<RentalHistoryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8), // background-light
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildHistoryList("all"),      // Tất cả
                _buildHistoryList("active"),   // Đang thuê
                _buildHistoryList("expired"),  // Đã kết thúc
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        "Lịch sử thuê trọ",
        style: TextStyle(
          color: Color(0xFF0D121B),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: const Color(0xFF2B6CEE),
        unselectedLabelColor: Colors.grey,
        indicatorColor: const Color(0xFF2B6CEE),
        indicatorWeight: 3,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        tabs: const [
          Tab(text: "Tất cả"),
          Tab(text: "Đang thuê"),
          Tab(text: "Đã kết thúc"),
        ],
      ),
    );
  }

  Widget _buildHistoryList(String filter) {
    // Dữ liệu giả lập
    final List<Map<String, dynamic>> historyData = [
      {
        "id": "1",
        "title": "Phòng 302 - Nhà cô Hạnh",
        "address": "123 Đường Láng, Đống Đa, Hà Nội",
        "price": "4.500.000đ",
        "status": "active", // active, expired, cancelled
        "period": "01/2024 - 12/2024",
        "image": "https://lh3.googleusercontent.com/aida-public/AB6AXuB2lOh0PysHvIPu2HGuKHw0DS6b1CHfOtt1rXVOgIUT_sFfSleKR4eHlZaZhVZYEwN_sGrhEcYHWdEnOMn7EOHUx1oqP-2xQEJhnSEtat3eKq-aM9BHZ4JuAzdEzLkznYMaEhKTDOarFmCv98PhBSUshxGiDyJbC6gSbg3a3PMsF5M7ua-B-q-Bxr-mygXI5mlh8BkvxgEhSO-Z9bqSUynS3SpH1qTiQmgsB03lmidq7jG6aqR1-hbAoXVcTcVLQQVVUWNtOd-njM8",
        "landlord": "Cô Hạnh"
      },
      {
        "id": "2",
        "title": "Căn hộ Studio - Cầu Giấy",
        "address": "Ngõ 165 Cầu Giấy, Quan Hoa",
        "price": "3.800.000đ",
        "status": "expired",
        "period": "06/2023 - 12/2023",
        "image": "https://lh3.googleusercontent.com/aida-public/AB6AXuDk6qSkfrcKwV537DEHKjUDv7CW5X8ZQrzpu6crELxu2DVoHIhKKY52mVy3OQ9_tPpOog5PezJ2WvZg_iAU82Jrqg_eYXEZCQ48QKj3hL9yn1T7N6_Cec0cUCCjV00_kCl1bJ0EI6LjKqR0ld4GH1r__BMx0AZ-7YnsCXOObsKe-kJtYLGXzmHhgkX3EqmJl_6krV91qruNPgCl5V8Sk_R4HhQdVjL007v0cBk_mkVUiudeFN9VictOMqjdr1JW61walV9N-3XAUBM",
        "landlord": "A. Tuấn Anh"
      },
      {
        "id": "3",
        "title": "Phòng trọ giá rẻ - Đê La Thành",
        "address": "Ngõ 898 Đê La Thành, Đống Đa",
        "price": "2.500.000đ",
        "status": "expired",
        "period": "01/2023 - 05/2023",
        "image": "https://via.placeholder.com/150",
        "landlord": "Chị Lan"
      },
    ];

    // Lọc dữ liệu theo tab
    List<Map<String, dynamic>> filteredList = [];
    if (filter == "all") {
      filteredList = historyData;
    } else {
      filteredList = historyData.where((item) => item['status'] == filter).toList();
    }

    if (filteredList.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: filteredList.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return _buildHistoryCard(filteredList[index]);
      },
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> item) {
    bool isActive = item['status'] == 'active';
    Color statusColor = isActive ? const Color(0xFF10B981) : Colors.grey; // Xanh lá hoặc Xám
    String statusText = isActive ? "ĐANG THUÊ" : "ĐÃ KẾT THÚC";

    return Container(
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
          // Header: Ngày tháng & Trạng thái
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(
                      item['period'],
                      style: const TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          const Divider(height: 1),
          // Body: Ảnh & Thông tin
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item['image'],
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0D121B)),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['address'],
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.person, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text("Chủ nhà: ${item['landlord']}", style: const TextStyle(fontSize: 12, color: Colors.black54)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${item['price']}/tháng",
                        style: const TextStyle(color: Color(0xFF2B6CEE), fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          // Footer: Actions
          if (!isActive) // Chỉ hiện nút cho hợp đồng đã kết thúc
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text("Thuê lại", style: TextStyle(color: Colors.black87)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2B6CEE),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text("Đánh giá", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          if (isActive)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.receipt_long, size: 16),
                  label: const Text("Xem hợp đồng"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF2B6CEE),
                    side: const BorderSide(color: Color(0xFF2B6CEE)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history_toggle_off, size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          const Text("Chưa có lịch sử thuê", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}