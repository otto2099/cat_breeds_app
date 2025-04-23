import 'package:cat_breeds_app/core/entities/entity_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EntityModel', () {
    test('toJson returns a valid JSON from EntityModel', () {
      const MockEntityModel entityModel = MockEntityModel();
      final Map<String, dynamic> result = entityModel.toJson();
      expect(result, equals(<String, dynamic>{}));
    });

    test('fromJson returns parsed json when source is valid json', () {
      const MockEntityModel entityModel = MockEntityModel();
      final Map<String, dynamic> result = entityModel.fromString(
        '{ "name": "John", "age": 30 }',
      );
      expect(result, <String, dynamic>{'name': 'John', 'age': 30});
      final MockEntityModel result2 = MockEntityModel.fromJson(result);
      expect(result2.runtimeType == MockEntityModel, true);
      expect(result2 == entityModel, true);
    });
    test('copyWith returns same model no matter what', () {
      const MockEntityModel entityModel = MockEntityModel();
      final EntityModel result = entityModel.copyWith();
      expect(result.hashCode, entityModel.hashCode);
    });
    test('test the bool == operator', () {
      const MockEntityModel entityModel = MockEntityModel();
      const MockEntityModel result = MockEntityModel();
      expect(result, equals(entityModel));
      expect(result == entityModel, equals(true));
      expect(result.hashCode, equals(entityModel.hashCode));

      const MockEntityModel.fromJson(<String, dynamic>{'data': ''});
    });
  });
}

class MockEntityModel extends EntityModel {
  const MockEntityModel();

  const MockEntityModel.fromJson(Map<String, dynamic> result);
  @override
  EntityModel copyWith() {
    return this;
  }

  @override
  bool operator ==(Object other) {
    return other.runtimeType == runtimeType;
  }

  @override
  int get hashCode {
    return 1;
  }
}
