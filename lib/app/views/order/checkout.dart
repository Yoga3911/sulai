import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/view_model/location.dart';
import 'package:sulai/app/widgets/app_bar.dart';
import 'package:sulai/app/widgets/main_style.dart';

import '../../routes/route.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MainStyle(
      widget: [
        const CustomAppBar(),
        Container(
          width: size.width * 0.9,
          margin: const EdgeInsets.only(left: 30, right: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.asset(
                  "assets/images/sulai2.png",
                  width: size.width,
                  height: size.height * 0.2,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "PESANANMU SUDAH SESUAI !!",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Text(
                      "Yeay, pesananmu sudah sesuai dengan ketentuan yang berlaku",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Image.asset("assets/icons/ticket.png")),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Pesan Antar",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "Cukup tunggu di rumah dan pesananmu akan diantar",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Divider(
                        height: 2,
                        thickness: 2,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Image.asset("assets/icons/pin.png")),
                        Consumer<MyLocation>(
                          builder: (_, val, __) => Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  val.getLocation,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Kode pos: ${val.getPostCode}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 3,
                                          bottom: 3),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {},
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: const Text(
                                            "Ubah Alamat",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Divider(
                        height: 2,
                        thickness: 2,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset("assets/icons/time.png"),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Waktu Pengiriman",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "20/04/2022 10.00 WIB",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Divider(
                        height: 2,
                        thickness: 2,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset("assets/icons/credit.png"),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Metode Pembayaran",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "GoPay",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Divider(
                        height: 2,
                        thickness: 2,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "PESANAN :",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF41E507),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 5,
                                    width: 5,
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    "Susu Kedelai kemasan botol",
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                              const Icon(
                                Icons.info_rounded,
                                color: Colors.grey,
                                size: 17,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 5,
                                    width: 5,
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    "Rasa Stroberi",
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                              const Icon(
                                Icons.info_rounded,
                                color: Colors.grey,
                                size: 17,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 5,
                                    width: 5,
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    "3 basket ( 36 botol )",
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                              const Icon(
                                Icons.info_rounded,
                                color: Colors.grey,
                                size: 17,
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: const Color.fromARGB(255, 240, 240, 240),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "TOTAL :",
                        style: TextStyle(
                          color: Color(0xFF41E507),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Rp 124.000,00",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.home,
                    (route) => false,
                  ),
                  child: const Text(
                    "KONFIRMASI",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF41E507),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
