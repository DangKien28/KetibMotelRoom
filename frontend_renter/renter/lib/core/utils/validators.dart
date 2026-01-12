class Validators {
  // Regex cho Email
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
  );

  // 1. Kiểm tra trường bắt buộc (không được để trống)
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập $fieldName';
    }
    return null;
  }

  // 2. Kiểm tra Email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập Email';
    }
    if (!_emailRegExp.hasMatch(value)) {
      return 'Email không đúng định dạng';
    }
    return null;
  }

  // 3. Kiểm tra Mật khẩu (Ví dụ: tối thiểu 6 ký tự)
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }
    if (value.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự';
    }
    return null;
  }

  // 4. Kiểm tra xác nhận mật khẩu
  static String? validateConfirmPassword(String? value, String originalPassword) {
    if (value != originalPassword) {
      return 'Mật khẩu xác nhận không khớp';
    }
    return null;
  }
}