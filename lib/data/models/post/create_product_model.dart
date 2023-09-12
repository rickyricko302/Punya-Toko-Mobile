class CreateProductModel {
  String name, created, categoryId, price, stock;

  CreateProductModel(
      {required this.name,
      required this.price,
      required this.categoryId,
      required this.stock,
      required this.created});

  Map<String, String> toJson() {
    return {
      "name": name,
      "category_id": categoryId,
      "price": price,
      "stock": stock,
      "created": created
    };
  }
}
