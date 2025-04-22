import 'package:cat_breeds_app/core/entities/entity_model.dart';
import 'package:cat_breeds_app/core/models/weight_model.dart';
import 'package:flutter/foundation.dart';

@immutable
class CatBreedModel extends EntityModel {
  const CatBreedModel({
    required this.id,
    required this.name,
    required this.weight,
    required this.cfaUrl,
    required this.vetstreetUrl,
    required this.vcahospitalsUrl,
    required this.temperament,
    required this.origin,
    required this.countryCodes,
    required this.countryCode,
    required this.description,
    required this.lifeSpan,
    required this.indoor,
    required this.lap,
    required this.altNames,
    required this.adaptability,
    required this.affectionLevel,
    required this.childFriendly,
    required this.dogFriendly,
    required this.energyLevel,
    required this.grooming,
    required this.healthIssues,
    required this.intelligence,
    required this.sheddingLevel,
    required this.socialNeeds,
    required this.strangerFriendly,
  });

  final String id;
  final String name;
  final WeightModel weight;
  final String cfaUrl;
  final String vetstreetUrl;
  final String vcahospitalsUrl;
  final String temperament;
  final String origin;
  final String countryCodes;
  final String countryCode;
  final String description;
  final String lifeSpan;
  final int indoor;
  final int lap;
  final String altNames;
  final int adaptability;
  final int affectionLevel;
  final int childFriendly;
  final int dogFriendly;
  final int energyLevel;
  final int grooming;
  final int healthIssues;
  final int intelligence;
  final int sheddingLevel;
  final int socialNeeds;
  final int strangerFriendly;

  factory CatBreedModel.fromJson(Map<String, dynamic> json) {
    return CatBreedModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      weight: WeightModel.fromJson(json['weight']),
      cfaUrl: json['cfa_url'] ?? '',
      vetstreetUrl: json['vetstreet_url'] ?? '',
      vcahospitalsUrl: json['vcahospitals_url'] ?? '',
      temperament: json['temperament'] ?? '',
      origin: json['origin'] ?? '',
      countryCodes: json['country_codes'] ?? '',
      countryCode: json['country_code'] ?? '',
      description: json['description'] ?? '',
      lifeSpan: json['life_span'] ?? '',
      indoor: json['indoor'] ?? 0,
      lap: json['lap'] ?? 0,
      altNames: json['alt_names'] ?? '',
      adaptability: json['adaptability'] ?? 0,
      affectionLevel: json['affection_level'] ?? 0,
      childFriendly: json['child_friendly'] ?? 0,
      dogFriendly: json['dog_friendly'] ?? 0,
      energyLevel: json['energy_level'] ?? 0,
      grooming: json['grooming'] ?? 0,
      healthIssues: json['health_issues'] ?? 0,
      intelligence: json['intelligence'] ?? 0,
      sheddingLevel: json['shedding_level'] ?? 0,
      socialNeeds: json['social_needs'] ?? 0,
      strangerFriendly: json['stranger_friendly'] ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'weight': weight.toJson(),
      'cfa_url': cfaUrl,
      'vetstreet_url': vetstreetUrl,
      'vcahospitals_url': vcahospitalsUrl,
      'temperament': temperament,
      'origin': origin,
      'country_codes': countryCodes,
      'country_code': countryCode,
      'description': description,
      'life_span': lifeSpan,
      'indoor': indoor,
      'lap': lap,
      'alt_names': altNames,
      'adaptability': adaptability,
      'affection_level': affectionLevel,
      'child_friendly': childFriendly,
      'dog_friendly': dogFriendly,
      'energy_level': energyLevel,
      'grooming': grooming,
      'health_issues': healthIssues,
      'intelligence': intelligence,
      'shedding_level': sheddingLevel,
      'social_needs': socialNeeds,
      'stranger_friendly': strangerFriendly,
    };
  }

  @override
  EntityModel copyWith() {
    return CatBreedModel(
      id: id,
      name: name,
      weight: weight,
      cfaUrl: cfaUrl,
      vetstreetUrl: vetstreetUrl,
      vcahospitalsUrl: vcahospitalsUrl,
      temperament: temperament,
      origin: origin,
      countryCodes: countryCodes,
      countryCode: countryCode,
      description: description,
      lifeSpan: lifeSpan,
      indoor: indoor,
      lap: lap,
      altNames: altNames,
      adaptability: adaptability,
      affectionLevel: affectionLevel,
      childFriendly: childFriendly,
      dogFriendly: dogFriendly,
      energyLevel: energyLevel,
      grooming: grooming,
      healthIssues: healthIssues,
      intelligence: intelligence,
      sheddingLevel: sheddingLevel,
      socialNeeds: socialNeeds,
      strangerFriendly: strangerFriendly,
    );
  }
}
