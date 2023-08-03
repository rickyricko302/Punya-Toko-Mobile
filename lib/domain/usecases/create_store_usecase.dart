import 'package:punyatoko/data/models/post/create_store_model.dart';
import 'package:punyatoko/data/repositories/store_repository.dart';

class CreateStoreUseCase {
  final StoreRepositoryImp storeRepositoryImp;

  CreateStoreUseCase({required this.storeRepositoryImp});

  Future<int> createStore(
      {required String token, required CreateStoreModel model}) async {
    return await storeRepositoryImp.createStore(token: token, model: model);
  }
}
