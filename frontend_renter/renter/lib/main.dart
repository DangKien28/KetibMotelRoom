import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 1. Import Config & Core
import 'config/theme/app_theme.dart';
import 'core/network/dio_client.dart';

// 2. Import Feature Auth (Clean Architecture)
import 'features/auth/data/datasources/register_remote_datasource.dart';
import 'features/auth/data/repositories/register_repository_impl.dart';
import 'features/auth/domain/repositories/register_repository.dart';
import 'features/auth/domain/usecases/register_usecase.dart';
import 'features/auth/presentation/bloc/register_bloc.dart';

// 3. Import Screens
import 'features/auth/presentation/screens/welcome_screen.dart';

void main() {
  // Đảm bảo Flutter Binding được khởi tạo trước khi chạy App
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Khởi tạo DioClient (đã được cấu hình BaseURL và Timeout bên trong class này)
    //
    final dioClient = DioClient();

    return MultiRepositoryProvider(
      // Cung cấp Repository cho toàn bộ App
      providers: [
        RepositoryProvider<RegisterRepository>(
          create: (context) => RegisterRepositoryImpl(
            // Truyền dioClient vào DataSource
            remoteDataSource: RegisterRemoteDataSourceImpl(dioClient: dioClient),
          ),
        ),
      ],
      child: MultiBlocProvider(
        // Cung cấp Bloc cho toàn bộ App (để màn hình con có thể truy cập)
        providers: [
          BlocProvider<RegisterBloc>(
            create: (context) => RegisterBloc(
              // Inject UseCase vào Bloc
              registerUseCase: RegisterUseCase(
                context.read<RegisterRepository>(),
              ),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Room Rental App',
          debugShowCheckedModeBanner: false,
          
          // Sử dụng Theme đã định nghĩa trong config
          //
          theme: AppTheme.lightTheme, 
          
          // Màn hình đầu tiên là WelcomeScreen (Logo + Nút Đăng nhập/Đăng ký)
          //
          home: const WelcomeScreen(),
        ),
      ),
    );
  }
}