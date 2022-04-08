import 'package:carousel_slider/carousel_slider.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sulai/app/view_model/user_provider.dart';
import 'package:sulai/app/views/home/widgets/carousel.dart';
import 'package:sulai/app/views/home/widgets/custom_box.dart';
import 'package:sulai/app/widgets/glow.dart';

import '../../constant/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController controller = PageController();
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              padding: EdgeInsets.only(top: size.height * 0.1),
              decoration: const BoxDecoration(gradient: MyColor.linerGradient),
              child: ScrollConfiguration(
                behavior: NoGlow(),
                child: ListView(
                  children: [
                    CarouselSlider(
                      items: const [
                        CustomCarousel(),
                        CustomCarousel(),
                        CustomCarousel(),
                      ],
                      options: CarouselOptions(
                        onPageChanged: (index, _) {
                          setState(() {
                            _index = index;
                          });
                        },
                        height: size.height * 0.4,
                        enableInfiniteScroll: false,
                        enlargeCenterPage: true,
                        viewportFraction: 0.7,
                        aspectRatio: 2,
                      ),
                    ),
                    Center(
                      child: AnimatedSmoothIndicator(
                        activeIndex: _index,
                        count: 3,
                        effect: const WormEffect(
                          activeDotColor: Colors.white,
                          dotHeight: 10,
                          dotWidth: 10,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        CustomBox(icon: "assets/icons/shop.png", label: "SHOP"),
                        CustomBox(icon: "assets/icons/chat.png", label: "CHAT"),
                        CustomBox(
                            icon: "assets/icons/insta.png", label: "MEDIA"),
                        CustomBox(
                            icon: "assets/icons/order.png", label: "BOOK"),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.05),
                      height: size.height * 0.15,
                      width: size.width,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(user.imageUrl),
                            radius: 30,
                          ),
                          const SizedBox(width: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(
                                "Bergabung pada ${formatDate(user.createAt, [
                                      dd,
                                      '-',
                                      M,
                                      '-',
                                      yyyy
                                    ])}",
                                style: const TextStyle(
                                  fontSize: 14,
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
                                            fontSize: 12, color: Colors.white),
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        "SELAMAT DATANG DI APLIKASI SULAI",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Center(
                        child: Text(
                          "Untuk pemesanan harap dilakukan pada waktu yang ditentukan apabila melampaui waktu yang ditentukan, maka pesanan akan dikirim esok harinya",
                          style: TextStyle(
                            color: Color.fromARGB(255, 113, 113, 113),
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Info lebih lanjut",
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                          ),
                          const SizedBox(height: 20),
                          Image.asset("assets/icons/substract.png")
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.3,
                        right: size.width * 0.3,
                      ),
                      child: ElevatedButton(
                        onPressed: () {},
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
                    const SizedBox(height: 40,),
                  ],
                ),
              ),
            ),
            Align(
              alignment: const Alignment(-0.9, -0.95),
              child: Container(
                height: size.height * 0.05,
                width: size.height * 0.05,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Material(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {},
                    child: const Icon(
                      Icons.menu,
                      color: MyColor.grey,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.9, -0.95),
              child: Container(
                height: size.height * 0.05,
                width: size.height * 0.12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      children: [
                        Material(
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: () {},
                            child: const Icon(
                              Icons.notifications_outlined,
                              color: MyColor.grey,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 3,
                          top: 3,
                          child: Container(
                            height: size.height * 0.01,
                            width: size.height * 0.01,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: size.height * 0.03,
                      width: 2,
                      color: Colors.grey,
                    ),
                    Material(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {},
                        child: const Icon(
                          Icons.shopping_bag_outlined,
                          color: MyColor.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
