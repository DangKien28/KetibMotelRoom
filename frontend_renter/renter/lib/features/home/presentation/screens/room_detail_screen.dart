import 'package:flutter/material.dart';

class RoomDetailScreen extends StatefulWidget {
  // Nhận vào các tham số để hiển thị dữ liệu động (tạm thời để title để demo)
  final String title;
  final String price;

  const RoomDetailScreen({
    super.key,
    required this.title,
    required this.price,
  });

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  // Controller cho phần lướt ảnh
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;

  // Dữ liệu giả lập ảnh phòng
  final List<String> _images = [
    "https://lh3.googleusercontent.com/aida-public/AB6AXuDk6qSkfrcKwV537DEHKjUDv7CW5X8ZQrzpu6crELxu2DVoHIhKKY52mVy3OQ9_tPpOog5PezJ2WvZg_iAU82Jrqg_eYXEZCQ48QKj3hL9yn1T7N6_Cec0cUCCjV00_kCl1bJ0EI6LjKqR0ld4GH1r__BMx0AZ-7YnsCXOObsKe-kJtYLGXzmHhgkX3EqmJl_6krV91qruNPgCl5V8Sk_R4HhQdVjL007v0cBk_mkVUiudeFN9VictOMqjdr1JW61walV9N-3XAUBM",
    "https://lh3.googleusercontent.com/aida-public/AB6AXuC0XWFl0FASC2WPI_c9GI4tm0BAtXkydilMbvUMfuCLx5pQkbhAQRyuPhCSpTpo6FKCSp19hSx3RTES-OXTVXt2N0Plu3uQCrSEjPtFqSqtmthvd33bvhF4yWWjncY8z8WXwgRCw_Gsgsia0UP-167HxMtTzsZNtPPoJtbj_4KKRVbVcK0LwsyxKTf2X7W0Ba_pUjHzzlZVx9XqG-Ohe8Gy9ko0dHDjSr15_VLfwDHlXsIIQ7xNHBCrfpkrdXdpZAFSC6D-b4D6NlQ",
    "https://lh3.googleusercontent.com/aida-public/AB6AXuB2lOh0PysHvIPu2HGuKHw0DS6b1CHfOtt1rXVOgIUT_sFfSleKR4eHlZaZhVZYEwN_sGrhEcYHWdEnOMn7EOHUx1oqP-2xQEJhnSEtat3eKq-aM9BHZ4JuAzdEzLkznYMaEhKTDOarFmCv98PhBSUshxGiDyJbC6gSbg3a3PMsF5M7ua-B-q-Bxr-mygXI5mlh8BkvxgEhSO-Z9bqSUynS3SpH1qTiQmgsB03lmidq7jG6aqR1-hbAoXVcTcVLQQVVUWNtOd-njM8",
    "https://via.placeholder.com/400x300",
    "https://via.placeholder.com/400x300",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8),
      body: Stack(
        children: [
          // Nội dung cuộn
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100), // Chừa chỗ cho BottomBar
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageCarousel(),
                _buildMainInfo(),
                const SizedBox(height: 12),
                _buildLandlordInfo(),
                const SizedBox(height: 12),
                _buildExpenses(),
                const SizedBox(height: 12),
                _buildAmenities(),
                const SizedBox(height: 12),
                _buildDescription(),
              ],
            ),
          ),
          // Header (Nút Back & Share) - Đè lên trên cùng
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildTransparentAppBar(context),
          ),
          // Bottom Bar (Nút Thuê ngay) - Cố định ở dưới
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomAction(),
          ),
        ],
      ),
    );
  }

  // 1. CAROUSEL ẢNH
  Widget _buildImageCarousel() {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _images.length,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.network(
                _images[index],
                fit: BoxFit.cover,
                width: double.infinity,
              );
            },
          ),
          // Badge số trang (1/5)
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.photo_library, color: Colors.white, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    "${_currentImageIndex + 1}/${_images.length}",
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          // Dấu chấm (Dots indicator)
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _images.asMap().entries.map((entry) {
                return Container(
                  width: 6.0,
                  height: 6.0,
                  margin: const EdgeInsets.symmetric(horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(_currentImageIndex == entry.key ? 1.0 : 0.4),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // 2. THÔNG TIN CHÍNH (Title, Giá, Stats)
  Widget _buildMainInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF2B6CEE).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text("STUDIO", style: TextStyle(color: Color(0xFF2B6CEE), fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: widget.price, style: const TextStyle(color: Color(0xFF2B6CEE), fontSize: 24, fontWeight: FontWeight.bold)),
                    const TextSpan(text: "/tháng", style: TextStyle(color: Colors.grey, fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0D121B)),
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(Icons.location_on, size: 18, color: Color(0xFF2B6CEE)),
              SizedBox(width: 4),
              Expanded(child: Text("Số 165 Cầu Giấy, Phường Quan Hoa, Quận Cầu Giấy, Hà Nội", style: TextStyle(color: Colors.grey, fontSize: 14))),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),
          // 3 Cột thông tin (Diện tích, Trạng thái, Tối đa)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(Icons.square_foot, "Diện tích", "30m²"),
              _buildStatItem(Icons.calendar_today, "Trống từ", "Ngay lập tức"),
              _buildStatItem(Icons.group, "Tối đa", "2 người"),
            ],
          ),
        ],
      ),
    );
  }

  // Helper cho Stats
  Widget _buildStatItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Text(label.toUpperCase(), style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey),
            const SizedBox(width: 4),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
      ],
    );
  }

  // 3. THÔNG TIN CHỦ TRỌ
  Widget _buildLandlordInfo() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("THÔNG TIN CHỦ TRỌ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 12),
          Row(
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuCKhDl_uBuKhrhcrAClhkOZxkYC-to0LRoKWxDyMUzmjbco5Tw-9gSKtFSnDv83gNa11bsPIHqTENjyZQQ6ovnEMUjuFq_8Ph7YkqsiGxm3nfq4_mFjOBtKOrcQQfQb7ImGRd3ACNS-NgiypXiLu39rjJ5CQvPocTxH_S8UnjagmxY3z-KTys8EPXhE4XSGsoRl3lhw_VLh1NIfpl9CaDd04paXBP8h9yU1LFLFuSN4mK8fcWGYC5yfTF0aPXp3sSHDr8rXBC7tBCI"),
                  ),
                  Positioned(bottom: 0, right: 0, child: Container(width: 12, height: 12, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)))),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text("A. Tuấn Anh", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(width: 4),
                        Icon(Icons.verified, size: 16, color: Colors.blue),
                      ],
                    ),
                    Row(
                      children: const [
                        Text("Phản hồi 98%", style: TextStyle(fontSize: 12, color: Colors.grey)),
                        SizedBox(width: 8),
                        Icon(Icons.circle, size: 4, color: Colors.grey),
                        SizedBox(width: 8),
                        Text("Tham gia 2 năm", style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  CircleAvatar(backgroundColor: Colors.grey.shade100, child: const Icon(Icons.call, color: Colors.grey)),
                  const SizedBox(width: 8),
                  CircleAvatar(backgroundColor: const Color(0xFF2B6CEE).withOpacity(0.1), child: const Icon(Icons.chat_bubble, color: Color(0xFF2B6CEE))),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  // 4. CHI PHÍ SINH HOẠT
  Widget _buildExpenses() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("CHI PHÍ SINH HOẠT", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 3, // Dẹt ngang
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: [
              _buildExpenseItem(Icons.electric_bolt, Colors.amber, "Tiền điện", "3.5k", "/kWh"),
              _buildExpenseItem(Icons.water_drop, Colors.blue, "Tiền nước", "100k", "/người"),
              _buildExpenseItem(Icons.wifi, Colors.purple, "Internet", "Free", ""),
              _buildExpenseItem(Icons.cleaning_services, Colors.green, "Vệ sinh", "50k", "/phòng"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseItem(IconData icon, Color color, String label, String price, String unit) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: color.withOpacity(0.1), radius: 18, child: Icon(icon, color: color, size: 18)),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: price, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13)),
                    TextSpan(text: unit, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // 5. TIỆN NGHI & DỊCH VỤ
  Widget _buildAmenities() {
    final amenities = [
      {"icon": Icons.ac_unit, "label": "Điều hòa"},
      {"icon": Icons.mobile_friendly, "label": "Nóng lạnh"}, // water_heater không có trong Icons chuẩn, dùng tạm
      {"icon": Icons.bed, "label": "Giường"},
      {"icon": Icons.kitchen, "label": "Tủ lạnh"},
      {"icon": Icons.door_sliding, "label": "Tủ quần áo"},
      {"icon": Icons.local_laundry_service, "label": "Máy giặt"},
      {"icon": Icons.two_wheeler, "label": "Để xe"},
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("TIỆN NGHI & DỊCH VỤ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: amenities.length + 1, // +1 cho nút "Xem thêm"
            itemBuilder: (context, index) {
              if (index == amenities.length) {
                return Column(
                  children: [
                    Container(
                      width: 48, height: 48,
                      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                      child: const Center(child: Text("+5", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))),
                    ),
                    const SizedBox(height: 4),
                    const Text("Xem thêm", style: TextStyle(fontSize: 11, color: Colors.grey)),
                  ],
                );
              }
              return Column(
                children: [
                  Container(
                    width: 48, height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Icon(amenities[index]['icon'] as IconData, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 4),
                  Text(amenities[index]['label'] as String, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // 6. MÔ TẢ
  Widget _buildDescription() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("MÔ TẢ CHI TIẾT", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 8),
          const Text(
            "Phòng rộng thoáng mát, ban công phơi đồ riêng biệt.\nNằm trong khu dân trí cao, an ninh đảm bảo, camera 24/7, giờ giấc tự do không chung chủ.\nGần chợ, siêu thị, các trường đại học GTVT, Sư Phạm...",
            style: TextStyle(fontSize: 14, height: 1.5, color: Color(0xFF4B5563)),
          ),
          const SizedBox(height: 8),
          const Text("Xem thêm", style: TextStyle(color: Color(0xFF2B6CEE), fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }

  // APP BAR trong suốt
  Widget _buildTransparentAppBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.share, color: Colors.black),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {},
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // BOTTOM BAR
  Widget _buildBottomAction() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Tổng giá thuê", style: TextStyle(fontSize: 12, color: Colors.grey)),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(text: "4.500.000₫", style: TextStyle(color: Color(0xFF2B6CEE), fontSize: 18, fontWeight: FontWeight.bold)),
                    TextSpan(text: "/tháng", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2B6CEE),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Thuê ngay", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}