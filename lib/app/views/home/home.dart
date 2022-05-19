import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/models/product_model.dart';
import 'package:sulai/app/view_model/product_provider.dart';
import 'package:sulai/app/view_model/user_provider.dart';
import 'package:sulai/app/views/home/widgets/carousel.dart';
import 'package:sulai/app/views/home/widgets/custom_box.dart';
import 'package:sulai/app/widgets/app_bar.dart';
import 'package:sulai/app/widgets/main_style.dart';

import '../../constant/color.dart';
import '../../routes/route.dart';
import '../../view_model/order_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false);
    final product = Provider.of<ProductProvider>(context, listen: false);
    final order = Provider.of<OrderProvider>(context, listen: false);
    final getProduct = product.getAll();
    final size = MediaQuery.of(context).size;
    return MainStyle(
      widget: [
        const CustomAppBar(),
        Column(
          children: [
            FutureBuilder<List<ProductModel>>(
              future: getProduct,
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                order.productData = snapshot.data!;
                return CarouselSlider(
                  items: snapshot.data!
                      .map((e) => CustomCarousel(productModel: e))
                      .toList(),
                  options: CarouselOptions(
                    height: size.height * 0.4,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.7,
                    aspectRatio: 1,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, Routes.shop),
                  child: const CustomBox(
                    icon: "assets/icons/shop.png",
                    label: "SHOP",
                  ),
                ),
                GestureDetector(
                    onTap: () => Navigator.pushNamed(context, Routes.homeChat),
                    child: const CustomBox(
                        icon: "assets/icons/chat.png", label: "CHAT")),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, Routes.media),
                  child: const CustomBox(
                    icon: "assets/icons/insta.png",
                    label: "MEDIA",
                  ),
                ),
                if (user.getUser.roleId == "2")
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, Routes.rekap),
                    child: const CustomBox(
                      icon: "assets/icons/report.png",
                      label: "REKAP",
                    ),
                  )
              ],
            ),
            Container(
                margin: const EdgeInsets.only(top: 30),
                width: size.width,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: ClipOval(
                        child: CachedNetworkImage(
                          height: double.infinity,
                          width: double.infinity,
                          imageUrl: user.getUser.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      backgroundColor: const Color(0xFFDEDBD4),
                      radius: 30,
                    ),
                    const SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.getUser.name,
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          "Bergabung pada ${DateFormat("d MMM yyyy").format(user.getUser.createAt)}",
                          style: const TextStyle(
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                            color: MyColor.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                              color: MyColor.grey,
                              borderRadius: BorderRadius.circular(5)),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              child: const Center(
                                child: Text(
                                  "EDIT PROFILE",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onTap: () =>
                                  Navigator.pushNamed(context, Routes.profile),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ],
                )),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "SELAMAT DATANG DI APLIKASI SULAI",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Center(
                child: Text(
                  "Untuk pemesanan harap dilakukan pada waktu yang ditentukan apabila melampaui waktu yang ditentukan, maka pesanan akan dikirim esok harinya",
                  style: TextStyle(
                    color: Color.fromARGB(255, 113, 113, 113),
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.3,
                right: size.width * 0.3,
              ),
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, Routes.order),
                child: const Text("PESAN SEKARANG"),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(size.width, size.height * 0.06),
                  primary: const Color(0xFF41E507),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ],
    );
  }
}
