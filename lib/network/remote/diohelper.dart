// ignore_for_file: avoid_print

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

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
    //required String filePath,
  }) async {
    return await dio.download(
      imageUrl,
      '${(await getTemporaryDirectory()).path}image.jpg',
      options: Options(
        headers: {
          'Authorization':
              'v9gjiDXnnF6RkJ8CEdfS6erYsa9diuGPChjhAmvBuLRjFAKdUZgzeyDh',
          HttpHeaders.acceptEncodingHeader: '*'
        }, // Disable gzip
      ),
      onReceiveProgress: (received, total) {
        if (total != -1) {
          print('${(received / total * 100).toStringAsFixed(0)}%');
        }
      },
    );
  }
}
