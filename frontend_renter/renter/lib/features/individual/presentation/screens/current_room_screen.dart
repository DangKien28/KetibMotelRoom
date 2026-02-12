import 'package:flutter/material.dart';

class RoomInfoScreen extends StatelessWidget {
  const RoomInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8), // background-light
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildRoomHeader(),
            const SizedBox(height: 16),
            _buildContractInfo(),
            const SizedBox(height: 16),
            _buildServicesList(),
            const SizedBox(height: 16),
            _buildMembersList(),
            const SizedBox(height: 16),
            _buildLandlordContact(),
            const SizedBox(height: 24),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF6F6F8),
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        "Thông tin phòng trọ",
        style: TextStyle(
          color: Color(0xFF0D121B),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRoomHeader() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 160,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  image: DecorationImage(
                    image: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuB2lOh0PysHvIPu2HGuKHw0DS6b1CHfOtt1rXVOgIUT_sFfSleKR4eHlZaZhVZYEwN_sGrhEcYHWdEnOMn7EOHUx1oqP-2xQEJhnSEtat3eKq-aM9BHZ4JuAzdEzLkznYMaEhKTDOarFmCv98PhBSUshxGiDyJbC6gSbg3a3PMsF5M7ua-B-q-Bxr-mygXI5mlh8BkvxgEhSO-Z9bqSUynS3SpH1qTiQmgsB03lmidq7jG6aqR1-hbAoXVcTcVLQQVVUWNtOd-njM8"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "ĐANG Ở",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Phòng 302 - Nhà cô Hạnh",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0D121B)),
                ),
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Icon(Icons.location_on, size: 18, color: Colors.grey),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "123 Đường Láng, Đống Đa, Hà Nội",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContractInfo() {
    return _buildSectionContainer(
      title: "THÔNG TIN HỢP ĐỒNG",
      icon: Icons.assignment,
      child: Column(
        children: [
          _buildInfoRow("Mã hợp đồng", "HD-2024-302", isCopyable: true),
          _buildInfoRow("Ngày bắt đầu", "01/01/2024"),
          _buildInfoRow("Ngày kết thúc", "31/12/2024"),
          _buildInfoRow("Chu kỳ thanh toán", "Mùng 5 hàng tháng"),
          const Divider(height: 24),
          _buildInfoRow(
            "Giá thuê", 
            "4.500.000đ", 
            valueColor: const Color(0xFF2B6CEE), 
            isBold: true
          ),
          _buildInfoRow("Tiền cọc", "4.500.000đ"),
        ],
      ),
    );
  }

  Widget _buildServicesList() {
    return _buildSectionContainer(
      title: "DỊCH VỤ ĐĂNG KÝ",
      icon: Icons.electrical_services,
      child: Column(
        children: [
          _buildServiceRow(Icons.electric_bolt, Colors.orange, "Điện", "3.500đ/kWh"),
          const SizedBox(height: 12),
          _buildServiceRow(Icons.water_drop, Colors.blue, "Nước", "100.000đ/người"),
          const SizedBox(height: 12),
          _buildServiceRow(Icons.wifi, Colors.purple, "Internet", "100.000đ/phòng"),
          const SizedBox(height: 12),
          _buildServiceRow(Icons.cleaning_services, Colors.green, "Vệ sinh", "50.000đ/phòng"),
        ],
      ),
    );
  }

  Widget _buildMembersList() {
    return _buildSectionContainer(
      title: "THÀNH VIÊN (2)",
      icon: Icons.group,
      child: Column(
        children: [
          _buildMemberRow("Minh Tú (Tôi)", "0912 *** 678", true),
          const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider(height: 1)),
          _buildMemberRow("Nguyễn Văn B", "0987 *** 123", false),
        ],
      ),
    );
  }

  Widget _buildLandlordContact() {
    return _buildSectionContainer(
      title: "LIÊN HỆ CHỦ TRỌ",
      icon: Icons.contact_phone,
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuCjC1iUUJBNo1oqh3M5_OFsZ9qhDFShhyotrz8hUf4yEosszw7_MNimHCD56OMb2wRX5tEcS-_sptHheo9whx0zNbljRGyewvex3Ksc3pZIdefs2oHqid5c--Lkub8uUqWOYkFDwXpeBNCJKWYET4GJu4YU9tErUjulpAMGidEp5vjFYjwi1Rjd_1bEtk2zm8gCRvqMynoKPPTB6-SOxEFShp-zde9TWC0kUa5aAufoFhPWhaubRHBq5_L_S9tiX9nz5ta64nqbN1A"),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Cô Hạnh", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text("Chủ nhà", style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              backgroundColor: Color(0xFFEAF2FF),
              child: Icon(Icons.call, color: Color(0xFF2B6CEE), size: 20),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              backgroundColor: Color(0xFFEAF2FF),
              child: Icon(Icons.chat_bubble, color: Color(0xFF2B6CEE), size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.report_problem, size: 18),
            label: const Text("Báo cáo sự cố"),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: const BorderSide(color: Colors.red),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.payment, size: 18),
            label: const Text("Thanh toán"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2B6CEE),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }

  // --- Helper Widgets ---

  Widget _buildSectionContainer({required String title, required IconData icon, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: const Color(0xFF2B6CEE)),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor, bool isBold = false, bool isCopyable = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  color: valueColor ?? const Color(0xFF0D121B),
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
              if (isCopyable) ...[
                const SizedBox(width: 8),
                const Icon(Icons.copy, size: 14, color: Colors.grey),
              ]
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceRow(IconData icon, Color color, String name, String price) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.w600))),
        Text(price, style: const TextStyle(color: Colors.black54)),
      ],
    );
  }

  Widget _buildMemberRow(String name, String phone, bool isMe) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: Colors.grey.shade200,
          child: const Icon(Icons.person, color: Colors.grey, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  if (isMe) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)),
                      child: const Text("Bạn", style: TextStyle(fontSize: 10, color: Colors.grey)),
                    )
                  ]
                ],
              ),
              Text(phone, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}