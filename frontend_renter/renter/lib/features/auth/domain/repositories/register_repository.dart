import 'package:dartz/dartz.dart';
import '../entities/user_entity.dart';

abstract class RegisterRepository {
  Future<Either<String, UserEntity>> register({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
  });
}