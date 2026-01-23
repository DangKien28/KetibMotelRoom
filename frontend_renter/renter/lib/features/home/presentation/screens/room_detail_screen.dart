import 'package:flutter/material.dart';

class RoomDetailScreen extends StatefulWidget {
  const RoomDetailScreen({super.key});

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  // --- COLOR CONSTANTS (Dựa trên HTML config) ---
  static const Color kPrimaryColor = Color(0xFF2B6CEE);
  static const Color kBackgroundColor = Color(0xFFF6F6F8);
  static const Color kSurfaceColor = Colors.white;
  static const Color kTextPrimary = Color(0xFF0F172A); // Slate 900
  static const Color kTextSecondary = Color(0xFF64748B); // Slate 500

  // --- PLACEHOLDER DATA (Dữ liệu mẫu để tạo khung) ---
  final int _currentImageIndex = 0;
  final int _totalImages = 5;

  // Danh sách tiện ích mẫu
  final List<Map<String, dynamic>> _amenities = [
    {'icon': Icons.ac_unit, 'label': 'Điều hòa'},
    {'icon': Icons.water_drop, 'label': 'Nóng lạnh'}, // Icon gần giống water_heater
    {'icon': Icons.bed, 'label': 'Giường'},
    {'icon': Icons.kitchen, 'label': 'Tủ lạnh'},
    {'icon': Icons.checkroom, 'label': 'Tủ quần áo'}, // Icon gần giống wardrobe
    {'icon': Icons.local_laundry_service, 'label': 'Máy giặt'},
    {'icon': Icons.two_wheeler, 'label': 'Để xe'},
    {'icon': Icons.more_horiz, 'label': 'Xem thêm', 'isMore': true},
  ];

  // Danh sách chi phí mẫu
  final List<Map<String, dynamic>> _costs = [
    {
      'icon': Icons.bolt,
      'color': Colors.orange,
      'bg': Colors.orange.shade50,
      'title': 'Tiền điện',
      'price': '3.5k',
      'unit': '/kWh'
    },
    {
      'icon': Icons.water_drop,
      'color': Colors.blue,
      'bg': Colors.blue.shade50,
      'title': 'Tiền nước',
      'price': '100k',
      'unit': '/người'
    },
    {
      'icon': Icons.wifi,
      'color': Colors.purple,
      'bg': Colors.purple.shade50,
      'title': 'Internet',
      'price': 'Free',
      'unit': ''
    },
    {
      'icon': Icons.cleaning_services,
      'color': Colors.green,
      'bg': Colors.green.shade50,
      'title': 'Vệ sinh',
      'price': '50k',
      'unit': '/phòng'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      // AppBar trong suốt hoặc trắng tùy trạng thái cuộn, ở đây để cố định màu trắng cho giống ảnh
      appBar: AppBar(
        backgroundColor: kSurfaceColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kTextPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Chi tiết phòng",
          style: TextStyle(
            color: kTextPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
             fontFamily: 'Plus Jakarta Sans',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: kTextPrimary),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.red),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSlider(),
            _buildMainInfo(),
            const SizedBox(height: 10),
            _buildLandlordInfo(),
            const SizedBox(height: 10),
            _buildCostSection(),
            const SizedBox(height: 10),
            _buildAmenitiesSection(),
            const SizedBox(height: 10),
            _buildDescription(),
            // Khoảng trống để không bị che bởi BottomBar
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  // 1. Image Slider Section
  Widget _buildImageSlider() {
    return Stack(
      children: [
        SizedBox(
          height: 250, // Chiều cao khung ảnh
          width: double.infinity,
          child: PageView.builder(
            itemCount: _totalImages,
            onPageChanged: (index) {
              // Cập nhật state index nếu cần hiển thị dot active
            },
            itemBuilder: (context, index) {
              return Container(
                color: Colors.grey.shade300,
                child: const Center(
                  child: Icon(Icons.image, size: 50, color: Colors.grey),
                ),
                // TODO: Thay thế bằng Image.network(url)
              );
            },
          ),
        ),
        // Pagination Dots
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) { // Giả lập 3 dots
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: index == 0 ? Colors.white : Colors.white.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
        ),
        // Image Counter Badge
        Positioned(
          bottom: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                const Icon(Icons.photo_library, color: Colors.white, size: 12),
                const SizedBox(width: 4),
                Text(
                  "1/$_totalImages",
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // 2. Main Info (Title, Price, Address, Stats)
  Widget _buildMainInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tag + Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  "STUDIO",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "4.5 tr",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Plus Jakarta Sans',
                      ),
                    ),
                    TextSpan(
                      text: " /tháng",
                      style: TextStyle(
                        color: kTextSecondary,
                        fontSize: 12,
                        fontFamily: 'Plus Jakarta Sans',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Title
          const Text(
            "Căn hộ Studio Full nội thất - View thoáng mát",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kTextPrimary,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          // Address
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Icon(Icons.location_on, color: kPrimaryColor, size: 16),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  "Số 165 Cầu Giấy, Phường Quan Hoa, Quận Cầu Giấy, Hà Nội",
                  style: TextStyle(color: kTextSecondary, fontSize: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),
          const SizedBox(height: 16),
          // 3-Column Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(Icons.square_foot, "DIỆN TÍCH", "30m²"),
              _buildVerticalDivider(),
              _buildStatItem(Icons.calendar_today, "TRỐNG TỪ", "Ngay lập tức"),
              _buildVerticalDivider(),
              _buildStatItem(Icons.group, "TỐI ĐA", "2 người"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: kTextSecondary, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(icon, size: 16, color: kTextSecondary),
            const SizedBox(width: 4),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: kTextPrimary),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(width: 1, height: 30, color: const Color(0xFFE2E8F0));
  }

  // 3. Landlord Info
  Widget _buildLandlordInfo() {
    return Container(
      color: kSurfaceColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "THÔNG TIN CHỦ TRỌ",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: kTextPrimary),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              // Avatar
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                  // TODO: Image.network cho avatar
                ),
                child: Stack(
                  children: [
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
              ),
              const SizedBox(width: 12),
              // Name & Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text(
                          "A. Tuấn Anh",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.verified, color: Colors.blue, size: 14),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Phản hồi 98%  •  Tham gia 2 năm",
                      style: TextStyle(color: kTextSecondary, fontSize: 11),
                    ),
                  ],
                ),
              ),
              // Buttons
              _buildCircleButton(Icons.call, Colors.grey.shade100, kTextSecondary),
              const SizedBox(width: 8),
              _buildCircleButton(Icons.chat_bubble, const Color(0xFFEFF6FF), kPrimaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton(IconData icon, Color bg, Color iconColor) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: iconColor, size: 20),
    );
  }

