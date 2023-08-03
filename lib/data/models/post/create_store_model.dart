class CreateStoreModel {
  String name, address;
  int income, expense;

  CreateStoreModel(
      {required this.name,
      required this.address,
      required this.income,
      required this.expense});

  Map<String, String> toJson() {
    return {
      'name': name,
      'address': address,
      'income': income.toString(),
      'expense': expense.toString()
    };
  }
}
