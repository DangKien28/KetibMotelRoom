abstract class AuthEvent {}

// Sự kiện khi người dùng nhấn nút "Đăng ký"
//1. Register
class RegisterSubmitted extends AuthEvent {
  final String name;
  final String phone;
  final String email;
  final String password;

  RegisterSubmitted({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
  });
}

//2. Login
class LoginSubmitted extends AuthEvent {
  final String email;
  final String password;
  LoginSubmitted({required this.email, required this.password});
}