import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/view_model/order_provider.dart';
import 'package:sulai/app/widgets/app_bar.dart';
import 'package:sulai/app/widgets/currency.dart';
import 'package:sulai/app/widgets/main_style.dart';

import '../../constant/color.dart';

class RekapPage extends StatefulWidget {
  const RekapPage({Key? key}) : super(key: key);

  @override
  State<RekapPage> createState() => _RekapPageState();
}

class _RekapPageState extends State<RekapPage> {
  int selectedYear = 2022;
  // void pickYear(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       final Size size = MediaQuery.of(context).size;
  //       return AlertDialog(
  //         title: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             const Text('Pilih tahun'),
  //             Container(
  //               padding: const EdgeInsets.only(
  //                   left: 15, right: 15, top: 5, bottom: 5),
  //               decoration: BoxDecoration(
  //                   color: const Color.fromARGB(255, 255, 218, 105),
  //                   borderRadius: BorderRadius.circular(10)),
  //               child: Text(selectedYear.toString()),
  //             )
  //           ],
  //         ),
  //         contentPadding: const EdgeInsets.all(10),
  //         content: SizedBox(
  //           height: size.height / 3,
  //           width: size.width,
  //           child: GridView.count(
  //             crossAxisCount: 3,
  //             children: [
  //               ...List.generate(
  //                 100,
  //                 (index) => GestureDetector(
  //                   onTap: () {
  //                     selectedYear = 2000 + index;
  //                     for (int i = 0; i < countData.length; i++) {
  //                       countData[i] = 0;
  //                     }
  //                     Navigator.pop(context);

