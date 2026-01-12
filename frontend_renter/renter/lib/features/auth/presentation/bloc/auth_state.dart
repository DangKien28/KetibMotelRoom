abstract class AuthState {}

// Trạng thái ban đầu khi chưa làm gì cả
class AuthInitial extends AuthState {}

// Trạng thái khi đang gọi API (xoay vòng tròn loading)
class AuthLoading extends AuthState {}

// Trạng thái khi đăng ký/đăng nhập thành công
class AuthSuccess extends AuthState {}

// Trạng thái khi có lỗi xảy ra (trả về kèm thông báo lỗi)
class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}