import 'package:cat_breeds_app/core/error/failures.dart';
import 'package:cat_breeds_app/core/http/api.dart';
import 'package:cat_breeds_app/core/models/image_breeds_models.dart';
import 'package:dio/dio.dart';

class BreedImageService extends ApiProvider {
  Future<List<BreedWithImageModel>> getCatImages(int page) async {
    try {
      final response = await dio.get(
        "/images/search",
        queryParameters: {
          "size": "med",
          "mime_types": "jpg",
          "format": "json",
          "has_breeds": true,
          "order": "ASC",
          "page": page,
          "limit": 5,
        },
      );
      return (response.data as List)
          .map((e) => BreedWithImageModel.fromJson(e))
          .toList();
    } on DioException catch (error) {
      throw ServerFailure(error: error);
    }
  }
}
