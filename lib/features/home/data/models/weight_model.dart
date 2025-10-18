import '../../domain/entities/weight_entity.dart';

class WeightModel extends WeightEntity {
  const WeightModel({required super.imperial, required super.metric});

  factory WeightModel.fromJson(Map<String, dynamic> json) {
    return WeightModel(
      imperial: json['imperial'] as String? ?? '',
      metric: json['metric'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'imperial': imperial, 'metric': metric};
  }

  WeightEntity toEntity() {
    return WeightEntity(imperial: imperial, metric: metric);
  }
}
