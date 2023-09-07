import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:punyatoko/presentation/widgets/texts/poppins_text.dart';

import '../../../data/constants/assets_color.dart';
import '../../../data/constants/routes_page.dart';

class ProductListingPage extends StatelessWidget {
  const ProductListingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AssetsColor.youngGreen.withOpacity(20 / 100),
        title: PoppinsText(text: "Kelola Produk", fontSize: 20.sp),
      ),
      body: const ProductEmpty(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutesPage.createProduct);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ProductEmpty extends StatelessWidget {
  const ProductEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/ic_noproduct.svg',
            height: 170.h,
          ),
          const SizedBox(
            height: 20,
          ),
          PoppinsText(
            text:
                "Anda belum mempunyai produk, silahkan tekan tombol hijau dibawah untuk menambahkan.",
            fontSize: 15.sp,
            color: AssetsColor.grey,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
