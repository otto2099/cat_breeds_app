import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String title;
  final String message;
  final String code;

  const Failure({
    this.message = "Undefined error",
    this.title = "Unknown",
    this.code = "",
  });

  @override
  List<Object> get props => [message, title, code];
}

class ServerFailure extends Failure {
  final int? statusCode;
  final dynamic data;
  final DioException? error;

  const ServerFailure({
    String title = "Server Error",
    String message = "An error occurred",
    String code = "",
    this.statusCode,
    this.data,
    this.error,
  }) : super(title: title, message: message, code: code);

  factory ServerFailure.fromDioError(DioException e) {
    String message = "An unexpected error occurred";
    String title = "Error";
    String code = "";
    dynamic data;
    int? statusCode = e.response?.statusCode;

    if (e.response != null && e.response!.data != null) {
      if (e.response!.data is Map) {
        Map responseData = e.response!.data;
        message = responseData['description'] ?? message;
        title = responseData['title'] ?? title;
        code = responseData['code'] ?? code;
        data = responseData;
      } else if (e.response!.data is String) {
        message = e.response!.data;
        data = {"data": message};
      }
    }

    return ServerFailure(
      title: title,
      message: message,
      code: code,
      statusCode: statusCode,
      data: data,
      error: e,
    );
  }
}

class CacheFailure extends Failure {
  final dynamic error;

  const CacheFailure({
    String message = "Cache error",
    this.error,
  }) : super(message: message);

  @override
  List<Object> get props => [message, error];
}
