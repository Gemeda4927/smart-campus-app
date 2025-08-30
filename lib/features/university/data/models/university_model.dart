// data/models/university_model.dart
import '../../domain/entities/university.dart';

class UniversityModel extends University {
  UniversityModel({
    required String id,
    required String name,
    required String location,
    required String type,
    required bool featured,
    required String imageUrl,
  }) : super(
         id: id,
         name: name,
         location: location,
         type: type,
         featured: featured,
         imageUrl: imageUrl,
       );

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      type: json['type'] ?? 'Public',
      featured: json['featured'] ?? false,
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "location": location,
      "type": type,
      "featured": featured,
      "imageUrl": imageUrl,
    };
  }
}
