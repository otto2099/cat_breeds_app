import 'package:flutter_test/flutter_test.dart';
import 'package:cat_breeds_app/core/models/weight_model.dart';

void main() {
  group('WeightModel', () {
    final mockJson = {'imperial': '7 - 10', 'metric': '3 - 5'};

    test('fromJson crea una instancia correctamente', () {
      final weight = WeightModel.fromJson(mockJson);

      expect(weight.imperial, '7 - 10');
      expect(weight.metric, '3 - 5');
    });

    test('toJson genera un Map válido', () {
      final weight = WeightModel.fromJson(mockJson);
      final json = weight.toJson();

      expect(json['imperial'], '7 - 10');
      expect(json['metric'], '3 - 5');
    });

    test('copyWith retorna una nueva instancia con valores modificados', () {
      final weight = WeightModel.fromJson(mockJson);
      final modified = weight.copyWith(metric: '4 - 6');

      expect(modified.imperial, '7 - 10');
      expect(modified.metric, '4 - 6');
    });

    test('copyWith sin parámetros retorna una copia idéntica', () {
      final weight = WeightModel.fromJson(mockJson);
      final copy = weight.copyWith();

      expect(copy.imperial, weight.imperial);
      expect(copy.metric, weight.metric);
      expect(copy, isNot(same(weight)));
    });
  });
}
