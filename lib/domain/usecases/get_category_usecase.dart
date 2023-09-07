import 'package:punyatoko/data/models/response/category_model.dart';
import 'package:punyatoko/data/repositories/category_repository.dart';
import 'package:punyatoko/domain/entities/category_entity.dart';

class GetCategoryUseCase {
  final CategoryRepositoryImp categoryRepositoryImp;
  GetCategoryUseCase({required this.categoryRepositoryImp});

  Future<List<CategoryEntity>> getCategory() async {
    List<CategoryModel> model = await categoryRepositoryImp.getCategory();
    List<CategoryEntity> data = [];
    for (var mod in model) {
      data.add(mod.toEntity());
    }
    return data;
  }
}
