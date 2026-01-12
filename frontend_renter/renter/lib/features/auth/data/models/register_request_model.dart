class RegisterRequestModel {
  final String name;
  final String phone;
  final String email;
  final String password;
  final String? taxCode;
  // backend có thể không cần confirmPassword, frontend tự check

  RegisterRequestModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    this.taxCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': name,
      'email': email,
      'phone_number': phone,
      'password': password,
      'role': 'renter', // Mặc định là người thuê
      'tax_code': taxCode ?? '', // Gửi chuỗi rỗng nếu không có
    };
  }
}