  // 4. Cost Section (Grid 2 columns based on HTML structure)
  Widget _buildCostSection() {
    return Container(
      color: kSurfaceColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "CHI PHÍ SINH HOẠT",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: kTextPrimary),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.5, // Điều chỉnh tỷ lệ để giống thẻ ngang
            ),
            itemCount: _costs.length,
            itemBuilder: (context, index) {
              final item = _costs[index];
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: item['bg'],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(item['icon'], color: item['color'], size: 18),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item['title'],
                          style: const TextStyle(fontSize: 10, color: kTextSecondary),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: item['price'],
                                style: const TextStyle(
                                  color: kTextPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  fontFamily: 'Plus Jakarta Sans',
                                ),
                              ),
                              TextSpan(
                                text: " ${item['unit']}",
                                style: const TextStyle(
                                  color: kTextSecondary,
                                  fontSize: 10,
                                  fontFamily: 'Plus Jakarta Sans',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // 5. Amenities Section
  Widget _buildAmenitiesSection() {
    return Container(
      color: kSurfaceColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "TIỆN NGHI & DỊCH VỤ",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: kTextPrimary),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: _amenities.length,
            itemBuilder: (context, index) {
              final item = _amenities[index];
              final bool isMore = item['isMore'] == true;
              return Column(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isMore ? Colors.grey.shade100 : kSurfaceColor,
                      borderRadius: BorderRadius.circular(16),
                      border: isMore ? null : Border.all(color: Colors.grey.shade200),
                    ),
                    child: isMore
                        ? const Center(
                            child: Text(
                              "+5",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: kTextSecondary),
                            ),
                          )
                        : Icon(item['icon'], color: kTextSecondary, size: 24),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item['label'],
                    style: const TextStyle(fontSize: 10, color: kTextSecondary),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // 6. Description
  Widget _buildDescription() {
    return Container(
      color: kSurfaceColor,
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "MÔ TẢ CHI TIẾT",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: kTextPrimary),
          ),
          const SizedBox(height: 8),
          const Text(
            "Phòng rộng thoáng mát, ban công phơi đồ riêng biệt.\nNằm trong khu dân trí cao, an ninh đảm bảo, camera 24/7, giờ giấc tự do không chung chủ.\nGần chợ, siêu thị, các trường đại học GTVT, Sư Phạm...",
            style: TextStyle(fontSize: 13, color: kTextSecondary, height: 1.5),
          ),
          const SizedBox(height: 4),
          InkWell(
            onTap: () {},
            child: const Text(
              "Xem thêm",
              style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 13),
            ),
          )
        ],
      ),
    );
  }

  // 7. Bottom Action Bar
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16).copyWith(bottom: 24), // Safe area bottom padding manually if needed
      decoration: BoxDecoration(
        color: kSurfaceColor,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Tổng giá thuê", style: TextStyle(fontSize: 11, color: kTextSecondary)),
              Text(
                "4.500.000₫",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                  fontFamily: 'Plus Jakarta Sans',
                ),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              // TODO: Handle Rent Action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              elevation: 0,
            ),
            child: Row(
              children: const [
                Text(
                  "Thuê ngay",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, size: 18)
              ],
            ),
          ),
        ],
      ),
    );
  }
}