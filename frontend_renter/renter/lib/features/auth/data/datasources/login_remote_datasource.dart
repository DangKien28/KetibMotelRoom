import '../../../../core/network/dio_client.dart';
import '../models/login_request_model.dart';

abstract class LoginRemoteDatasource
{
    Future<dynamic> postLogin(LoginRequestModel request);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDatasource
{
    final DioClient dioClient;

    LoginRemoteDataSourceImpl({required this.dioClient});

    @override
    Future<dynamic> postLogin(LoginRequestModel request) async
    {
        try
        {
            final response = await dioClient.post(
                '/auth/login',
                data: request.toJson(),
            );
            return response.data;
        }
        catch (e) {
            rethrow;
        }
    }
}