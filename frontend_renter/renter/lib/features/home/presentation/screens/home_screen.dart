import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:renter/features/home/data/models/room_model.dart';
import '../../../../core/constants/ketib_AppColors.dart';
import '../../../../core/widgets/ketib_home_filter_box.dart';
import '../../../../core/widgets/ketib_room_card.dart'; // Widget đã tạo ở bước trước
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Kích hoạt sự kiện lấy dữ liệu ngay khi màn hình khởi tạo
    context.read<HomeBloc>().add(GetHomeRoomsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView( // Cuộn toàn bộ màn hình
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header & Filter Box (Phần tĩnh - Giữ nguyên)
              _buildHeader(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: KetibHomeFilterBox(onSearchTap: null), // Callback null tạm thời
              ),
              const SizedBox(height: 24),

              // 2. PHẦN ĐỘNG: Danh sách phòng trọ
              _buildSectionHeader('Gợi ý cho bạn', () {}),

              // === KHU VỰC BLOC BUILDER ===
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  // TRƯỜNG HỢP 1: Đang tải
                  if (state is HomeLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(color: AppColors.primary),
                      ),
                    );
                  }

                  // TRƯỜNG HỢP 2: Có lỗi
                  if (state is HomeError) {
                    return Center(child: Text('Lỗi: ${state.message}'));
                  }

                  // TRƯỜNG HỢP 3: Tải thành công (Có dữ liệu)
                  if (state is HomeLoaded) {
                    final List<RoomEntity> rooms = state.rooms;

                    // Kiểm tra nếu danh sách rỗng
                    if (rooms.isEmpty) {
                      return const Center(child: Text("Chưa có phòng nào."));
                    }

                    // HIỂN THỊ NHIỀU PHÒNG DÙNG LISTVIEW.BUILDER
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shrinkWrap: true, // Quan trọng: Để list nằm gọn trong SingleChildScrollView
                      physics: const NeverScrollableScrollPhysics(), // Tắt scroll của list con
                      itemCount: rooms.length, // Số lượng lấy từ List
                      itemBuilder: (context, index) {
                        final room = rooms[index]; // Lấy từng entity ra

                        // Map dữ liệu từ Entity vào Widget UI
                        return KetibRoomCard(
                          title: room.title,
                          address: room.address,
                          price: '${room.price} triệu/tháng', // Format tiền tệ
                          imageUrl: room.imageUrl,
                          hostName: room.hostName,
                          isFavorite: room.isFavorite,
                          onTap: () {
                            // Điều hướng sang trang chi tiết
                            // Navigator.pushNamed(context, '/room_detail', arguments: room);
                          },
                        );
                      },
                    );
                  }

                  // TRƯỜNG HỢP 4: Khởi tạo
                  return const SizedBox.shrink();
                },
              ),
              
              const SizedBox(height: 80), // Padding đáy cho BottomNav
            ],
          ),
        ),
      ),
    );
  }

  // Widget Header tách riêng cho gọn code
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Xin chào,', style: TextStyle(color: AppColors.textLight)),
              SizedBox(height: 4),
              Text(
                'Minh Quang 👋',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMain),
              ),
            ],
          ),
          const CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
          )
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeAll) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMain)),
          GestureDetector(
            onTap: onSeeAll,
            child: const Text('Xem tất cả',
                style: TextStyle(
                    color: AppColors.primary, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}