import 'package:dartz/dartz.dart';
import '../entities/user_entity.dart';

abstract class LoginRepository {
    Future<Either<String, UserEntity>> login({
        required String phoneNumber,
        required String password
    });
}