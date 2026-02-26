// frontend_landlord/landlord/lib/features/manage_rooms/presentation/screens/room_detail_screen.dart
import 'package:flutter/material.dart';

class RoomDetailScreen extends StatelessWidget {
  final Map<String, dynamic> roomData;

  const RoomDetailScreen({super.key, required this.roomData});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF2B6CEE);
    final Color bgColor = const Color(0xFFF6F6F8);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Chi tiết phòng',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit_square, color: primaryColor),
            onPressed: () {
              // TODO: Chuyển sang màn hình chỉnh sửa phòng
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Ảnh Cover & Bộ đếm ảnh
            SizedBox(
              height: 256, // Tương đương h-64 trong Tailwind
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://via.placeholder.com/600x400'), // Thay bằng ảnh thật
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Gradient làm tối phần dưới ảnh
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.5),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Huy hiệu 1/5 ảnh
                  Positioned(
                    bottom: 40, // Đẩy cao lên một chút để không bị che bởi viền bo tròn của khung dưới
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.photo_library, color: Colors.white, size: 14),
                          SizedBox(width: 4),
                          Text('1/5', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2. Main Content (Kéo lên đè ảnh một đoạn)
            Container(
              transform: Matrix4.translationValues(0.0, -24.0, 0.0), // -mt-6 kéo khung lên đè ảnh
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)), // rounded-t-3xl
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tiêu đề & Badge trạng thái
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          roomData['name'] ?? 'Phòng trọ cao cấp Q.3',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black87),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          roomData['status'] ?? 'Đang thuê',
                          style: TextStyle(color: primaryColor, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Địa chỉ
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on, size: 18, color: primaryColor),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          roomData['address'] ?? '123 CMT8, Phường 10, Quận 3, TP.HCM',
                          style: const TextStyle(color: Colors.grey, fontSize: 14, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Giá tiền
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        roomData['price'] ?? '4.500.000 đ',
                        style: TextStyle(color: primaryColor, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 4),
                      const Text('/tháng', style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Divider(height: 1, color: Color(0xFFE0E0E0)),
                  ),

                  // 3. Tiện ích
                  const Text('Tiện ích', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildAmenityItem(Icons.wifi, 'Wifi', primaryColor),
                      _buildAmenityItem(Icons.ac_unit, 'Máy lạnh', primaryColor),
                      _buildAmenityItem(Icons.local_parking, 'Giữ xe', primaryColor),
                      _buildAmenityItem(Icons.more_horiz, 'Thêm', Colors.grey.shade400, textColor: Colors.grey.shade600),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // 4. Mô tả chi tiết
                  const Text('Mô tả chi tiết', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text(
                    'Phòng mới xây, rộng rãi thoáng mát, có ban công view đẹp. Đầy đủ nội thất cơ bản: giường, tủ, máy lạnh. Giờ giấc tự do, không chung chủ, an ninh đảm bảo có camera 24/7.',
                    style: TextStyle(color: Colors.black54, fontSize: 14, height: 1.5),
                  ),

                  const SizedBox(height: 24),

                  // 5. Danh sách hợp đồng
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Danh sách hợp đồng', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Text('Xem tất cả', style: TextStyle(color: primaryColor, fontSize: 12, fontWeight: FontWeight.bold)),
                            Icon(Icons.chevron_right, color: primaryColor, size: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Thẻ hợp đồng đang hoạt động (Người thuê hiện tại)
                  _buildActiveContractCard(context, primaryColor),

                  const SizedBox(height: 12),

                  // Thẻ hợp đồng cũ
                  _buildPastContractCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget xây dựng Icon Tiện ích
  Widget _buildAmenityItem(IconData icon, String label, Color iconColor, {Color? textColor}) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2)),
            ],
          ),
          child: Icon(icon, color: iconColor),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: textColor ?? Colors.grey.shade700),
        ),
      ],
    );
  }

  // Widget Thẻ Hợp đồng đang hoạt động
  Widget _buildActiveContractCard(BuildContext context, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade100),
        boxShadow: [
          BoxShadow(color: Colors.blue.shade50.withOpacity(0.5), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          // Header hợp đồng (Tên + Nút xanh nhấp nháy)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: Colors.blue.shade50, shape: BoxShape.circle),
                child: Icon(Icons.person, color: primaryColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nguyễn Văn Cường', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 2),
                    Text('Người thuê hiện tại', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                  ],
                ),
              ),
              // Nút tròn trạng thái màu xanh lá (Giả lập Ping)
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green.shade100, width: 3),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Thông tin hiệu lực & trạng thái
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6F8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('HIỆU LỰC', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                    const SizedBox(height: 4),
                    Text('01/06/2023 - 01/06/2024', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey.shade800)),
                  ],
                ),
                Container(width: 1, height: 30, color: Colors.grey.shade300),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('TRẠNG THÁI', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                    SizedBox(height: 4),
                    Text('Đang hoạt động', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.green)),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Link xem chi tiết
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Xem chi tiết hợp đồng', style: TextStyle(color: primaryColor, fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(width: 4),
                Icon(Icons.open_in_new, color: primaryColor, size: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget Thẻ Hợp đồng cũ
  Widget _buildPastContractCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle),
            child: const Icon(Icons.history, color: Colors.grey, size: 18),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Trần Thị Mai', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87)),
                Text('Đã kết thúc: 31/05/2023', style: TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}