import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:punyatoko/data/constants/assets_color.dart';
import 'package:punyatoko/data/constants/routes_page.dart';
import 'package:punyatoko/presentation/widgets/separators/separator_dash.dart';
import 'package:punyatoko/presentation/widgets/texts/poppins_text.dart';
import 'package:punyatoko/util/extension.dart';
import 'package:punyatoko/util/helper.dart';

import '../widgets/layouts/home_list_transaction.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: () async {},
        child: NestedScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            headerSliverBuilder: (context, tr) {
              return [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: PoppinsText(
                                text: "Nama Pemilik",
                                fontSize: 15.sp,
                                color: AssetsColor.black,
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/shop.png'))),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: PoppinsText(
                          text: "Toko Bonangan Raya Cuy",
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: PoppinsText(
                            text: "Jl Bonangan Raya",
                            fontSize: 15.sp,
                            color: AssetsColor.grey),
                      ),
                    ],
                  ),
                )
              ];
            },
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PoppinsText(
                              text: DateTime.now().toDay(), fontSize: 18.sp),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.tune, color: AssetsColor.black))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              PoppinsText(
                                text: "Rp ${Helper.rupiah(2000000)}",
                                fontSize: 16.sp,
                                color: AssetsColor.black,
                                fontWeight: FontWeight.bold,
                              ),
                              PoppinsText(
                                text: 'Sisa saldo',
                                fontSize: 12.sp,
                                color: AssetsColor.grey,
                              )
                            ],
                          )),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              PoppinsText(
                                text: "Rp ${Helper.rupiah(2000000)}",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AssetsColor.black,
                              ),
                              PoppinsText(
                                text: 'Pemasukan',
                                fontSize: 12.sp,
                                color: AssetsColor.grey,
                              )
                            ],
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: MySeparator(
                      color: AssetsColor.grey,
                    )),
                //no data
                // const HomeNoTransaction()
                // has data
                const HomeListTransaction()
              ],
            )),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
          // color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AssetsColor.youngGreen,
          selectedItemColor: AssetsColor.white,
          unselectedItemColor: AssetsColor.white,
          onTap: (index) {
            Navigator.pushNamed(context,
                index == 0 ? RoutesPage.listProduct : RoutesPage.listCategory);
          },
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/ic_box.svg',
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  width: 24,
                  height: 24,
                ),
                label: "Kelola Produk"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.sell_outlined), label: "Kelola Kategori")
          ]),
    );
  }
}
