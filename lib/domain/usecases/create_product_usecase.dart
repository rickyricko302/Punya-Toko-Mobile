import 'package:punyatoko/data/models/post/create_product_model.dart';
import 'package:punyatoko/data/repositories/product_repository.dart';

class CreateProductUseCase {
  final ProductRepositoryImp productRepositoryImp;
  const CreateProductUseCase({required this.productRepositoryImp});

  Future<int> createProduct({required CreateProductModel model}) {
    return productRepositoryImp.createProduct(model: model);
  }
}
