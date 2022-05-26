import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/view_model/order_provider.dart';
import 'package:sulai/app/view_model/user_provider.dart';
import 'package:sulai/app/views/order/widgets/order_card.dart';
import 'package:sulai/app/views/order/widgets/order_filter.dart';
import 'package:sulai/app/widgets/app_bar.dart';
import 'package:sulai/app/widgets/main_style.dart';

import '../../constant/color.dart';

class OrderData extends StatelessWidget {
  const OrderData({Key? key}) : super(key: key);

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
                    OrderFilter(
                      label: "SEMUA",
                      color: Colors.grey,
                      statusId: "0",
                    ),
                    OrderFilter(
                      label: "MENUNGGU",
                      color: Color.fromARGB(255, 255, 166, 0),
                      statusId: "1",
                    ),
                    OrderFilter(
                      label: "PROSES",
                      color: Color.fromARGB(255, 255, 230, 0),
                      statusId: "2",
                    ),
                    OrderFilter(
                      label: "SUKSES",
                      color: Color.fromARGB(255, 69, 192, 73),
                      statusId: "3",
                    ),
                    OrderFilter(
                      label: "BATAL",
                      color: Color.fromARGB(255, 218, 69, 58),
                      statusId: "4",
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: order.getAll(user.getUser.id, statusId: "0"),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox();
                  }
                  return Consumer<OrderProvider>(
                    builder: (_, val, __) => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: val.getData.length,
                      itemBuilder: (_, index) {
                        val.getData.where((element) =>
                            element.userId.contains(user.getUser.id));
                        val.getData.sort((a, b) => int.parse(b.orderId).compareTo(int.parse(a.orderId)));
                        return OrderCard(
                          orderModel: val.getData[index],
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
