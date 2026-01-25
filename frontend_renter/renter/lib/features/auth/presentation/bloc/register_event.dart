abstract class RegisterEvent {}

class RegisterSubmitted extends RegisterEvent {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;

  RegisterSubmitted({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });
}