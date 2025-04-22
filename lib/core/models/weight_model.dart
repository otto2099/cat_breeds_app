import 'package:flutter/foundation.dart';

@immutable
class WeightModel {
  const WeightModel({required this.imperial, required this.metric});

  final String imperial;
  final String metric;

  factory WeightModel.fromJson(Map<String, dynamic> json) {
    return WeightModel(
      imperial: json['imperial']?.toString() ?? '',
      metric: json['metric']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'imperial': imperial, 'metric': metric};
  }

  WeightModel copyWith({String? imperial, String? metric}) {
    return WeightModel(
      imperial: imperial ?? this.imperial,
      metric: metric ?? this.metric,
    );
  }
}
