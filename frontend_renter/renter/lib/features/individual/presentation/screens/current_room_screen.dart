import 'package:flutter/material.dart';

class CurrentRoomInfoScreen extends StatefulWidget {
  const CurrentRoomInfoScreen({super.key});

  @override
  State<CurrentRoomInfoScreen> createState() => _CurrentRoomInfoScreenState();
}

class _CurrentRoomInfoScreenState extends State<CurrentRoomInfoScreen> {
  // --- COLOR CONSTANTS ---
  static const Color kPrimaryColor = Color(0xFF2B6CEE);
  static const Color kBackgroundColor = Color(0xFFF6F6F8);
  static const Color kSurfaceColor = Colors.white;
  static const Color kTextPrimary = Color(0xFF0F172A);
  static const Color kTextSecondary = Color(0xFF64748B);
  static const Color kDangerColor = Color(0xFFDC2626); // Red 600
  static const Color kDangerBg = Color(0xFFFEF2F2); // Red 50

  // --- MOCK AMENITIES (Khung tiện ích) ---
  final List<Map<String, dynamic>> _amenities = [
    {'icon': Icons.wifi, 'label': 'Tiện ích 1'},
    {'icon': Icons.ac_unit, 'label': 'Tiện ích 2'},
    {'icon': Icons.local_parking, 'label': 'Tiện ích 3'},
    {'icon': Icons.kitchen, 'label': 'Tiện ích 4'},
    {'icon': Icons.local_laundry_service, 'label': 'Tiện ích 5'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildHeroSection(),
            const SizedBox(height: 12),
            _buildStatsGrid(),
            const SizedBox(height: 12),
            _buildContractSection(),
            const SizedBox(height: 12),
            _buildLandlordSection(),
            const SizedBox(height: 12),
            _buildAmenitiesSection(),
            const SizedBox(height: 24),
            _buildReportButton(),
            const SizedBox(height: 16),
            const Text(
              "Thông tin được cập nhật lần cuối: dd/mm/yyyy",
              style: TextStyle(color: kTextSecondary, fontSize: 11),
            ),
            const SizedBox(height: 40),
          ],
        ),
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
        "Thông tin phòng trọ",
        style: TextStyle(
          color: kTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Plus Jakarta Sans',
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: kTextPrimary),
          onPressed: () {},
        ),
      ],
    );
  }

  // 2. Hero Section (Image + Title + Address)
  Widget _buildHeroSection() {
    return Container(
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Area
          Stack(
            children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.image, size: 60, color: Colors.white),
                // TODO: Replace with Image.network
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981), // Emerald 500
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Đang thuê",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Title
          const Text(
            "Tên phòng trọ / Căn hộ", // Placeholder
            style: TextStyle(
              color: kTextPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Plus Jakarta Sans',
            ),
          ),
          const SizedBox(height: 8),
          // Address
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Icon(Icons.location_on, color: kPrimaryColor, size: 20),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  "Địa chỉ chi tiết hiển thị ở đây...", // Placeholder
                  style: TextStyle(color: kTextSecondary, fontSize: 13, height: 1.4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 3. Stats Grid (Price & Duration)
  Widget _buildStatsGrid() {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            icon: Icons.payments,
            label: "GIÁ THUÊ",
            value: "0.000.000đ",
            subValue: "/tháng",
            valueColor: kPrimaryColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInfoCard(
            icon: Icons.calendar_month, // or calendar_clock
            label: "THỜI HẠN",
            value: "XX Tháng",
            valueColor: kTextPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
    String? subValue,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: kTextSecondary),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: kTextSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: TextStyle(
                    color: valueColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Plus Jakarta Sans',
                  ),
                ),
                if (subValue != null)
                  TextSpan(
                    text: subValue,
                    style: const TextStyle(
                      color: kTextSecondary,
                      fontSize: 11,
                      fontFamily: 'Plus Jakarta Sans',
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 4. Contract Details
  Widget _buildContractSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "CHI TIẾT HỢP ĐỒNG",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: kTextPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF), // Blue 50
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  "#HD-xxxx-xxx", // Placeholder
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildContractRow("Ngày bắt đầu", "dd/mm/yyyy"),
          const SizedBox(height: 12),
          _buildContractRow("Ngày kết thúc", "dd/mm/yyyy"),
          const SizedBox(height: 12),
          _buildContractRow("Kỳ thanh toán", "Ngày xx hàng tháng"),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Tiền cọc",
                style: TextStyle(color: kTextSecondary, fontSize: 13),
              ),
              Text(
                "0.000.000đ", // Placeholder
                style: TextStyle(
                  color: kTextPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContractRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: kTextSecondary, fontSize: 13),
        ),
        Text(
          value,
          style: const TextStyle(
            color: kTextPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // 5. Landlord Info
  Widget _buildLandlordSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "THÔNG TIN CHỦ TRỌ",
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: kTextSecondary),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              // Avatar
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 2)],
                ),
                alignment: Alignment.center,
                child: const Text(
                  "A", // Placeholder Letter
                  style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Tên chủ trọ", // Placeholder
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: kTextPrimary),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: const [
                        Icon(Icons.verified, color: kPrimaryColor, size: 14),
                        SizedBox(width: 4),
                        Text(
                          "Chủ nhà uy tín",
                          style: TextStyle(color: kTextSecondary, fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _buildCircleButton(Icons.call),
              const SizedBox(width: 8),
              _buildCircleButton(Icons.chat_bubble),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: Color(0xFFEFF6FF), // Blue 50
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: kPrimaryColor, size: 20),
    );
  }

  // 6. Amenities
  Widget _buildAmenitiesSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "TIỆN ÍCH ĐÃ BAO GỒM",
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: kTextSecondary),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _amenities.map((item) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(item['icon'], size: 16, color: kPrimaryColor),
                    const SizedBox(width: 6),
                    Text(
                      item['label'],
                      style: const TextStyle(fontSize: 11, color: kTextPrimary, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // 7. Report Button
  Widget _buildReportButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: kDangerBg,
          elevation: 0,
          side: BorderSide(color: kDangerColor.withOpacity(0.2)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.report_problem, color: kDangerColor, size: 20),
            SizedBox(width: 8),
            Text(
              "Báo cáo sự cố phòng",
              style: TextStyle(
                color: kDangerColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 8. Bottom Nav (With Profile Active)
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
        currentIndex: 3, // Giả lập tab Cá nhân đang active (vì màn này thường vào từ Profile)
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