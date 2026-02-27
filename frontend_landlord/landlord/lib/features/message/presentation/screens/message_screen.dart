// frontend_landlord/landlord/lib/features/message/presentation/screens/message_screen.dart
import 'package:flutter/material.dart';
// 1. Import màn hình Chi tiết tin nhắn
import 'detail_message_screen.dart'; 

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  // Dữ liệu giả lập danh sách tin nhắn
  final List<Map<String, dynamic>> _dummyMessages = [
    {
      'name': 'Nguyễn Văn A',
      'lastMessage': 'Dạ, phòng 101 còn trống không ạ?',
      'time': 'Vừa xong',
      'isUnread': true,
      'avatarUrl': 'https://via.placeholder.com/150',
    },
    {
      'name': 'Trần Thị B',
      'lastMessage': 'Cảm ơn anh, em sẽ chuyển khoản cọc sớm.',
      'time': '10:30 AM',
      'isUnread': false,
      'avatarUrl': 'https://via.placeholder.com/150',
    },
    {
      'name': 'Lê Văn C',
      'lastMessage': 'Tháng này tiền điện nước bao nhiêu vậy anh?',
      'time': 'Hôm qua',
      'isUnread': false,
      'avatarUrl': 'https://via.placeholder.com/150',
    },
    {
      'name': 'Phạm Thị D',
      'lastMessage': 'Bóng đèn nhà vệ sinh bị cháy rồi ạ.',
      'time': 'Hôm qua',
      'isUnread': false,
      'avatarUrl': 'https://via.placeholder.com/150',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Tin nhắn',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black54),
            onPressed: () {
              // TODO: Menu tùy chọn tin nhắn (đánh dấu đã đọc tất cả, v.v.)
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. Thanh tìm kiếm
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Tìm kiếm tin nhắn...',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFFF6F6F8), // Màu nền đồng bộ với app
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 8),

          // 2. Danh sách tin nhắn
          Expanded(
            child: ListView.separated(
              itemCount: _dummyMessages.length,
              separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF0F0F0), indent: 76),
              itemBuilder: (context, index) {
                final msg = _dummyMessages[index];
                return _buildMessageTile(
                  context,
                  name: msg['name'],
                  lastMessage: msg['lastMessage'],
                  time: msg['time'],
                  isUnread: msg['isUnread'],
                  avatarUrl: msg['avatarUrl'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget hiển thị từng dòng tin nhắn
  Widget _buildMessageTile(BuildContext context, {
    required String name,
    required String lastMessage,
    required String time,
    required bool isUnread,
    required String avatarUrl,
  }) {
    final Color primaryColor = const Color(0xFF2B6CEE);

    return InkWell(
      onTap: () {
        // 2. Điều hướng sang màn hình Chi tiết tin nhắn, truyền tên người gửi qua
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailMessageScreen(
              renterName: name,
              avatarUrl: avatarUrl,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 26,
              backgroundImage: NetworkImage(avatarUrl),
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(width: 16),
            
            // Nội dung tin nhắn
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          color: isUnread ? primaryColor : Colors.grey,
                          fontSize: 12,
                          fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, // Cắt chữ nếu quá dài
                    style: TextStyle(
                      color: isUnread ? Colors.black87 : Colors.grey[600],
                      fontWeight: isUnread ? FontWeight.w500 : FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            
            // Dấu chấm xanh báo tin nhắn chưa đọc
            if (isUnread) ...[
              const SizedBox(width: 12),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}