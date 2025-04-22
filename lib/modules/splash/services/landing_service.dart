import 'package:cat_breeds_app/core/error/failures.dart';
import 'package:cat_breeds_app/core/http/api.dart';
import 'package:cat_breeds_app/core/models/breeds_models.dart';
import 'package:dio/dio.dart';

class LandingService extends ApiProvider {
  Future<List<CatBreedModel>> getBreeds() async {
    try {
      final res = await dio.get("/breeds");
      return (res.data as List).map((e) => CatBreedModel.fromJson(e)).toList();
    } on DioException catch (error) {
      throw ServerFailure(error: error);
    }
  }
}
