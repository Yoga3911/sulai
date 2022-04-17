import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/constant/collection.dart';
import 'package:sulai/app/models/order_model.dart';

import '../../../models/user_model.dart';
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
    return Container(
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
                FutureBuilder<UserModel>(
                  future: user.getUserById(id: orderModel.userId),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircleAvatar(
                        radius: 25,
                        backgroundColor: Color(0xFFDEDBD4),
                      );
                    }
                    return CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(snapshot.data!.imageUrl),
                      backgroundColor: const Color(0xFFDEDBD4),
                    );
                  },
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
                                      ? const Color.fromARGB(255, 255, 230, 0)
                                      : (snapshot.data!.docs.first["id"] == "2")
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
                      Text(
                        orderModel.title,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(orderModel.subtitle),
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
                      await order.deleteById(orderModel.orderId);
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
    );
  }
}
