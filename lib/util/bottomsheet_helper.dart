import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:punyatoko/presentation/bloc/createProduct/create_product_bloc.dart';
import 'package:punyatoko/presentation/widgets/bottomsheets/bottomsheet_update_category.dart';

import '../domain/entities/category_entity.dart';
import '../presentation/widgets/bottomsheets/bottomsheet_create_category.dart';
import '../presentation/widgets/bottomsheets/bottomsheet_select_category.dart';

class BottomSheetHelper {
  static void showSelectCategory(
      {required BuildContext context,
      required CreateProductBloc bloc,
      required TextEditingController textController,
      required List<CategoryEntity> entities}) {
    log(entities.length.toString());
    showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (contexts) {
          return BottomSheetSelectCategory(
            bloc: bloc,
            textController: textController,
            entities: entities,
          );
        });
  }

  /// Memunculkan bottomsheet tambah kategori
  ///
  /// Parameter :
  /// - context => BuildContext,
  /// - onClick => (String namaCategori);
  static void showCreateCategory(
      {required BuildContext context,
      required Function(String name) onClick,
      required TextEditingController textController}) {
    showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (contexts) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(contexts).viewInsets.bottom),
            child: BottomSheetCreateCategory(
              onClick: onClick,
              textController: textController,
            ),
          );
        });
  }

  /// Memunculkan bottomsheet ubah kategori
  ///
  /// Parameter :
  /// - context => BuildContext,
  /// - onClick => (String namaCategori);
  /// - category => String kategori sebelum diubah
  static void showUpdateCategory(
      {required BuildContext context,
      required Function(String name) onClick,
      required String category,
      required TextEditingController textController}) {
    showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (contexts) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(contexts).viewInsets.bottom),
            child: BottomSheetUpdateCategory(
              onClick: onClick,
              textController: textController,
            ),
          );
        });
  }
}
