import 'package:dartz/dartz.dart';
import '../entities/user_entity.dart';
import '../repositories/register_repository.dart';

class RegisterUseCase {
  final RegisterRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<String, UserEntity>> call({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
  }) {
    return repository.register(
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
    );
  }
}