// frontend_landlord/landlord/lib/features/manage_rooms/presentation/screens/post_room_screen.dart
import 'package:flutter/material.dart';

class PostRoomScreen extends StatefulWidget {
  const PostRoomScreen({super.key});

  @override
  State<PostRoomScreen> createState() => _PostRoomScreenState();
}

class _PostRoomScreenState extends State<PostRoomScreen> {
  final Color primaryColor = const Color(0xFF2B6CEE);
  final Color bgColor = const Color(0xFFF6F6F8);
  
  // Biến lưu trữ phòng được chọn để liên kết
  String? _selectedRoom;

  // Danh sách giả lập các phòng chủ trọ đang quản lý
  final List<String> _myRooms = [
    'Phòng 101 - Trống',
    'Phòng 102 - Trống',
    'Phòng 201 - Sắp trống',
    'Phòng 301 - Đang sửa chữa'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Đăng tin mới',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: const Color(0xFFF0F0F0), height: 1),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. CHỨC NĂNG MỚI: Liên kết phòng quản lý
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryColor.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.link, color: primaryColor, size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        'Liên kết với phòng của bạn',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Chọn một phòng trống trong danh sách quản lý để tự động điền thông tin và đồng bộ trạng thái.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  // Dropdown chọn phòng
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    hint: const Text('Chọn phòng cần đăng...', style: TextStyle(fontSize: 14)),
                    value: _selectedRoom,
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                    items: _myRooms.map((String room) {
                      return DropdownMenuItem<String>(
                        value: room,
                        child: Text(room, style: const TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRoom = newValue;
                      });
                      // TODO: Gọi logic tự động điền các thông tin (giá, diện tích, v.v.) dựa trên phòng được chọn
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),

            // 2. Phần tải ảnh lên
            const Text('Hình ảnh phòng', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_photo_alternate_outlined, size: 40, color: primaryColor),
                  const SizedBox(height: 8),
                  const Text('Tải ảnh lên (Tối đa 5 ảnh)', style: TextStyle(color: Colors.grey, fontSize: 13)),
                ],
              ),
            ),
            
            const SizedBox(height: 24),

            // 3. Thông tin cơ bản
            const Text('Thông tin cơ bản', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            _buildTextField(label: 'Tiêu đề bài đăng', hint: 'Ví dụ: Phòng trọ cao cấp Q.3, Full nội thất'),
            _buildTextField(label: 'Địa chỉ', hint: 'Số nhà, tên đường, phường, quận...'),
            
            // 4. Thông tin chi tiết (Giá & Diện tích)
            Row(
              children: [
                Expanded(child: _buildTextField(label: 'Giá cho thuê (đ)', hint: 'Ví dụ: 4500000', keyboardType: TextInputType.number)),
                const SizedBox(width: 16),
                Expanded(child: _buildTextField(label: 'Diện tích (m²)', hint: 'Ví dụ: 25', keyboardType: TextInputType.number)),
              ],
            ),
            
            _buildTextField(label: 'Mô tả chi tiết', hint: 'Mô tả thêm về phòng, giờ giấc, an ninh...', maxLines: 4),

            // 5. Tiện ích (Checkbox/Chip)
            const Text('Tiện ích', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildUtilityChip('Wifi', Icons.wifi),
                _buildUtilityChip('Máy lạnh', Icons.ac_unit),
                _buildUtilityChip('Máy giặt', Icons.local_laundry_service), // Sửa lại icon máy giặt chuẩn của Flutter
                _buildUtilityChip('Chỗ để xe', Icons.motorcycle),
                _buildUtilityChip('Giờ giấc tự do', Icons.access_time),
              ],
            ),

            const SizedBox(height: 32),

            // 6. Nút Đăng bài
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Xử lý lưu bài đăng
                  if (_selectedRoom == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Vui lòng chọn phòng để liên kết!')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đăng bài thành công!')),
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                ),
                child: const Text('Đăng bài ngay', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Widget hỗ trợ tạo TextField nhanh
  Widget _buildTextField({
    required String label, 
    required String hint, 
    int maxLines = 1, 
    TextInputType keyboardType = TextInputType.text
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
            filled: true,
            fillColor: bgColor,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // Widget hỗ trợ tạo Chip tiện ích
  Widget _buildUtilityChip(String label, IconData icon) {
    return FilterChip(
      label: Text(label),
      avatar: Icon(icon, size: 16, color: Colors.black54),
      onSelected: (bool value) {},
      backgroundColor: bgColor,
      selectedColor: primaryColor.withOpacity(0.15),
      checkmarkColor: primaryColor,
      labelStyle: const TextStyle(fontSize: 13, color: Colors.black87),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), 
        side: BorderSide(color: Colors.grey.shade200)
      ),
    );
  }
}