import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Dữ liệu giả lập
  final List<Map<String, dynamic>> _notifications = [
    // Mục MỚI NHẤT
    {
      "id": "1",
      "type": "message", // message, payment, warning, offer, update
      "title": "Tin nhắn từ Cô Hạnh",
      "content": "Cháu ơi, cuối tuần này thợ sẽ qua bảo dưỡng điều hòa nhé. Cháu sắp xếp ở nhà mở cửa giúp cô.",
      "time": "10 phút trước",
      "isUnread": true,
      "section": "MỚI NHẤT"
    },
    {
      "id": "2",
      "type": "payment",
      "title": "Thanh toán thành công",
      "content": "Hóa đơn tiền điện tháng 9/2024 đã được thanh toán. Cảm ơn bạn!",
      "time": "2 giờ trước",
      "isUnread": true,
      "section": "MỚI NHẤT"
    },
    {
      "id": "3",
      "type": "warning",
      "title": "Hợp đồng sắp hết hạn",
      "content": "Hợp đồng thuê phòng 302 sẽ hết hạn trong 30 ngày tới. Vui lòng liên hệ chủ nhà để gia hạn.",
      "time": "5 giờ trước",
      "isUnread": false,
      "section": "MỚI NHẤT"
    },
    // Mục TRƯỚC ĐÓ
    {
      "id": "4",
      "type": "offer",
      "title": "Ưu đãi mùa tựu trường",
      "content": "Giảm ngay 20% phí dịch vụ tìm phòng cho sinh viên nhập học tháng 9. Nhập mã SV2024.",
      "time": "1 ngày trước",
      "isUnread": false,
      "section": "TRƯỚC ĐÓ"
    },
    {
      "id": "5",
      "type": "update",
      "title": "Cập nhật ứng dụng v2.1",
      "content": "Phiên bản mới cải thiện hiệu năng và sửa lỗi hiển thị bản đồ.",
      "time": "3 ngày trước",
      "isUnread": false,
      "section": "TRƯỚC ĐÓ"
    },
    {
      "id": "6",
      "type": "message",
      "title": "Tin nhắn từ Anh Tuấn",
      "content": "Em xem phòng lúc 18h tối nay được không?",
      "time": "4 ngày trước",
      "isUnread": false,
      "section": "TRƯỚC ĐÓ"
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Tách list thành 2 phần để hiển thị theo section
    final latestNotifications = _notifications.where((n) => n['section'] == "MỚI NHẤT").toList();
    final previousNotifications = _notifications.where((n) => n['section'] == "TRƯỚC ĐÓ").toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8),
      appBar: _buildAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (latestNotifications.isNotEmpty) ...[
            _buildSectionHeader("MỚI NHẤT"),
            const SizedBox(height: 12),
            ...latestNotifications.map((n) => _buildNotificationItem(n)),
          ],
          const SizedBox(height: 24),
          if (previousNotifications.isNotEmpty) ...[
            _buildSectionHeader("TRƯỚC ĐÓ"),
            const SizedBox(height: 12),
            ...previousNotifications.map((n) => _buildNotificationItem(n)),
          ],
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFF6F6F8),
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        "Thông báo",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text(
            "Đọc tất cả",
            style: TextStyle(
              color: Color(0xFF2B6CEE),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Dismissible(
        key: Key(notification['id']),
        direction: DismissDirection.endToStart,
        background: _buildSwipeBackground(),
        onDismissed: (direction) {
          setState(() {
            _notifications.removeWhere((item) => item['id'] == notification['id']);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${notification['title']} đã bị xóa")),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Stack(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: _getIconBgColor(notification['type']),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getIconData(notification['type']),
                      color: _getIconColor(notification['type']),
                      size: 24,
                    ),
                  ),
                  // Chấm nhỏ trên icon nếu cần (như design tin nhắn)
                  if (notification['type'] == 'message')
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2B6CEE),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            notification['title'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0D121B),
                            ),
                          ),
                        ),
                        // Unread Dot
                        if (notification['isUnread'])
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF2B6CEE),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification['content'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      notification['time'],
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: notification['isUnread'] ? const Color(0xFF2B6CEE) : Colors.grey.shade400,
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

  // Giao diện nền khi vuốt để xóa (Màu đỏ + Icon thùng rác)
  Widget _buildSwipeBackground() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444), // Màu đỏ
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.delete, color: Colors.white, size: 24),
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
    );
  }

  // --- Helpers để lấy màu sắc và icon theo loại thông báo ---

  IconData _getIconData(String type) {
    switch (type) {
      case 'message':
        return Icons.chat_bubble;
      case 'payment':
        return Icons.check_circle;
      case 'warning':
        return Icons.warning_rounded;
      case 'offer':
        return Icons.local_offer;
      case 'update':
        return Icons.system_update;
      default:
        return Icons.notifications;
    }
  }

  Color _getIconColor(String type) {
    switch (type) {
      case 'message':
        return const Color(0xFF2B6CEE); // Blue
      case 'payment':
        return const Color(0xFF10B981); // Green
      case 'warning':
        return const Color(0xFFF97316); // Orange
      case 'offer':
        return const Color(0xFF8B5CF6); // Purple
      case 'update':
        return const Color(0xFF64748B); // Slate
      default:
        return Colors.grey;
    }
  }

  Color _getIconBgColor(String type) {
    switch (type) {
      case 'message':
        return const Color(0xFFEFF6FF); // Blue-50
      case 'payment':
        return const Color(0xFFECFDF5); // Green-50
      case 'warning':
        return const Color(0xFFFFF7ED); // Orange-50
      case 'offer':
        return const Color(0xFFF5F3FF); // Purple-50
      case 'update':
        return const Color(0xFFF1F5F9); // Slate-100
      default:
        return Colors.grey.shade100;
    }
  }
}