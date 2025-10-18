class FavoriteModel {
  final int id;
  final String userId;
  final String imageId;
  final String subId;
  final String createdAt;

  const FavoriteModel({
    required this.id,
    required this.userId,
    required this.imageId,
    required this.subId,
    required this.createdAt,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'] as int? ?? 0,
      userId: json['user_id'] as String? ?? '',
      imageId: json['image_id'] as String? ?? '',
      subId: json['sub_id'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'image_id': imageId,
      'sub_id': subId,
      'created_at': createdAt,
    };
  }
}
