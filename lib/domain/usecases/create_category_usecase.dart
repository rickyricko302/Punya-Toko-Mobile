import 'package:punyatoko/data/repositories/category_repository.dart';

class CreateCategoryUseCase {
  final CategoryRepositoryImp categoryRepositoryImp;
  CreateCategoryUseCase({required this.categoryRepositoryImp});

  Future<int> createCategory({required String name}) async {
    return categoryRepositoryImp.createCategory(name: name);
  }
}
