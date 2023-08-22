import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constants/assets_color.dart';
import '../../../util/helper.dart';
import '../texts/poppins_text.dart';

class ItemHomeIncome extends StatelessWidget {
  const ItemHomeIncome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: AssetsColor.youngGreen.withOpacity(10 / 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: PoppinsText(
                  text: "Rubber Will",
                  maxLines: 1,
                  fontSize: 16.sp,
                  color: AssetsColor.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              PoppinsText(
                text: "Rp ${Helper.rupiah(500000)}",
                fontSize: 16.sp,
                color: AssetsColor.green,
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AssetsColor.youngGreen,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: PoppinsText(
                      text: "Minuman",
                      fontSize: 12.sp,
                      color: AssetsColor.white,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AssetsColor.youngGreen,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: PoppinsText(
                      text: "21-08-2023",
                      fontSize: 12.sp,
                      color: AssetsColor.white,
                    ),
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                    color: AssetsColor.grey,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
