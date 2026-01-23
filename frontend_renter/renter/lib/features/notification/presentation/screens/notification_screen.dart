import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Màu sắc định nghĩa theo Tailwind config trong file HTML
  static const Color kPrimaryColor = Color(0xFF2B6CEE);
  static const Color kBackgroundColor = Color(0xFFF6F6F8);
  static const Color kSurfaceColor = Colors.white;
  static const Color kTextPrimary = Color(0xFF0F172A); // Slate 900
  static const Color kTextSecondary = Color(0xFF64748B); // Slate 500
  static const Color kDangerColor = Color(0xFFEF4444);

  // Dữ liệu mẫu mô phỏng (Structure để chứa nội dung)
  final List<Map<String, dynamic>> _newNotifications = [
    {
      "id": 1,
      "title": "Tin nhắn từ Cô Hạnh",
      "body": "Cháu ơi, cuối tuần này thợ sẽ qua bảo dưỡng điều hòa nhé. Cháu sắp xếp ở nhà mở cửa giúp cô.",
      "time": "10 phút trước",
      "icon": Icons.chat_bubble,
      "iconColor": kPrimaryColor,
      "iconBg": Color(0xFFEFF6FF), // Blue 50
      "isUnread": true,
    },
    {
      "id": 2,
      "title": "Thanh toán thành công",
      "body": "Hóa đơn tiền điện tháng 9/2024 đã được thanh toán. Cảm ơn bạn!",
      "time": "2 giờ trước",
      "icon": Icons.check_circle,
      "iconColor": Colors.green,
      "iconBg": Color(0xFFF0FDF4), // Green 50
      "isUnread": true,
    },
    {
      "id": 3,
      "title": "Hợp đồng sắp hết hạn",
      "body": "Hợp đồng thuê phòng 302 sẽ hết hạn trong 30 ngày tới. Vui lòng liên hệ chủ nhà để gia hạn.",
      "time": "5 giờ trước",
      "icon": Icons.warning,
      "iconColor": Colors.orange,
      "iconBg": Color(0xFFFFF7ED), // Orange 50
      "isUnread": false,
    },
  ];

  final List<Map<String, dynamic>> _oldNotifications = [
    {
      "id": 4,
      "title": "Ưu đãi mùa tựu trường",
      "body": "Giảm ngay 20% phí dịch vụ tìm phòng cho sinh viên nhập học tháng 9. Nhập mã SV2024.",
      "time": "1 ngày trước",
      "icon": Icons.local_offer,
      "iconColor": Colors.purple,
      "iconBg": Color(0xFFFAF5FF), // Purple 50
      "isUnread": false,
    },
    {
      "id": 5,
      "title": "Cập nhật ứng dụng v2.1",
      "body": "Phiên bản mới cải thiện hiệu năng và sửa lỗi hiển thị bản đồ.",
      "time": "3 ngày trước",
      "icon": Icons.system_update,
      "iconColor": Colors.blueGrey,
      "iconBg": Color(0xFFF1F5F9), // Slate 100
      "isUnread": false,
    },
    {
      "id": 6,
      "title": "Tin nhắn từ Anh Hải",
      "body": "Em xem phòng lúc 18h tối nay được không?",
      "time": "4 ngày trước",
      "icon": Icons.chat_bubble,
      "iconColor": kPrimaryColor,
      "iconBg": Color(0xFFEFF6FF),
      "isUnread": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader("MỚI NHẤT"),
              const SizedBox(height: 12),
              ..._newNotifications.map((e) => _buildNotificationItem(e)),
              
              const SizedBox(height: 24),
              
              _buildSectionHeader("TRƯỚC ĐÓ"),
              const SizedBox(height: 12),
              ..._oldNotifications.map((e) => _buildNotificationItem(e)),
              
              // Khoảng trống dưới cùng để không bị che bởi BottomNav ảo
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // 1. App Bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: kBackgroundColor, // Hoặc Colors.white/0.95 opacity
      elevation: 0,
      centerTitle: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: kTextSecondary),
        onPressed: () {
          // Xử lý quay lại
          Navigator.pop(context);
        },
      ),
      title: const Text(
        "Thông báo",
        style: TextStyle(
          color: kTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Plus Jakarta Sans', 
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text(
            "Đọc tất cả",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  // 2. Section Header (Mới nhất / Trước đó)
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: kTextSecondary,
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
      ),
    );
  }

  // 3. Notification Item Card (Có chức năng vuốt xóa)
  Widget _buildNotificationItem(Map<String, dynamic> data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Dismissible(
        key: Key(data['id'].toString()),
        direction: DismissDirection.endToStart,
        background: Container(
          decoration: BoxDecoration(
            color: kDangerColor,
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.delete, color: Colors.white),
              SizedBox(height: 4),
              Text(
                "Xóa",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        onDismissed: (direction) {
          // Xử lý logic xóa item khỏi list tại đây
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: kSurfaceColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(color: Colors.grey.withOpacity(0.1)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon tròn
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: data['iconBg'],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  data['icon'],
                  color: data['iconColor'],
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              
              // Nội dung Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            data['title'],
                            style: const TextStyle(
                              color: kTextPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // Dấu chấm xanh nếu chưa đọc
                        if (data['isUnread'] == true)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: kPrimaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data['body'],
                      style: const TextStyle(
                        color: kTextSecondary, // Slate 600
                        fontSize: 12,
                        height: 1.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      data['time'],
                      style: TextStyle(
                        color: data['isUnread'] ? kPrimaryColor : Colors.grey.shade400,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
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

  // 4. Bottom Navigation Bar (Giả lập giống thiết kế)
  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kTextPrimary, // Giả sử Trang chủ đang active, hoặc null
        unselectedItemColor: Colors.grey.shade400,
        selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Trang chủ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Đã lưu",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: "Tin nhắn",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Cá nhân",
          ),
        ],
        onTap: (index) {
          // Xử lý điều hướng
        },
      ),
    );
  }
}