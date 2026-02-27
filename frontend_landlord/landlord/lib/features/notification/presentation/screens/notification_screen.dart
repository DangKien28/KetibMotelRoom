import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF2B6CEE);

    // Dữ liệu thông báo giả lập
    final List<Map<String, dynamic>> notifications = [
      {
        "title": "Có người muốn thuê phòng!",
        "content": "Nguyễn Văn A vừa gửi yêu cầu xem phòng 'Phòng trọ cao cấp Q.3'.",
        "time": "10 phút trước",
        "isRead": false,
        "icon": Icons.home_work,
        "iconColor": Colors.orange,
      },
      {
        "title": "Hợp đồng sắp hết hạn",
        "content": "Hợp đồng của phòng 102 - Căn hộ mini Lê Văn Sỹ sẽ hết hạn trong 7 ngày tới.",
        "time": "2 giờ trước",
        "isRead": false,
        "icon": Icons.assignment_late,
        "iconColor": Colors.red,
      },
      {
        "title": "Cập nhật ứng dụng thành công",
        "content": "KetibRoom vừa cập nhật các tính năng quản lý doanh thu mới. Hãy khám phá ngay!",
        "time": "1 ngày trước",
        "isRead": true,
        "icon": Icons.system_update,
        "iconColor": primaryColor,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Thông báo',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all, color: Color(0xFF2B6CEE)),
            tooltip: 'Đánh dấu đã đọc tất cả',
            onPressed: () {},
          ),
        ],
      ),
      body: notifications.isEmpty
          ? const Center(child: Text("Bạn chưa có thông báo nào."))
          : ListView.separated(
              itemCount: notifications.length,
              separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFE0E0E0)),
              itemBuilder: (context, index) {
                final notif = notifications[index];
                return _buildNotificationItem(notif);
              },
            ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notif) {
    final bool isRead = notif['isRead'];

    return Container(
      color: isRead ? Colors.transparent : Colors.blue.withOpacity(0.05),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon thông báo
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: notif['iconColor'].withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(notif['icon'], color: notif['iconColor'], size: 24),
          ),
          const SizedBox(width: 16),
          
          // Nội dung thông báo
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notif['title'],
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: isRead ? FontWeight.w600 : FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  notif['content'],
                  style: TextStyle(
                    fontSize: 13,
                    color: isRead ? Colors.grey[600] : Colors.black87,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  notif['time'],
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          
          // Chấm tròn báo chưa đọc
          if (!isRead)
            Container(
              margin: const EdgeInsets.only(top: 6),
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Color(0xFF2B6CEE),
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}