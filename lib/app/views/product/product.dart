import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/models/product_model.dart';
import 'package:sulai/app/view_model/dropdown.dart';
import 'package:sulai/app/widgets/app_bar.dart';
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
                              "20 - 28 Maret 2022",
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
                        info("Susu Kedelai kemasan ", "botol"),
                        info("Rasa Original", ""),
                        info("1 basket ", "( 12 botol )"),
                        const SizedBox(height: 20),
                        Container(
                          width: size.width,
                          color: const Color(0xFFF3F3F3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Text(
                                "DISKON 20%",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Rp 25.000",
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Rp 20.000,00",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              SizedBox(width: 10)
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            if (productModel.name == "Sulai Original") {
                              dropdown.setRasa = 1;
                            } else if (productModel.name == "Sulai Stroberi") {
                              dropdown.setRasa = 2;
                            } else if (productModel.name == "Sulai Melon") {
                              dropdown.setRasa = 3;
                            }
                            if (productModel.name == "Sulai Original") {
                              dropdown.setImg = "assets/images/sulai2.png";
                            } else if (productModel.name == "Sulai Stroberi") {
                              dropdown.setImg = "assets/images/sulai2.jpg";
                            } else if (productModel.name == "Sulai Melon") {
                              dropdown.setImg = "assets/images/sulai3.jpg";
                            }
                            Navigator.pushNamed(context, Routes.order);
                          },
                          child: const Text("PESAN"),
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF41E507),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            fixedSize: const Size(140, 50),
                          ),
                        ),
                        const SizedBox(width: 20),
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
