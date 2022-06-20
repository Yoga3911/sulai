import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/models/product_model.dart';
import 'package:sulai/app/view_model/dropdown.dart';
import 'package:sulai/app/view_model/user_provider.dart';
import 'package:sulai/app/widgets/app_bar.dart';
import 'package:sulai/app/widgets/currency.dart';
import 'package:sulai/app/widgets/glow.dart';

import '../../constant/color.dart';
import '../../routes/route.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductModel productModel =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    final dropdown = Provider.of<DropDownNotifier>(context);
    final size = MediaQuery.of(context).size;
    return Container(
      color: const Color(0xFFDEDBD4),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: MyColor.linerGradient,
            ),
            child: ScrollConfiguration(
              behavior: NoGlow(),
              child: ListView(
                children: [
                  const CustomAppBar(),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(1, 3),
                            blurRadius: 3,
                            spreadRadius: 3,
                            color: Color.fromARGB(255, 193, 193, 193))
                      ],
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          child: Hero(
                            tag: productModel.id,
                            child: SizedBox(
                              width: size.width,
                              height: size.height * 0.25,
                              child: CachedNetworkImage(
                                imageUrl: productModel.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Text(
                            "PROMO MINGGUAN !!!",
                            style: TextStyle(
                              color: Color(0xFF41E507),
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Text(
                              "10 - 30 Juni 2022",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "PAKET PROMO: ",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        info("Susu Kedelai kemasan ",
                            (productModel.sizeId == "1") ? "Plastik" : "Botol"),
                        info(productModel.name, ""),
                        info(
                            "1 basket ",
                            (productModel.sizeId == "1")
                                ? "( ${productModel.discProd} plastik )"
                                : "( ${productModel.discProd} botol )"),
                        const SizedBox(height: 20),
                        Container(
                          width: size.width,
                          color: const Color(0xFFF3F3F3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "DISKON " +
                                    productModel.discount.toString() +
                                    "%",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Rp " +
                                    currency(productModel.price *
                                        productModel.discProd),
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Rp " +
                                    currency((productModel.price *
                                            productModel.discProd *
                                            (100 - productModel.discount) /
                                            100)
                                        .round()),
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const SizedBox(width: 10)
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        (context.read<UserProvider>().getUser.roleId == "1")
                            ? ElevatedButton(
                                onPressed: () {
                                  dropdown.setRasa = productModel.id;
                                  dropdown.setImg = productModel.imageUrl;
                                  Navigator.pushNamed(context, Routes.order,
                                      arguments: {"product": productModel});
                                },
                                child: const Text("PESAN"),
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xFF41E507),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  fixedSize: const Size(120, 40),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding info(String first, String second) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 5,
            width: 5,
            decoration: const BoxDecoration(
                color: Colors.black, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: first),
                TextSpan(
                  text: second,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
