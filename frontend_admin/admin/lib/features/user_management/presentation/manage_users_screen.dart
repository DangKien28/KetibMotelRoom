import 'package:flutter/material.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  final Color primaryColor = const Color(0xFF2B6CEE);
  final Color bgColor = const Color(0xFFF6F6F8);
  
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['Tất cả', 'Chủ trọ', 'Người thuê', 'Đã khóa'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'Quản lý người dùng',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: primaryColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. Thanh tìm kiếm
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Tìm theo tên hoặc email...',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: bgColor,
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
            color: Colors.white,
            height: 50,
            padding: const EdgeInsets.only(left: 16, bottom: 8),
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
                    backgroundColor: bgColor,
                    selectedColor: primaryColor,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide.none,
                    ),
                  ),
                );
              },
            ),
          ),

          // 3. Danh sách User
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildUserCard(
                  name: 'Nguyễn Văn A',
                  email: 'nguyenvana@gmail.com',
                  role: 'Chủ trọ',
                  status: 'Hoạt động',
                  imageUrl: 'https://via.placeholder.com/150',
                ),
                _buildUserCard(
                  name: 'Trần Thị B',
                  email: 'tranthib@gmail.com',
                  role: 'Người thuê',
                  status: 'Hoạt động',
                  imageUrl: 'https://via.placeholder.com/150',
                ),
                _buildUserCard(
                  name: 'Lê Văn C',
                  email: 'levanc@outlook.com',
                  role: 'Người thuê',
                  status: 'Đã khóa',
                  imageUrl: 'https://via.placeholder.com/150',
                  isLocked: true, // Làm mờ người dùng đã khóa
                ),
                _buildUserCard(
                  name: 'Phạm Thị D',
                  email: 'phamthid@gmail.com',
                  role: 'Chủ trọ',
                  status: 'Hoạt động',
                  imageUrl: 'https://via.placeholder.com/150',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard({
    required String name,
    required String email,
    required String role,
    required String status,
    required String imageUrl,
    bool isLocked = false,
  }) {
    bool isLandlord = role == 'Chủ trọ';

    return Opacity(
      opacity: isLocked ? 0.6 : 1.0,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar có dấu chấm trạng thái
            Stack(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade200, width: 2),
                    image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: isLocked ? Colors.red : Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            
            // Thông tin Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                  const SizedBox(height: 2),
                  Text(email, style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // Badge Role (Vai trò)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: isLandlord ? Colors.blue.shade50 : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: isLandlord ? Colors.blue.shade100 : Colors.grey.shade200),
                        ),
                        child: Text(
                          role,
                          style: TextStyle(
                            color: isLandlord ? Colors.blue.shade700 : Colors.grey.shade600,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Text Status
                      Row(
                        children: [
                          Icon(isLocked ? Icons.block : Icons.check_circle, size: 12, color: isLocked ? Colors.red : Colors.green),
                          const SizedBox(width: 4),
                          Text(
                            status,
                            style: TextStyle(color: isLocked ? Colors.red : Colors.green, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Nút tùy chọn 3 chấm
            IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.grey),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}