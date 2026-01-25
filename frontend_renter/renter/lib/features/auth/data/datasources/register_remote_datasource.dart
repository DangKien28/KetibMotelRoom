import '../../../../core/network/dio_client.dart';
import '../models/register_request_model.dart';

abstract class RegisterRemoteDataSource {
  Future<dynamic> postRegister(RegisterRequestModel request);
}

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final DioClient dioClient;

  RegisterRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<dynamic> postRegister(RegisterRequestModel request) async {
    try {
      // Endpoint giữ nguyên là /auth/register vì Server quy định
      final response = await dioClient.post(
        '/auth/register', 
        data: request.toJson(),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}