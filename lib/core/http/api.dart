import 'package:cat_breeds_app/core/http/app_interceptors.dart';
import 'package:cat_breeds_app/env/env.dart';
import 'package:cat_breeds_app/injection_container.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  final String _baseApiUrl = sl<Env>().theCatApi;
  late Dio dio;

  ApiProvider() {
    dio = Dio(BaseOptions(baseUrl: _baseApiUrl));
    dio.interceptors.add(AppInterceptors());
  }
}
