import 'package:punyatoko/domain/entities/category_entity.dart';

class CategoryModel {
  int? id, userId;
  String? name;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
  }

  CategoryEntity toEntity() {
    return CategoryEntity(id: id, userId: userId, name: name);
  }
}
