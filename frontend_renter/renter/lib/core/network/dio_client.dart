import 'package:dio/dio.dart';

class DioClient {
  // 1. Khởi tạo instance của Dio
  final Dio _dio;

  // URL gốc của API
  final String baseUrl = "https://api.example.com";

  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: "https://api.example.com",
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: {'Content-Type': 'application/json'},
          ),
        ) {
    // 2. Thêm Interceptors (Tùy chọn: dùng để log hoặc thêm token)
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Ví dụ: Thêm token vào header nếu có
        // options.headers['Authorization'] = 'Bearer $token';
        print("Request: ${options.method} ${options.path}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print("Response: ${response.statusCode}");
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        print("Error: ${e.message}");
        return handler.next(e);
      },
    ));
  }

  // 3. Các phương thức GET, POST, PUT, DELETE

  // GET Request
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // POST Request
  Future<Response> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Xử lý lỗi cơ bản
  Exception _handleError(dynamic error) {
    if (error is DioException) {
      // Xử lý các loại lỗi cụ thể của Dio tại đây
      return Exception("Lỗi kết nối: ${error.message}");
    }
    return Exception("Đã xảy ra lỗi không xác định");
  }
}