import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

// 1. Import Config & Core
import 'config/theme/app_theme.dart';
import 'core/constants/ketib_api_constant.dart';

// 2. Import Feature Auth (Data & Logic)
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

// 3. Import Screens
import 'features/auth/presentation/screens/welcome_screen.dart';

void main() {
  // Đảm bảo Flutter Binding được khởi tạo trước khi chạy app
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // A. CẤU HÌNH NETWORK (DIO)
    final dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl, // Đảm bảo URL này là IP LAN (vd: 192.168.1.X)
      connectTimeout: const Duration(seconds: 10), // Timeout sau 10s
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Thêm Log để dễ debug API (xem request/response trong tab Run)
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    return MultiRepositoryProvider(
      // B. CUNG CẤP REPOSITORY (Tầng dữ liệu)
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            remoteDataSource: AuthRemoteDataSource(dio: dio),
          ),
        ),
      ],
      child: MultiBlocProvider(
        // C. CUNG CẤP BLOC (Tầng logic)
        providers: [
          BlocProvider<AuthBloc>(
            // Bloc tự động lấy Repository từ context
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Room Rental App',
          debugShowCheckedModeBanner: false,
          
          // D. ÁP DỤNG THEME
          theme: AppTheme.lightTheme, 

          // E. MÀN HÌNH KHỞI ĐỘNG: LOGIN SCREEN
          home: const WelcomeScreen(),
        ),
      ),
    );
  }
}