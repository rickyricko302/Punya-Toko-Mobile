import 'package:punyatoko/data/repositories/category_repository.dart';

class DeleteCategoryUseCase {
  final CategoryRepositoryImp categoryRepositoryImp;
  DeleteCategoryUseCase({required this.categoryRepositoryImp});

  Future<int> deleteCategory({required int idCategory}) async {
    return await categoryRepositoryImp.deleteCategory(idCategory: idCategory);
  }
}
