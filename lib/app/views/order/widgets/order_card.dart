import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/constant/collection.dart';
import 'package:sulai/app/models/order_model.dart';
import 'package:sulai/app/routes/route.dart';
import 'package:sulai/app/view_model/location.dart';
import 'package:sulai/app/widgets/loading.dart';

import '../../../view_model/order_provider.dart';
import '../../../view_model/user_provider.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({Key? key, required this.orderModel}) : super(key: key);
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context, listen: false);
    final order = Provider.of<OrderProvider>(context, listen: false);
    final location = Provider.of<MyLocation>(context, listen: false);
    return GestureDetector(
      onTap: () async {
        showDialog(context: context, builder: (_) => const CustomLoading());
        if (orderModel.statusId == "1") {
          await location.getAddress();
        }
        Navigator.pop(context);
        Navigator.pushNamed(
          context,
          Routes.checkout,
          arguments: {
            "order_id": orderModel.id,
            "product_id": orderModel.productId
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.all(10),
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: const Color(0xFFDEDBD4),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: user.getUser.imageUrl,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            FutureBuilder<QuerySnapshot>(
                              future: MyCollection.status
                                  .where("id", isEqualTo: orderModel.statusId)
                                  .get(),
                              builder: (_, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const SizedBox();
                                }
                                return Container(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    top: 3,
                                    bottom: 3,
                                  ),
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: (snapshot.data!.docs.first["id"] ==
                                            "1")
                                        ? const Color.fromARGB(255, 255, 166, 0)
                                        : (snapshot.data!.docs.first["id"] ==
                                                "2")
                                            ? const Color.fromARGB(
                                                255, 255, 230, 0)
                                            : (snapshot.data!.docs
                                                        .first["id"] ==
                                                    "3")
                                                ? const Color.fromARGB(
                                                    255, 69, 192, 73)
                                                : const Color.fromARGB(
                                                    255, 218, 69, 58),
                                  ),
                                  child: Text(
                                    snapshot.data!.docs.first["status"],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            ),
                            Text(
                              "#${orderModel.orderId}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        FutureBuilder<QuerySnapshot>(
                            future: MyCollection.product
                                .where("id", isEqualTo: orderModel.productId)
                                .get(),
                            builder: (_, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox();
                              }
                              return Text(
                                (snapshot.data!.docs.first.data()
                                    as Map<String, dynamic>)["name"],
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                ),
                              );
                            }),
                        Text(orderModel.address),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => Dialog(
                    child: ListTile(
                      onTap: () async {
                        await order.deleteById(orderModel.id);
                        Navigator.pop(ctx);
                      },
                      title: const Text("Hapus"),
                    ),
                  ),
                );
              },
              child: const Icon(
                Icons.more_horiz_rounded,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
