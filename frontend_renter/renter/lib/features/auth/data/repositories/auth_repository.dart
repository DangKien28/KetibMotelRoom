import 'package:renter/features/auth/data/models/login_request_model.dart';

import '../datasources/auth_remote_datasource.dart';
import '../models/register_request_model.dart';


class AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepository({required this.remoteDataSource});

//1. Register
  Future<String?> register(RegisterRequestModel request) async {
    try {
      await remoteDataSource.register(request);
      return null; // Null nghĩa là thành công, không có lỗi
    } catch (e) {
      return e.toString(); // Trả về thông báo lỗi
    }
  }

//2. Login
    Future<String?> login(LoginRequestModel request)
    async
    {
        try
        {
            await remoteDataSource.login(request);
            return null;
        }
        catch (e)
        {
            return e.toString();
        }
    }

}