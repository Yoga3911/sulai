import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sulai/app/models/product_model.dart';

import '../../../routes/route.dart';
import '../../../widgets/currency.dart';

class CustomCarousel extends StatelessWidget {
  const CustomCarousel({Key? key, required this.productModel})
      : super(key: key);
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
            offset: Offset(4, 4),
            spreadRadius: 1,
            color: Color.fromARGB(255, 209, 209, 209),
          )
        ],
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: productModel.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              height: 125,
              width: size.width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 5),
                  const Text(
                    "PROMO MINGGUAN!!!",
                    style: TextStyle(
                      color: Color(0xFF41E507),
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "10 - 30 Juni 2022",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/icons/bag.png",
                              fit: BoxFit.cover),
                          const SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "1 Basket Sulai",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                (productModel.sizeId == "1")? productModel.discProd.toString() + " Plastik" : productModel.discProd.toString() + " Botol",
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        "Diskon " + productModel.discount.toString() + "%",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 20,
                        width: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF41E507),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => Navigator.pushNamed(
                                context, Routes.product,
                                arguments: productModel),
                            child: const Center(
                              child: Text(
                                "MORE",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "Rp ${currency((productModel.price * productModel.discProd).round())}",
                            style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.black),
                            // te
                          ),
                          Text(
                            "Rp ${currency((productModel.price * productModel.discProd * (100 - productModel.discount) / 100).round())}",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.red),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
