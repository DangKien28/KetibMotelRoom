import 'package:dartz/dartz.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_remote_datasource.dart';
import '../models/login_request_model.dart';

class LoginRepositoryImpl implements LoginRepository
{
    final LoginRemoteDatasource remoteDatasource;

    LoginRepositoryImpl({required this.remoteDatasource});

    @override
    Future<Either<String, UserEntity>> login({
        required String phoneNumber,
        required String password,
    }) async {
        try {
            final request = LoginRequestModel(
                phone: phoneNumber,
                password: password
            );

            final response = await remoteDatasource.postLogin(request);

            //Mapping
            final data = response['data'] ?? {};
            
            final user = UserEntity(
                id: data['id'],
                fullName: data['fullName'],
                email: data['email'],
                phoneNumber: data['phoneNumber'],
                token: data['token']
            );

            return Right(user);
        } catch (e) {
            return Left(e.toString());
        }
    }
}