import 'package:dartz/dartz.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/register_repository.dart';
import '../datasources/register_remote_datasource.dart';
import '../models/register_request_model.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSource remoteDataSource;

  RegisterRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, UserEntity>> register({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final request = RegisterRequestModel(
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
      );

      final response = await remoteDataSource.postRegister(request);

      // Mapping response
      final data = response['data'] ?? {};
      final user = UserEntity(
        id: data['_id'] ?? '',
        fullName: data['full_name'] ?? fullName,
        email: data['email'] ?? email,
        phoneNumber: data['phone_number'] ?? phoneNumber,
        token: response['token'], // Giả sử server trả về token ngay khi đăng ký
      );

      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }
}