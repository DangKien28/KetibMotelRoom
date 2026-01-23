import 'package:flutter/material.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  // --- COLOR CONSTANTS (Based on HTML/Image) ---
  static const Color kPrimaryColor = Color(0xFF2B6CEE);
  static const Color kBackgroundColor = Color(0xFFF6F6F8);
  static const Color kSurfaceColor = Colors.white;
  static const Color kTextPrimary = Color(0xFF0F172A);
  static const Color kTextSecondary = Color(0xFF64748B);
  static const Color kInputBgColor = Color(0xFFF1F5F9); // Slate 100

  // --- MOCK STRUCTURE (Cấu trúc khung, không chứa dữ liệu thật) ---
  // isMe: true -> Tin nhắn của mình (Bên phải, màu xanh)
  // isMe: false -> Tin nhắn đối phương (Bên trái, màu trắng)
  final List<Map<String, dynamic>> _messages = [
    {
      'isMe': true, 
      'message': 'Nội dung tin nhắn mẫu hiển thị ở đây (dòng 1)...', 
      'time': '10:23'
    },
    {
      'isMe': false, 
      'message': 'Nội dung phản hồi mẫu từ phía người dùng kia.', 
      'time': '10:24'
    },
    {
      'isMe': true, 
      'message': 'Nội dung tin nhắn dài hơn để kiểm tra khả năng xuống dòng của khung chat xem có bị vỡ giao diện không.', 
      'time': '10:25'
    },
    {
      'isMe': false, 
      'message': 'Câu trả lời ngắn.', 
      'time': '10:26'
    },
    {
      'isMe': true, 
      'message': 'Chốt phương án.', 
      'time': '10:28'
    },
    {
      'isMe': false, 
      'message': 'Xác nhận đồng ý với yêu cầu.', 
      'time': '10:30'
    },
  ];

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Time Stamp Header (Ngày tháng)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Hôm nay, 10:23", // Time Placeholder
                style: TextStyle(color: kTextSecondary, fontSize: 11, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          
          // Chat List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessageBubble(
                  isMe: msg['isMe'],
                  message: msg['message'],
                  time: msg['time'],
                  showAvatar: !msg['isMe'], // Chỉ hiện avatar cho tin nhắn người khác
                );
              },
            ),
          ),
          
          // Read Receipt Label
          Padding(
            padding: const EdgeInsets.only(right: 16, bottom: 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Đã xem",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // Input Area
          _buildInputArea(),
        ],
      ),
    );
  }

  // 1. App Bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: kSurfaceColor,
      elevation: 0.5,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: kTextSecondary),
        onPressed: () => Navigator.pop(context),
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          // Avatar Placeholder
          Stack(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: const Icon(Icons.person, color: Colors.white),
                // TODO: Load Network Image here
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: kSurfaceColor, width: 1.5),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(width: 10),
          // Name & Status Info Frame
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Tên người dùng", // Name Placeholder
                style: TextStyle(
                  color: kTextPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Plus Jakarta Sans',
                ),
              ),
              Text(
                "Trạng thái hoạt động", // Status Placeholder
                style: TextStyle(color: kTextSecondary, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.call, color: kPrimaryColor),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  // 2. Chat Bubble Widget
  Widget _buildMessageBubble({
    required bool isMe,
    required String message,
    required String time,
    bool showAvatar = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end, // Align avatar to bottom
        children: [
          // Avatar for Other User
          if (!isMe) ...[
            Container(
              width: 28,
              height: 28,
              margin: const EdgeInsets.only(right: 8, bottom: 4), // Căn chỉnh nhẹ với bubble
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              // TODO: Avatar Image
            ),
          ],

          // Bubble Content
          Flexible( // Cho phép xuống dòng nếu text quá dài
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isMe ? kPrimaryColor : kSurfaceColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: isMe ? const Radius.circular(18) : const Radius.circular(4), // Góc nhọn bên trái nếu là người khác
                      bottomRight: isMe ? const Radius.circular(4) : const Radius.circular(18), // Góc nhọn bên phải nếu là mình
                    ),
                    boxShadow: !isMe ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ] : [],
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: isMe ? Colors.white : kTextPrimary,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                // Time Text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    time,
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 3. Input Area
  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10).copyWith(
        bottom: MediaQuery.of(context).padding.bottom + 10 // Safe Area Bottom
      ),
      decoration: BoxDecoration(
        color: kSurfaceColor,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          // Plus Button
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_circle_outline, color: kTextSecondary),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 12),
          
          // Text Field Container
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 44,
              decoration: BoxDecoration(
                color: kInputBgColor,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "Nhập tin nhắn...",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: const TextStyle(fontSize: 14, color: kTextPrimary),
                    ),
                  ),
                  const Icon(Icons.sentiment_satisfied_alt, color: Colors.grey, size: 20),
                ],
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Send Button
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: kPrimaryColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.send, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}