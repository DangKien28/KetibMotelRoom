// frontend_landlord/landlord/lib/features/room_management/presentation/screens/room_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:landlord/features/room_management/presentation/screens/edit_room_screen.dart'; 

class RoomDetailScreen extends StatelessWidget {
  // 1. Khai báo biến nhận dữ liệu từ màn hình danh sách truyền sang
  final Map<String, dynamic>? roomData;

  // 2. Cập nhật constructor để nhận roomData
  const RoomDetailScreen({super.key, this.roomData});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF2B6CEE);
    final Color bgColor = const Color(0xFFF6F6F8);

    // 3. Trích xuất dữ liệu từ roomData (nếu null thì dùng dữ liệu mặc định)
    final String title = roomData?['name'] ?? 'Phòng trọ cao cấp Q.3, Full nội thất';
    final String address = roomData?['address'] ?? '123 Nguyễn Đình Chiểu, P.6, Q.3, TP.HCM';
    final String price = roomData?['price']?.toString().replaceAll(' đ', '').replaceAll('.', '') ?? '4500000'; // Chuẩn hóa giá về số
    final String displayPrice = roomData?['price'] ?? '4.500.000 đ';
    final String status = roomData?['status'] ?? 'Còn trống';
    final String area = roomData?['area']?.toString() ?? '25';
    
    // Mô tả mặc định (Sau này có thể lấy từ roomData nếu API có trả về)
    const String description = 'Phòng mới xây, giờ giấc tự do, an ninh tốt, có camera giám sát 24/7. Khu vực an ninh, gần siêu thị, chợ và các trường Đại học. Điện 3.5k/kwh, Nước 100k/người.';
    
    bool isVacant = status == "Còn trống";

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Chi tiết phòng',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: const Color(0xFFF0F0F0), height: 1),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: primaryColor),
            tooltip: 'Sửa thông tin',
            onPressed: () {
              // 4. Truyền dữ liệu THỰC TẾ sang màn hình Sửa phòng bằng Navigator.push
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditRoomScreen(
                    initialTitle: title,
                    initialAddress: address,
                    initialPrice: price,
                    initialArea: area,
                    initialDescription: description,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh phòng
            Container(
              height: 220,
              color: Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(16),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    width: 280,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200],
                      image: const DecorationImage(
                        image: NetworkImage('https://via.placeholder.com/400x300?text=Room+Image'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // Card thông tin chính
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title, // Dữ liệu thật
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Badge trạng thái linh hoạt
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: isVacant ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          status, // Dữ liệu thật
                          style: TextStyle(
                            color: isVacant ? Colors.green : Colors.orange, 
                            fontWeight: FontWeight.bold, 
                            fontSize: 12
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    displayPrice, // Dữ liệu thật
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: primaryColor),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on, size: 18, color: Colors.grey),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          address, // Dữ liệu thật
                          style: const TextStyle(fontSize: 14, color: Colors.black54, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Diện tích & Thông số
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Thông số phòng', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildInfoItem(Icons.square_foot, 'Diện tích', '$area m²'), // Dữ liệu thật
                      _buildInfoItem(Icons.people_alt_outlined, 'Sức chứa', 'Tối đa 2 người'),
                      _buildInfoItem(Icons.payments_outlined, 'Tiền cọc', '1 tháng'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Tiện ích
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tiện ích có sẵn', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildUtilityItem(Icons.wifi, 'Wifi miễn phí'),
                      _buildUtilityItem(Icons.ac_unit, 'Máy lạnh'),
                      _buildUtilityItem(Icons.local_laundry_service, 'Máy giặt'),
                      _buildUtilityItem(Icons.access_time, 'Giờ giấc tự do'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Mô tả chi tiết
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Đặc điểm nổi bật', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.6),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: Colors.grey[600], size: 24),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildUtilityItem(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF2B6CEE)),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}