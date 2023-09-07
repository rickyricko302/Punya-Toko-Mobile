import 'package:flutter/material.dart';
import 'package:punyatoko/presentation/bloc/createProduct/create_product_bloc.dart';

import '../presentation/widgets/bottomsheets/bottomsheet_create_category.dart';
import '../presentation/widgets/bottomsheets/bottomsheet_select_category.dart';

class BottomSheetHelper {
  static void showSelectCategory(
      {required BuildContext context,
      required CreateProductBloc bloc,
      required TextEditingController textController}) {
    showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (contexts) {
          return BottomSheetSelectCategory(
            bloc: bloc,
            textController: textController,
          );
        });
  }

  static void showCreateCategory(
      {required BuildContext context,
      required CreateProductBloc bloc,
      required TextEditingController textController}) {
    showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (contexts) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: BottomSheetCreateCategory(
              bloc: bloc,
              textController: textController,
            ),
          );
        });
  }
}
