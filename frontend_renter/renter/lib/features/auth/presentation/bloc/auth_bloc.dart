import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:renter/features/auth/data/models/login_request_model.dart';
import '../../data/models/register_request_model.dart';
import '../../data/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    // Xử lý sự kiện Đăng ký
    on<RegisterSubmitted>(_onRegisterSubmitted);
    //Xử lý sự kiện đăng nhập
    on<LoginSubmitted>(_onLoginSubmitted);

  }

//1. Register
  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading()); // 1. Báo hiệu UI hiển thị loading

    try {
      // 2. Tạo model từ dữ liệu event gửi sang
      final requestModel = RegisterRequestModel(
        name: event.name,
        phone: event.phone,
        email: event.email,
        password: event.password,
      );

      // 3. Gọi repository
      final error = await authRepository.register(requestModel);

      // 4. Kiểm tra kết quả
      if (error == null) {
        emit(AuthSuccess()); // Thành công
      } else {
        emit(AuthFailure(error)); // Thất bại, gửi kèm lỗi
      }
    } catch (e) {
      emit(AuthFailure("Đã xảy ra lỗi không mong muốn: $e"));
    }
  }

//2. Login
    Future<void> _onLoginSubmitted(LoginSubmitted event, Emitter<AuthState> emit)
    async
    {
        emit(AuthLoading());
        
        try
        {
            final requestModel = LoginRequestModel(
                phone: event.phone,
                password: event.password
            );

            final error = await authRepository.login(requestModel);

            if (error==null)
            {
                emit(AuthSuccess());
            }
            else
            {
                emit(AuthFailure(error));
            }
        }
        catch (e)
        {
            emit(AuthFailure("Đã xảy ra lỗi. Lỗi $e"));
        }
    }
}