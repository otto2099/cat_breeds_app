import 'package:cat_breeds_app/core/error/failures.dart';
import 'package:cat_breeds_app/core/http/api.dart';
import 'package:cat_breeds_app/core/models/breeds_models.dart';
import 'package:dio/dio.dart';

class BreedImageService extends ApiProvider {
  Future<List<CatBreedModel>> getCatImages(int page) async {
    try {
      final response = await dio.get(
        "/breeds",
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
          .map((e) => CatBreedModel.fromJson(e))
          .toList();
    } on DioException catch (error) {
      throw ServerFailure(error: error);
    }
  }

  Future<List<CatBreedModel>> searchBreeds(int page, String q) async {
    try {
      final response = await dio.get(
        "/breeds/search",
        queryParameters: {
          "size": "med",
          "mime_types": "jpg",
          "format": "json",
          "has_breeds": true,
          "order": "ASC",
          "page": page,
          "limit": 5,
          "q": q,
          "attach_image": 1,
        },
      );
      return (response.data as List)
          .map((e) => CatBreedModel.fromJson(e))
          .toList();
    } on DioException catch (error) {
      throw ServerFailure(error: error);
    }
  }
}
