import 'package:flutter/material.dart';

class ManageRoomsAdminScreen extends StatefulWidget {
  const ManageRoomsAdminScreen({super.key});

  @override
  State<ManageRoomsAdminScreen> createState() => _ManageRoomsAdminScreenState();
}

class _ManageRoomsAdminScreenState extends State<ManageRoomsAdminScreen> {
  final Color primaryColor = const Color(0xFF2B6CEE);
  final Color bgColor = const Color(0xFFF6F6F8);
  
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['Tất cả', 'Chờ duyệt', 'Đang hoạt động', 'Bị từ chối'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {}, // Nếu dùng BottomNav thì có thể ẩn nút này đi
        ),
        title: const Text(
          'Quản lý Phòng trọ',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, color: Colors.black),
                onPressed: () {},
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // 1. Thanh tìm kiếm
          Container(
            color: bgColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Tìm kiếm tên, địa chỉ, chủ nhà...',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 2. Bộ lọc (Chips)
          Container(
            height: 50,
            padding: const EdgeInsets.only(left: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                bool isSelected = _selectedFilterIndex == index;
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: ChoiceChip(
                    label: Text(_filters[index]),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedFilterIndex = index;
                      });
                    },
                    backgroundColor: Colors.white,
                    selectedColor: primaryColor,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: isSelected ? primaryColor : Colors.grey.shade300),
                    ),
                  ),
                );
              },
            ),
          ),

          // 3. Danh sách phòng
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildRoomCard(
                  title: 'Phòng trọ cao cấp Q. Bình Thạnh',
                  address: '123 Đường Xô Viết Nghệ Tĩnh, P.25',
                  price: '3.500.000đ',
                  status: 'Chờ duyệt',
                  time: '2 giờ trước',
                  imageUrl: 'https://via.placeholder.com/150',
                ),
                _buildRoomCard(
                  title: 'KTX Giá rẻ Thủ Đức',
                  address: '45 Đường số 8, P. Linh Xuân',
                  price: '1.200.000đ',
                  status: 'Đang hoạt động',
                  imageUrl: 'https://via.placeholder.com/150',
                ),
                _buildRoomCard(
                  title: 'Căn hộ Mini Full Nội Thất',
                  address: '12 Nguyễn Thị Minh Khai, Q.1',
                  price: '5.500.000đ',
                  status: 'Đang hoạt động',
                  imageUrl: 'https://via.placeholder.com/150',
                ),
                _buildRoomCard(
                  title: 'Phòng trọ giá rẻ Gò Vấp',
                  address: 'Hẻm 352 Lê Đức Thọ, P.16',
                  price: '2.000.000đ',
                  status: 'Bị từ chối',
                  time: 'Hôm qua',
                  imageUrl: 'https://via.placeholder.com/150',
                  isDimmed: true, // Làm mờ thẻ theo prototype
                ),
              ],
            ),
          ),
        ],
      ),
      // Nút thêm (+)
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  // Widget xây dựng thẻ phòng trọ
  Widget _buildRoomCard({
    required String title,
    required String address,
    required String price,
    required String status,
    String? time,
    required String imageUrl,
    bool isDimmed = false,
  }) {
    Color statusColor;
    Color statusBgColor;

    if (status == 'Chờ duyệt') {
      statusColor = Colors.orange.shade700;
      statusBgColor = Colors.orange.shade50;
    } else if (status == 'Đang hoạt động') {
      statusColor = Colors.green.shade700;
      statusBgColor = Colors.green.shade50;
    } else {
      statusColor = Colors.red.shade700;
      statusBgColor = Colors.red.shade50;
    }

    return Opacity(
      opacity: isDimmed ? 0.6 : 1.0,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ảnh phòng
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(imageUrl, width: 80, height: 80, fit: BoxFit.cover),
                ),
                const SizedBox(width: 12),
                
                // Thông tin
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: statusBgColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              status,
                              style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                          if (time != null) 
                            Text(time, style: const TextStyle(fontSize: 11, color: Colors.grey))
                          else
                            const Icon(Icons.more_vert, size: 18, color: Colors.grey),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15), maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 2),
                      Text(address, style: TextStyle(color: Colors.grey.shade600, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 6),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: price, style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 15)),
                            TextSpan(text: '/tháng', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Khu vực Nút bấm hành động
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade100)),
              ),
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  if (status == 'Chờ duyệt') ...[
                    Expanded(child: _buildActionButton(Icons.check, 'Duyệt', Colors.green)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildActionButton(Icons.close, 'Từ chối', Colors.red)),
                  ] else if (status == 'Đang hoạt động') ...[
                    Expanded(child: _buildActionButton(Icons.edit, 'Chỉnh sửa', Colors.grey.shade700)),
                  ] else ...[
                    Expanded(child: _buildActionButton(Icons.visibility, 'Xem lý do', Colors.grey.shade700)),
                  ]
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color) {
    Color bgColor = color.withOpacity(0.1);
    return Container(
      height: 36,
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }
}