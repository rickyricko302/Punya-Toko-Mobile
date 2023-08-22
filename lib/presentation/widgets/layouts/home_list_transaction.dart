import 'package:flutter/material.dart';
import 'package:punyatoko/presentation/widgets/items/home_expense.dart';
import 'package:punyatoko/presentation/widgets/items/home_income.dart';

import '../../../data/constants/assets_color.dart';
import '../separators/separator_dash.dart';

class HomeListTransaction extends StatelessWidget {
  const HomeListTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: RefreshIndicator(
      onRefresh: () async {},
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 30),
        itemCount: 20,
        separatorBuilder: (context, index) {
          return MySeparator(
            color: AssetsColor.grey,
          );
        },
        itemBuilder: (context, index) {
          return (index % 2 == 0)
              ? const ItemHomeExpense()
              : const ItemHomeIncome();
        },
      ),
    ));
  }
}
