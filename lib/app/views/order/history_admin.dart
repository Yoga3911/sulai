import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/view_model/order_provider.dart';
import 'package:sulai/app/view_model/user_provider.dart';
import 'package:sulai/app/views/order/widgets/order_card_admin.dart';
import 'package:sulai/app/views/order/widgets/order_filter_admin.dart';
import 'package:sulai/app/widgets/app_bar.dart';
import 'package:sulai/app/widgets/main_style.dart';

import '../../constant/color.dart';

class OrderDataAdmin extends StatelessWidget {
  const OrderDataAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<OrderProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);
    return MainStyle(
      widget: [
        const CustomAppBar(),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.shopping_bag_outlined,
                      color: MyColor.grey,
                      size: 40,
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "KERANJANG",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Seluruh Informasi pemesanan anda terekam dalam laman ini.",
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
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    OrderFilterAdmin(
                      label: "SEMUA",
                      color: Colors.grey,
                      processId: "0",
                    ),
                    OrderFilterAdmin(
                      label: "VERIFIKASI",
                      color: Color.fromARGB(255, 255, 166, 0),
                      processId: "1",
                    ),
                    OrderFilterAdmin(
                      label: "PEMBUATAN",
                      color: Color.fromARGB(255, 255, 230, 0),
                      processId: "2",
                    ),
                    OrderFilterAdmin(
                      label: "DIKIRIM",
                      color: Color.fromARGB(255, 69, 192, 73),
                      processId: "3",
                    ),
                    OrderFilterAdmin(
                      label: "DITERIMA",
                      color: Color.fromARGB(255, 218, 69, 58),
                      processId: "4",
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: order.getAllProc(user.getUser.id, processId: "0"),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox();
                  }
                  return Consumer<OrderProvider>(
                    builder: (_, val, __) => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: val.getDataProc.length,
                      itemBuilder: (_, index) {
                        val.getDataProc.where((element) =>
                            element.userId.contains(user.getUser.id));
                        val.getDataProc.sort((a, b) => int.parse(b.orderId)
                            .compareTo(int.parse(a.orderId)));
                        return OrderCardAdmin(
                          orderModel: val.getDataProc[index],
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        )
      ],
    );
  }
}
