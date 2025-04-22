import 'package:cat_breeds_app/core/entities/entity_model.dart';
import 'package:flutter/foundation.dart';

@immutable
class BreedWithImageModel extends EntityModel {
  const BreedWithImageModel({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  final String id;
  final String url;
  final int width;
  final int height;

  factory BreedWithImageModel.fromJson(Map<String, dynamic> json) {
    return BreedWithImageModel(
      // breeds:
      //     (json['breeds'] as List)
      //         .map((breedJson) => CatBreedModel.fromJson(breedJson))
      //         .toList(),
      id: json['id'],
      url: json['url'],
      width: json['width'],
      height: json['height'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'id': id, 'url': url, 'width': width, 'height': height};
  }

  @override
  EntityModel copyWith() {
    return BreedWithImageModel(
      id: id,
      // breeds: breeds,
      url: url,
      width: width,
      height: height,
    );
  }
}
