import 'package:cat_breeds_app/core/models/breeds_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CatBreedModel', () {
    final mockJson = {
      'id': 'abys',
      'name': 'Abyssinian',
      'weight': {'imperial': '7 - 10', 'metric': '3 - 5'},
      'cfa_url': 'http://cfa.org/abys',
      'vetstreet_url': 'http://vetstreet.com/abys',
      'vcahospitals_url': 'http://vcahospitals.com/abys',
      'temperament': 'Active, Energetic',
      'origin': 'Egypt',
      'country_codes': 'EG',
      'country_code': 'EG',
      'description': 'Abyssinians are elegant cats...',
      'life_span': '14 - 15',
      'indoor': 1,
      'lap': 1,
      'alt_names': 'Abys',
      'adaptability': 5,
      'affection_level': 5,
      'child_friendly': 4,
      'dog_friendly': 4,
      'energy_level': 5,
      'grooming': 1,
      'health_issues': 2,
      'intelligence': 5,
      'shedding_level': 3,
      'social_needs': 5,
      'stranger_friendly': 5,
      'wikipedia_url': 'https://en.wikipedia.org/wiki/Abyssinian_(cat)',
      'image': {
        'id': 'abc123',
        'url': 'https://cdn2.thecatapi.com/images/abc123.jpg',
        'width': 1200,
        'height': 800,
      },
    };

    test('fromJson crea una instancia correctamente', () {
      final cat = CatBreedModel.fromJson(mockJson);

      expect(cat.id, 'abys');
      expect(cat.name, 'Abyssinian');
      expect(cat.weight.metric, '3 - 5');
      expect(cat.image.url, 'https://cdn2.thecatapi.com/images/abc123.jpg');
    });

    test('toJson devuelve un mapa válido', () {
      final cat = CatBreedModel.fromJson(mockJson);
      final json = cat.toJson();

      expect(json['id'], 'abys');
      expect(json['name'], 'Abyssinian');
      expect(json['weight']['metric'], '3 - 5');
      expect(json['image'].url, 'https://cdn2.thecatapi.com/images/abc123.jpg');
    });
    test('copyWith retorna una nueva instancia idéntica', () {
      final original = CatBreedModel.fromJson(mockJson);
      final copy = original.copyWith() as CatBreedModel;

      expect(copy.id, original.id);
      expect(copy.name, original.name);
      expect(copy.weight.metric, original.weight.metric);
      expect(copy.image.url, original.image.url);
      expect(copy, isNot(same(original)));
    });
  });
}
