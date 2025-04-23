import 'package:cat_breeds_app/core/models/breeds_models.dart';
import 'package:cat_breeds_app/env/env.dart';
import 'package:cat_breeds_app/injection_container.dart';
import 'package:cat_breeds_app/modules/landing/services/breed_image_service.dart';
import 'package:cat_breeds_app/core/error/failures.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  group('BreedImageService', () {
    test('getCatImages returns list of CatBreedModel', () async {
      dotenv.testLoad(
        fileInput: '''
        THE_CAT_API=https://api.mockcatapi.com/v1
      ''',
      );

      sl.registerLazySingleton(() => Env(EnvMode.dev));

      final dio = Dio();
      final service = BreedImageService()..dio = dio;
      final mockAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = mockAdapter;

      mockAdapter.onGet(
        '/breeds',
        (request) => request.reply(200, [
          {
            "id": "abob",
            "name": "American Bobtail",
            "weight": {"imperial": "7 - 16", "metric": "3 - 7"},
            "cfa_url": "url1",
            "vetstreet_url": "url2",
            "vcahospitals_url": "url3",
            "temperament": "Temperament",
            "origin": "USA",
            "country_codes": "US",
            "country_code": "US",
            "description": "Description",
            "life_span": "10 - 15",
            "indoor": 0,
            "lap": 1,
            "alt_names": "",
            "adaptability": 5,
            "affection_level": 5,
            "child_friendly": 4,
            "dog_friendly": 4,
            "energy_level": 3,
            "grooming": 2,
            "health_issues": 1,
            "intelligence": 5,
            "shedding_level": 2,
            "social_needs": 4,
            "stranger_friendly": 3,
            "wikipedia_url": "wiki",
            "image": {
              "id": "img123",
              "url": "https://cdn2.thecatapi.com/images/xyz.jpg",
              "width": 800,
              "height": 600,
            },
          },
        ]),
        queryParameters: {
          "size": "med",
          "mime_types": "jpg",
          "format": "json",
          "has_breeds": true,
          "order": "ASC",
          "page": 0,
          "limit": 5,
        },
      );

      final result = await service.getCatImages(0);
      expect(result, isA<List<CatBreedModel>>());
      expect(result.first.name, 'American Bobtail');
    });

    test('getCatImages throws ServerFailure on DioException', () async {
      dotenv.testLoad(
        fileInput: '''
        THE_CAT_API=https://api.mockcatapi.com/v1
      ''',
      );

      final dio = Dio();
      final service = BreedImageService()..dio = dio;
      final mockAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = mockAdapter;

      mockAdapter.onGet(
        '/breeds',
        (request) => request.throws(
          500,
          DioException(
            requestOptions: RequestOptions(path: '/breeds'),
            type: DioExceptionType.badResponse,
            response: Response(
              statusCode: 500,
              requestOptions: RequestOptions(path: '/breeds'),
            ),
          ),
        ),
        queryParameters: {
          "size": "med",
          "mime_types": "jpg",
          "format": "json",
          "has_breeds": true,
          "order": "ASC",
          "page": 0,
          "limit": 5,
        },
      );

      expect(
        () async => await service.getCatImages(0),
        throwsA(isA<ServerFailure>()),
      );
    });

    test('searchBreeds returns list of CatBreedModel', () async {
      // SETUP individual
      dotenv.testLoad(
        fileInput: '''
        THE_CAT_API=https://api.mockcatapi.com/v1
      ''',
      );

      final dio = Dio();
      final service = BreedImageService()..dio = dio;
      final mockAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = mockAdapter;

      mockAdapter.onGet(
        '/breeds/search',
        (request) => request.reply(200, [
          {
            "id": "abob",
            "name": "American Bobtail",
            "weight": {"imperial": "7 - 16", "metric": "3 - 7"},
            "image": {
              "id": "img123",
              "url": "https://cdn2.thecatapi.com/images/xyz.jpg",
              "width": 800,
              "height": 600,
            },
          },
        ]),
        queryParameters: {
          "size": "med",
          "mime_types": "jpg",
          "format": "json",
          "has_breeds": true,
          "order": "ASC",
          "page": 0,
          "limit": 5,
          "q": "bobtail",
          "attach_image": 1,
        },
      );

      final result = await service.searchBreeds(0, 'bobtail');
      expect(result, isA<List<CatBreedModel>>());
      expect(result.first.name, 'American Bobtail');
    });

    test('searchBreeds throws ServerFailure on DioException', () async {
      // SETUP individual
      dotenv.testLoad(
        fileInput: '''
        THE_CAT_API=https://api.mockcatapi.com/v1
      ''',
      );

      final dio = Dio();
      final service = BreedImageService()..dio = dio;
      final mockAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = mockAdapter;

      mockAdapter.onGet(
        '/breeds/search',
        (request) => request.throws(
          500,
          DioException(
            requestOptions: RequestOptions(path: '/breeds/search'),
            type: DioExceptionType.badResponse,
            response: Response(
              statusCode: 500,
              requestOptions: RequestOptions(path: '/breeds/search'),
            ),
          ),
        ),
        queryParameters: {
          "size": "med",
          "mime_types": "jpg",
          "format": "json",
          "has_breeds": true,
          "order": "ASC",
          "page": 0,
          "limit": 5,
          "q": "bobtail",
          "attach_image": 1,
        },
      );

      expect(
        () async => await service.searchBreeds(0, 'bobtail'),
        throwsA(isA<ServerFailure>()),
      );
    });
  });
}
