import 'package:dartz/dartz.dart';
import '../entities/user_entity.dart';
import '../repositories/login_repository.dart';

class LoginUsecase {
    final LoginRepository repository;

    LoginUsecase(this.repository);

    Future<Either<String, UserEntity>> call({
        required String phoneNumber,
        required String password
    }) {
        return repository.login(phoneNumber: phoneNumber, password: password);
    }
}