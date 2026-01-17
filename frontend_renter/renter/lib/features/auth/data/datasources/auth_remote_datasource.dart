import 'package:dio/dio.dart';
import 'package:renter/features/auth/data/models/login_request_model.dart';
import '../../../../../core/constants/ketib_api_constant.dart';
import '../models/register_request_model.dart';


class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource({required this.dio});


//1. Register
  Future<void> register(RegisterRequestModel request) async {
    try {
      final response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.registerEndpoint,
        data: request.toJson(),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data['message'] ?? 'Đăng ký thất bại');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Lỗi kết nối');
    }
  }

//2. Login
    Future<void> login(LoginRequestModel request)
    async
    {
        try
        {
            final respone = await dio.post(
                ApiConstants.baseUrl + ApiConstants.loginEndpoint,
                data: request.toJson(),
            );

            if (respone.statusCode != 200 && respone.statusCode !=201)
            {
                throw Exception(respone.data["message"]?? "Đăng ký thất bại");
            }
        }
        on DioException catch (e)
        {
            throw Exception(e.response?.data["message"]??"Lỗi kết nối");
        }
    }
}