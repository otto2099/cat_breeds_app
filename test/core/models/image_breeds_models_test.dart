import 'package:flutter_test/flutter_test.dart';
import 'package:cat_breeds_app/core/models/image_breeds_models.dart';

void main() {
  group('BreedWithImageModel', () {
    final mockJson = {
      'id': 'abc123',
      'url': 'https://cdn2.thecatapi.com/images/abc123.jpg',
      'width': 1200,
      'height': 800,
    };

    test('fromJson crea una instancia correctamente', () {
      final image = BreedWithImageModel.fromJson(mockJson);

      expect(image.id, 'abc123');
      expect(image.url, 'https://cdn2.thecatapi.com/images/abc123.jpg');
      expect(image.width, 1200);
      expect(image.height, 800);
    });

    test('toJson genera un Map válido', () {
      final image = BreedWithImageModel.fromJson(mockJson);
      final json = image.toJson();

      expect(json['id'], 'abc123');
      expect(json['url'], 'https://cdn2.thecatapi.com/images/abc123.jpg');
      expect(json['width'], 1200);
      expect(json['height'], 800);
    });

    test('copyWith retorna una copia idéntica', () {
      final original = BreedWithImageModel.fromJson(mockJson);
      final copy = original.copyWith() as BreedWithImageModel;

      expect(copy.id, original.id);
      expect(copy.url, original.url);
      expect(copy.width, original.width);
      expect(copy.height, original.height);
      expect(copy, isNot(same(original))); // no es la misma instancia
    });
  });
}
