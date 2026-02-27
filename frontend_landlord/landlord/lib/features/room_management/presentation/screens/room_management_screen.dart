// frontend_landlord/landlord/lib/features/room_management/presentation/screens/room_management_screen.dart
import 'package:flutter/material.dart';
import 'package:landlord/features/room_management/presentation/screens/post_room_screen.dart';
import 'room_detail_screen.dart'; 
// 1. Import màn hình NotificationScreen
import 'package:landlord/features/notification/presentation/screens/notification_screen.dart';

class ManageRoomsScreen extends StatefulWidget {
  const ManageRoomsScreen({super.key});

  @override
  State<ManageRoomsScreen> createState() => _ManageRoomsScreenState();
}

class _ManageRoomsScreenState extends State<ManageRoomsScreen> {
  final Color primaryColor = const Color(0xFF2B6CEE);

  List<Map<String, dynamic>> rooms = [
    {
      "title": "Phòng trọ cao cấp Q.3",
      "address": "123 CMT8, P.10, Q.3, TP.HCM",
      "price": "4.500.000 đ",
      "status": "Còn trống", 
      "isNew": true,
      "isActive": true, 
    },
    {
      "title": "Căn hộ mini Full nội thất",
      "address": "456 Lê Văn Sỹ, P.14, Q.3",
      "price": "6.000.000 đ",
      "status": "Đã thuê",
      "isNew": false,
      "isActive": true,
    },
    {
      "title": "Phòng giá rẻ sinh viên",
      "address": "789 Nguyễn Trãi, Q.5",
      "price": "2.500.000 đ",
      "status": "Còn trống",
      "isNew": false,
      "isActive": false, 
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8),
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
            onPressed: () {
              // 2. Chuyển sang màn hình Thông báo khi ấn vào icon chuông
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              children: [
                // Phần thống kê
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      _buildStatCard("${rooms.length}", "Tổng số", Colors.black),
                      const SizedBox(width: 12),
                      _buildStatCard("${rooms.where((r) => r['status'] == 'Còn trống').length}", "Còn trống", primaryColor),
                      const SizedBox(width: 12),
                      _buildStatCard("${rooms.where((r) => r['status'] == 'Đã thuê').length}", "Đang thuê", Colors.orange),
                    ],
                  ),
                ),

                // Thanh tìm kiếm
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

                // Danh sách phòng
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: rooms.length,
                  itemBuilder: (context, index) {
                    final room = rooms[index];
                    return _buildRoomCard(
                      index: index,
                      title: room['title'],
                      address: room['address'],
                      price: room['price'],
                      status: room['status'],
                      isNew: room['isNew'],
                      isActive: room['isActive'],
                    );
                  },
                ),
              ],
            ),
          ),
          
          // Nút Đăng tin
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

  Widget _buildRoomCard({
    required int index,
    required String title,
    required String address,
    required String price,
    required String status,
    required bool isNew,
    required bool isActive,
  }) {
    bool isVacant = status == "Còn trống";

    return InkWell( 
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoomDetailScreen(
              roomData: {
                'name': title,
                'address': address,
                'price': price,
                'status': status,
                'area': '25', 
              },
            ),
          ),
        );
      },
      child: Opacity(
        opacity: isActive ? 1.0 : 0.6,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            isActive ? title : "$title (Tạm dừng)", 
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15), 
                            overflow: TextOverflow.ellipsis
                          ),
                        ),
                        _buildPopupMenu(index, isActive),
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
      ),
    );
  }

  Widget _buildPopupMenu(int index, bool isActive) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Colors.grey, size: 20),
      padding: EdgeInsets.zero,
      onSelected: (String value) {
        if (value == 'delete') {
          _showDeleteConfirmDialog(index);
        } else if (value == 'pause') {
          _showPauseConfirmDialog(index);
        } else if (value == 'resume') {
          _resumeRoom(index);
        }
      },
      itemBuilder: (BuildContext context) {
        if (isActive) {
          return [
            const PopupMenuItem(value: 'pause', child: Text('Tạm dừng hoạt động')),
            const PopupMenuItem(value: 'delete', child: Text('Xóa phòng', style: TextStyle(color: Colors.red))),
          ];
        } else {
          return [
            const PopupMenuItem(value: 'resume', child: Text('Hoạt động', style: TextStyle(color: Colors.green))),
            const PopupMenuItem(value: 'delete', child: Text('Xóa phòng', style: TextStyle(color: Colors.red))),
          ];
        }
      },
    );
  }

  void _showDeleteConfirmDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text('Xác nhận xóa', style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text('Bạn có chắc chắn muốn xóa phòng này không? Hành động này không thể hoàn tác.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                setState(() {
                  rooms.removeAt(index);
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã xóa phòng thành công!')));
              },
              child: const Text('Xóa', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showPauseConfirmDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text('Tạm dừng hoạt động', style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text('Bạn có chắc chắn muốn tạm dừng phòng này không? Phòng sẽ không còn hiển thị với người thuê.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: () {
                setState(() {
                  rooms[index]['isActive'] = false;
                });
                Navigator.pop(ctx);
              },
              child: const Text('Tạm dừng', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _resumeRoom(int index) {
    setState(() {
      rooms[index]['isActive'] = true; 
    });
    
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 60),
              const SizedBox(height: 16),
              const Text(
                'Thành công!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Chúc mừng! Phòng đã được hoạt động trở lại và có thể tiếp cận người thuê.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Đóng', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}