  //                     setState(() {});
  //                   },
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Chip(
  //                       backgroundColor: (2000 + index == selectedYear)
  //                           ? const Color.fromARGB(255, 255, 218, 105)
  //                           : null,
  //                       label: Container(
  //                         padding: const EdgeInsets.all(5),
  //                         child: Text(
  //                           (2000 + index).toString(),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  late List<int> countData = List.generate(2, (index) => 0);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final order = Provider.of<OrderProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        order.orderPerWeek = [];
        order.penjualanPerHari = 0;
        return true;
      },
      child: MainStyle(
        widget: [
          const CustomAppBar(),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              width: size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.task_rounded,
                    color: MyColor.grey,
                    size: 40,
                  ),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "LAPORAN PENJUALAN",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Seluruh Informasi terkait penjualan dan pendapatan terekam dalam laman ini.",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: 20,
            ),
            child: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 3,
                    spreadRadius: 3,
                    color: Color.fromARGB(255, 215, 215, 215),
                    offset: Offset(1, 3),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: null,
                        icon: Image.asset(
                          "assets/icons/chart.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Chart Penjualan",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Grafik Penjualan tiap hari",
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      "Laporan penjualan harian, nilai ditampilkan dalam bentuk grafik penjualan.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 20,
                    ),
                    child: FittedBox(
                      child: ElevatedButton(
                        onPressed: () {
                          order.selectDate(context);
                          // order.selectDate2(context);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7))),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_rounded,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10),
                            Text(DateFormat("EEEE, dd MMM yyyy", "id_ID")
                                .format(order.selectedDate)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder(
                      future: order.getAllOrder(),
                      builder: (_, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        List<int> monthData = order.countPerMonth(
                            selectedDate: order.selectedDate);
                        return Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: GetGraph(
                            monthData: monthData,
                          ),
                        );
                      }),
                  (order.penjualanPerHari == 0)
                      ? const SizedBox()
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  child: Container(
                                    width: size.width * 0.5,
                                    height: size.height * 0.17,
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color(0xFF4D97EA)),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text(
                                            "Total Penjualan",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(DateFormat(
                                                  "EEEE, dd MMMM yyyy", "in_ID")
                                              .format(order.orderPerWeek.first
                                                  .orderDate)),
                                          Text(
                                            order.penjualanPerHari.toString() +
                                                " buah",
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 15,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  child: Container(
                                    width: size.width * 0.27,
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color(0xFF4D97EA)),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text(
                                            "Kenaikan",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Center(
                                              child: IconButton(
                                                  onPressed: null,
                                                  icon: Image.asset(
                                                    "assets/icons/stonk.png",
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                  ))),
                                          (order.penjualanPerHari2 == 0)
                                              ? const Text(
                                                  "100%",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                )
                                              : Text(
                                                  (((order.penjualanPerHari -
                                                                      order
                                                                          .penjualanPerHari2) /
                                                                  order
                                                                      .penjualanPerHari2) *
                                                              100)
                                                          .toStringAsFixed(1) +
                                                      "%",
                                                  style: const TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  child: Container(
                                    height: size.height * 0.17,
                                    width: size.width * 0.5,
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color(0xFF4D97EA)),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text(
                                            "Total Pendapatan",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(DateFormat(
                                                  "EEEE, dd MMMM yyyy", "in_ID")
                                              .format(order.orderPerWeek.first
                                                  .orderDate)),
                                          Text(
                                            "Rp " +
                                                currency(
                                                    order.pendapatanPerHari),
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 15,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  child: Container(
                                    width: size.width * 0.27,
                                    height: size.height * 0.17,
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color(0xFF4D97EA)),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text(
                                            "Kenaikan",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Center(
                                              child: IconButton(
                                                  onPressed: null,
                                                  icon: Image.asset(
                                                    "assets/icons/stonk.png",
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                  ))),
                                          (order.pendapatanPerHari2 == 0)
                                              ? const Text(
                                                  "100%",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                )
                                              : Text(
                                                  (((order.pendapatanPerHari -
                                                                      order
                                                                          .pendapatanPerHari2) /
                                                                  order
                                                                      .pendapatanPerHari2) *
                                                              100)
                                                          .toStringAsFixed(1) +
                                                      "%",
                                                  style: const TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Container(
              width: size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 3,
                      spreadRadius: 3,
                      color: Color.fromARGB(255, 215, 215, 215),
                      offset: Offset(1, 3),
                    )
                  ]),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    child: Text(
                      "Rincian penjualan",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Center(
                    child: Column(
                      children: order.orderPerWeek
                          .map(
                            (e) => ListTile(
                              title: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "#${e.orderId} -",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: (e.sizeId == "1")
                                            ? " Plastik: ${e.quantity} buah"
                                            : " Botol: ${e.quantity} buah",
                                        style:
                                            const TextStyle(color: Colors.red))
                                  ],
                                ),
                              ),
                              subtitle: Text(e.address),
                            ),
                          )
                          .toList(),
                    ),
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

class GetGraph extends StatefulWidget {
  const GetGraph({Key? key, required this.monthData}) : super(key: key);
  final List<int> monthData;

  @override
  State<GetGraph> createState() => _GetGraphState();
}

class _GetGraphState extends State<GetGraph> {
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<OrderProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            (order.getSum == 0)
                ? const SizedBox()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(order.getSum.toString()),
                      Container(
                        height: (order.getSum / order.getSum) * 100 + 20,
                        width: 3,
                        color: Colors.grey,
                      ),
                    ],
                  ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                7,
                (index) {
                  int e = widget.monthData[index];
                  return GestureDetector(
                    onTap: () {
                      if (index == 0) {
                        order.setOrderPerWeek(
                            order.sunData, order.satDataB, order.productData);
                        setState(() {});
                        return;
                      } else if (index == 1) {
                        order.setOrderPerWeek(
                            order.monData, order.sunData, order.productData);
                        setState(() {});
                        return;
                      } else if (index == 2) {
                        order.setOrderPerWeek(
                            order.tueData, order.monData, order.productData);
                        setState(() {});
                        return;
                      } else if (index == 3) {
                        order.setOrderPerWeek(
                            order.wedData, order.tueData, order.productData);
                        setState(() {});
                        return;
                      } else if (index == 4) {
                        order.setOrderPerWeek(
                            order.thuData, order.wedData, order.productData);
                        setState(() {});
                        return;
                      } else if (index == 5) {
                        order.setOrderPerWeek(
                            order.friData, order.thuData, order.productData);
                        setState(() {});
                        return;
                      } else if (index == 6) {
                        order.setOrderPerWeek(
                            order.satData, order.friData, order.productData);
                        setState(() {});
                        return;
                      }
                    },
                    child: Column(
                      children: [
                        (e != 0) ? Text(e.toString()) : const SizedBox(),
                        Container(
                          height: (e != 0) ? (e / order.getSum) * 100 : 0,
                          margin: const EdgeInsets.only(left: 13, right: 13),
                          width: size.width / 7 - 40,
                          decoration: BoxDecoration(
                              color: (widget.monthData.indexOf(e) ==
                                      DateTime.now().day)
                                  ? Colors.yellow
                                  : (e != 0)
                                      ? const Color(0xFF41E507)
                                      : Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        Text(
                          (index == 0)
                              ? "Min"
                              : (index == 1)
                                  ? "Sen"
                                  : (index == 2)
                                      ? "Sel"
                                      : (index == 3)
                                          ? "Rab"
                                          : (index == 4)
                                              ? "Kam"
                                              : (index == 5)
                                                  ? "Jum"
                                                  : "Sab",
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
