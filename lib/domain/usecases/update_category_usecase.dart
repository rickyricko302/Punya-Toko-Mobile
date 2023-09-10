import 'package:punyatoko/data/repositories/category_repository.dart';

class UpdateCategoryUseCase {
  final CategoryRepositoryImp categoryRepositoryImp;
  const UpdateCategoryUseCase({required this.categoryRepositoryImp});

  updateCategory({required int idCategory, required String categoryName}) {
    return categoryRepositoryImp.updateCategory(
        idCategory: idCategory, categoryName: categoryName);
  }
}
