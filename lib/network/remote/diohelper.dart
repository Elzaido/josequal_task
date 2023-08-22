import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio();

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://api.pexels.com/v1/',
      // even when we have a status error recieve :
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    dio.options.headers = {
      'Authorization':
          'v9gjiDXnnF6RkJ8CEdfS6erYsa9diuGPChjhAmvBuLRjFAKdUZgzeyDh',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> downloadImage({
    required String imageUrl,
    required String filePath,
  }) async {
    dio.options.headers = {
      'Authorization':
          'Bearer v9gjiDXnnF6RkJ8CEdfS6erYsa9diuGPChjhAmvBuLRjFAKdUZgzeyDh',
    };
    return dio.download(imageUrl, filePath);
  }
}
