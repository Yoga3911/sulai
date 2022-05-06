import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/models/order_model.dart';
import 'package:sulai/app/models/product_model.dart';
import 'package:sulai/app/view_model/location.dart';
import 'package:sulai/app/view_model/order_provider.dart';
import 'package:sulai/app/widgets/app_bar.dart';
import 'package:sulai/app/widgets/currency.dart';
import 'package:sulai/app/widgets/loading.dart';
import 'package:sulai/app/widgets/main_style.dart';
import 'package:intl/intl.dart';

import '../../routes/route.dart';
import '../../view_model/product_provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final size = MediaQuery.of(context).size;
    final order = Provider.of<OrderProvider>(context, listen: false);
    final product = Provider.of<ProductProvider>(context, listen: false);
    final location = Provider.of<MyLocation>(context, listen: false);
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
          child: FutureBuilder<OrderModel>(
              future: order.getById(orderId: args["order_id"]),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final orderData = snapshot.data!;
                return FutureBuilder<ProductModel>(
                    future: product.getById(categoryId: args["category_id"]),
                    builder: (_, snapshot2) {
                      if (snapshot2.connectionState ==
                          ConnectionState.waiting) {
                        return const SizedBox();
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: snapshot2.data!.imageUrl,
                              width: size.width,
                              height: size.height * 0.2,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 10),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, right: 15, left: 15),
                              color: (orderData.statusId == "1")
                                  ? const Color.fromARGB(255, 255, 166, 0)
                                  : (orderData.statusId == "2")
                                      ? const Color.fromARGB(255, 255, 230, 0)
                                      : (orderData.statusId == "3")
                                          ? const Color.fromARGB(
                                              255, 69, 192, 73)
                                          : const Color.fromARGB(
                                              255, 218, 69, 58),
                              child: (orderData.statusId == "1")
                                  ? const Text(
                                      "MENUNGGU",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  : (orderData.statusId == "2")
                                      ? const Text(
                                          "PROSES",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      : (orderData.statusId == "3")
                                          ? const Text(
                                              "SUKSES",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )
                                          : const Text(
                                              "BATAL",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 20, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                (orderData.statusId == "1")
                                    ? const Text(
                                        "PESANANMU SUDAH SESUAI !!",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )
                                    : (orderData.statusId == "2")
                                        ? const Text(
                                            "PESANAN DALAM PROSES !!",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          )
                                        : (orderData.statusId == "3")
                                            ? const Text(
                                                "PESANAN TELAH DITERIMA !!",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              )
                                            : const Text(
                                                "PESANAN TELAH DIBATALKAN !!",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
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
                                        onPressed: null,
                                        icon: Image.asset(
                                            "assets/icons/ticket.png")),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                        onPressed: null,
                                        icon: Image.asset(
                                            "assets/icons/pin.png")),
                                    (orderData.statusId == "1")
                                        ? Consumer<MyLocation>(
                                            builder: (_, val, __) => Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    val.getLocation,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Kode pos: ${val.getPostCode}",
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      (orderData.statusId ==
                                                              "1")
                                                          ? Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Material(
                                                                color: Colors
                                                                    .transparent,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (_) =>
                                                                              const CustomLoading(),
                                                                    );
                                                                    location
                                                                        .getAddress()
                                                                        .then(
                                                                          (value) {
                                                                            Navigator.pop(context);
                                                                             Navigator.pushNamed(
                                                                              context,
                                                                              Routes.maps);
                                                                          }
                                                                        );
                                                                  },
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  child:
                                                                      const Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: 5,
                                                                        bottom:
                                                                            5,
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                    child: Text(
                                                                      "Ubah Alamat",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : const SizedBox()
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  orderData.address,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Kode pos: ${orderData.postalCode}",
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    (orderData.statusId == "1")
                                                        ? Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Material(
                                                              color: Colors
                                                                  .transparent,
                                                              child: InkWell(
                                                                onTap: () {},
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child:
                                                                    const Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              5,
                                                                          bottom:
                                                                              5,
                                                                          left:
                                                                              10,
                                                                          right:
                                                                              10),
                                                                  child: Text(
                                                                    "Ubah Alamat",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : const SizedBox()
                                                  ],
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
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon:
                                          Image.asset("assets/icons/time.png"),
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Waktu Pengiriman",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            DateFormat("dd/MM/yyyy").format(
                                              orderData.orderDate,
                                            ),
                                            style: const TextStyle(
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
                                      icon: Image.asset(
                                          "assets/icons/credit.png"),
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Metode Pembayaran",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          (orderData.paymentId == "1")
                                              ? const Text(
                                                  "GoPay",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                )
                                              : (orderData.paymentId == "2")
                                                  ? const Text(
                                                      "Dana",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey),
                                                    )
                                                  : (orderData.paymentId == "3")
                                                      ? const Text(
                                                          "Ovo",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey),
                                                        )
                                                      : const Text(
                                                          "COD",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey),
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
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                              (orderData.sizeId == "1")
                                                  ? const Text(
                                                      "Susu Kedelai kemasan plastik",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    )
                                                  : const Text(
                                                      "Susu Kedelai kemasan botol",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    )
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                              Text(
                                                snapshot2.data!.name,
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                              Text(
                                                "${orderData.quantity} pcs",
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "TOTAL :",
                                    style: TextStyle(
                                      color: Color(0xFF41E507),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Rp " +
                                        currency(snapshot2.data!.price *
                                            orderData.quantity),
                                    style: const TextStyle(
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
                          (orderData.statusId == "1")
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (_) => AlertDialog(
                                                  title: const Text("Alert"),
                                                  content: const Text(
                                                      "Apakah anda yakin ingin membatalkan pesanan ini?"),
                                                  actions: [
                                                    ElevatedButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: const Text(
                                                            "Tidak")),
                                                    ElevatedButton(
                                                        onPressed: () => order
                                                            .updateStatus(
                                                              orderId: args[
                                                                  "order_id"],
                                                              statusId: "4",
                                                            )
                                                            .then(
                                                              (value) => Navigator
                                                                  .pushNamedAndRemoveUntil(
                                                                context,
                                                                Routes.home,
                                                                (route) =>
                                                                    false,
                                                              ),
                                                            ),
                                                        child:
                                                            const Text("Ya")),
                                                  ],
                                                ));
                                      },
                                      child: const Text(
                                        "BATAL",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    Consumer<MyLocation>(
                                      builder: (_, val, __) => ElevatedButton(
                                        onPressed: () {
                                          order
                                              .updateStatus(
                                                orderId: args["order_id"],
                                                statusId: "2",
                                                address: val.getLocation,
                                                postalCode: val.getPostCode,
                                              )
                                              .then(
                                                (value) => Navigator
                                                    .pushNamedAndRemoveUntil(
                                                  context,
                                                  Routes.home,
                                                  (route) => false,
                                                ),
                                              );
                                        },
                                        child: const Text(
                                          "KONFIRMASI",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: const Color(0xFF41E507),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : (orderData.statusId == "2")
                                  ? Center(
                                      child: Column(
                                        children: [
                                          const Text(
                                              "Konfirmasi penerimaan barang"),
                                          ElevatedButton(
                                            onPressed: () {
                                              showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (_) => AlertDialog(
                                                  title: const Text("Alert"),
                                                  content: const Text(
                                                      "Apakah barang sudah anda terima?"),
                                                  actions: [
                                                    ElevatedButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child: const Text(
                                                        "Tidak",
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          order
                                                              .updateStatus(
                                                                  orderId: args[
                                                                      "order_id"],
                                                                  statusId: "3")
                                                              .then(
                                                                (value) => Navigator
                                                                    .pushNamedAndRemoveUntil(
                                                                  context,
                                                                  Routes.home,
                                                                  (route) =>
                                                                      false,
                                                                ),
                                                              );
                                                        },
                                                        child:
                                                            const Text("Ya")),
                                                  ],
                                                ),
                                              );
                                            },
                                            child: const Text(
                                              "KONFIRMASI",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              primary: const Color(0xFF41E507),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                          const SizedBox(height: 10)
                        ],
                      );
                    });
              }),
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
