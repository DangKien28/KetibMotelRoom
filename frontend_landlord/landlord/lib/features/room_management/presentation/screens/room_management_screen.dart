import 'package:flutter/material.dart';
import 'package:landlord/features/room_management/presentation/screens/post_room_screen.dart';
// TODO: Đảm bảo bạn đã import đúng đường dẫn của RoomDetailScreen
import 'room_detail_screen.dart'; 

class ManageRoomsScreen extends StatelessWidget {
  const ManageRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF2B6CEE);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8), // Màu nền background-light từ prototype
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F8),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Phòng của tôi',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black54),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100), // Khoảng trống cho FAB và NavBar
            child: Column(
              children: [
                // 1. Phần thống kê (Statistics)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      _buildStatCard("12", "Tổng số", Colors.black),
                      const SizedBox(width: 12),
                      _buildStatCard("4", "Còn trống", primaryColor),
                      const SizedBox(width: 12),
                      _buildStatCard("8", "Đang thuê", Colors.orange),
                    ],
                  ),
                ),

                // 2. Thanh tìm kiếm (Search Bar)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm theo tên phòng, địa chỉ...',
                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // 3. Danh sách phòng (Room List)
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    // Truyền thêm biến context vào hàm
                    _buildRoomCard(
                      context: context,
                      title: "Phòng trọ cao cấp Q.3",
                      address: "123 CMT8, P.10, Q.3, TP.HCM",
                      price: "4.500.000 đ",
                      status: "Còn trống",
                      isNew: true,
                    ),
                    _buildRoomCard(
                      context: context,
                      title: "Căn hộ mini Full nội thất",
                      address: "456 Lê Văn Sỹ, P.14, Q.3",
                      price: "6.000.000 đ",
                      status: "Đã thuê",
                    ),
                    _buildRoomCard(
                      context: context,
                      title: "Phòng giá rẻ sinh viên",
                      address: "789 Nguyễn Trãi, Q.5",
                      price: "2.500.000 đ",
                      status: "Còn trống",
                    ),
                    _buildRoomCard(
                      context: context,
                      title: "Căn hộ Studio View đẹp",
                      address: "12 Võ Văn Tần, Q.3",
                      price: "5.200.000 đ",
                      status: "Đã thuê",
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // 4. Nút Đăng tin nổi (Floating Action Button)
          Positioned(
            bottom: 16,
            right: 16,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PostRoomScreen()),
                );
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text("Đăng tin", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget con cho thẻ thống kê
  Widget _buildStatCard(String value, String label, Color valueColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFF0F0F0)),
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: valueColor)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  // Widget con cho thẻ phòng trọ (Sửa: Thêm tham số BuildContext context)
  Widget _buildRoomCard({
    required BuildContext context,
    required String title,
    required String address,
    required String price,
    required String status,
    bool isNew = false,
  }) {
    bool isVacant = status == "Còn trống";

    return InkWell( 
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        // Sử dụng context được truyền từ tham số để điều hướng
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoomDetailScreen(
              roomData: {
                'name': title,
                'address': address,
                'price': price,
                'status': status,
                'area': '25', // Giả lập diện tích
              },
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFF0F0F0)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh phòng
            Stack(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                    image: const DecorationImage(
                      image: NetworkImage('https://via.placeholder.com/150'), 
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (isNew)
                  Positioned(
                    top: 4,
                    left: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2B6CEE),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text("MỚI", style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            // Thông tin phòng
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15), overflow: TextOverflow.ellipsis),
                      ),
                      const Icon(Icons.more_vert, color: Colors.grey, size: 20),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(address, style: const TextStyle(color: Colors.grey, fontSize: 12), overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(price, style: const TextStyle(color: Color(0xFF2B6CEE), fontWeight: FontWeight.bold, fontSize: 16)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isVacant ? const Color(0xFFE8F5E9) : const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isVacant ? Colors.green : Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              status,
                              style: TextStyle(
                                color: isVacant ? Colors.green[700] : Colors.grey[600],
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}