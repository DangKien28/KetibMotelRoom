abstract class LoginEvent {}

class LoginSubmitted extends LoginEvent {
    final String phoneNumber;
    final String password;

    LoginSubmitted({
        required this.phoneNumber,
        required this.password
    });
}