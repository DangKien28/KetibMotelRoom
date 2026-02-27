// frontend_landlord/landlord/lib/features/room_management/presentation/screens/edit_room_screen.dart
import 'package:flutter/material.dart';

class EditRoomScreen extends StatefulWidget {
  // Nhận dữ liệu ban đầu từ màn chi tiết truyền sang
  final String initialTitle;
  final String initialAddress;
  final String initialPrice;
  final String initialArea;
  final String initialDescription;
  // (Sau này bạn có thể truyền thêm mảng chứa các tiện ích hoặc ảnh)

  const EditRoomScreen({
    super.key,
    required this.initialTitle,
    required this.initialAddress,
    required this.initialPrice,
    required this.initialArea,
    required this.initialDescription,
  });

  @override
  State<EditRoomScreen> createState() => _EditRoomScreenState();
}

class _EditRoomScreenState extends State<EditRoomScreen> {
  final Color primaryColor = const Color(0xFF2B6CEE);
  final Color bgColor = const Color(0xFFF6F6F8);

  // Khởi tạo các controller để chứa và quản lý dữ liệu trong các ô nhập
  late TextEditingController _titleController;
  late TextEditingController _addressController;
  late TextEditingController _priceController;
  late TextEditingController _areaController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    // Điền sẵn dữ liệu cũ vào các controller khi màn hình vừa được tạo
    _titleController = TextEditingController(text: widget.initialTitle);
    _addressController = TextEditingController(text: widget.initialAddress);
    _priceController = TextEditingController(text: widget.initialPrice);
    _areaController = TextEditingController(text: widget.initialArea);
    _descriptionController = TextEditingController(text: widget.initialDescription);
  }

  @override
  void dispose() {
    // Luôn nhớ dispose các controller để tránh tràn bộ nhớ
    _titleController.dispose();
    _addressController.dispose();
    _priceController.dispose();
    _areaController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

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
          'Sửa thông tin phòng',
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
            // 1. Phần tải ảnh (Chỉ hiển thị nút để chủ trọ cập nhật)
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
                  const Text('Tải thêm ảnh hoặc xóa ảnh cũ', style: TextStyle(color: Colors.grey, fontSize: 13)),
                ],
              ),
            ),
            
            const SizedBox(height: 24),

            // 2. Thông tin cơ bản
            const Text('Thông tin cơ bản', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            _buildTextField(label: 'Tiêu đề bài đăng', hint: 'Ví dụ: Phòng trọ cao cấp...', controller: _titleController),
            _buildTextField(label: 'Địa chỉ', hint: 'Số nhà, tên đường...', controller: _addressController),
            
            // 3. Thông tin chi tiết (Giá & Diện tích)
            Row(
              children: [
                Expanded(child: _buildTextField(label: 'Giá cho thuê (đ)', hint: 'Ví dụ: 4500000', keyboardType: TextInputType.number, controller: _priceController)),
                const SizedBox(width: 16),
                Expanded(child: _buildTextField(label: 'Diện tích (m²)', hint: 'Ví dụ: 25', keyboardType: TextInputType.number, controller: _areaController)),
              ],
            ),
            
            _buildTextField(label: 'Mô tả chi tiết', hint: 'Mô tả thêm về phòng...', maxLines: 4, controller: _descriptionController),

            // 4. Tiện ích (Checkbox/Chip)
            const Text('Tiện ích', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                // Demo: Mặc định bật Wifi và Máy lạnh
                _buildUtilityChip('Wifi', Icons.wifi, isSelected: true),
                _buildUtilityChip('Máy lạnh', Icons.ac_unit, isSelected: true),
                _buildUtilityChip('Máy giặt', Icons.local_laundry_service),
                _buildUtilityChip('Chỗ để xe', Icons.motorcycle),
                _buildUtilityChip('Giờ giấc tự do', Icons.access_time),
              ],
            ),

            const SizedBox(height: 32),

            // 5. Nút Cập nhật
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Gọi API lưu thông tin sửa ở đây
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Lưu thay đổi thành công!')),
                  );
                  Navigator.pop(context); // Trở về trang chi tiết phòng
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                ),
                child: const Text('Lưu thay đổi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Cập nhật Widget _buildTextField để nhận thêm controller
  Widget _buildTextField({
    required String label, 
    required String hint, 
    required TextEditingController controller,
    int maxLines = 1, 
    TextInputType keyboardType = TextInputType.text
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)),
        const SizedBox(height: 8),
        TextField(
          controller: controller, // <--- Cắm controller vào đây
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

  // Cập nhật Widget tiện ích để có trạng thái chọn (isSelected)
  Widget _buildUtilityChip(String label, IconData icon, {bool isSelected = false}) {
    return FilterChip(
      label: Text(label),
      avatar: Icon(icon, size: 16, color: isSelected ? primaryColor : Colors.black54),
      selected: isSelected,
      onSelected: (bool value) {
        // TODO: Cập nhật trạng thái state tại đây
      },
      backgroundColor: bgColor,
      selectedColor: primaryColor.withOpacity(0.15),
      checkmarkColor: primaryColor,
      labelStyle: TextStyle(fontSize: 13, color: isSelected ? primaryColor : Colors.black87, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), 
        side: BorderSide(color: isSelected ? primaryColor.withOpacity(0.5) : Colors.grey.shade200)
      ),
    );
  }
}