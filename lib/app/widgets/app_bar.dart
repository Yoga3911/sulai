import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/constant/collection.dart';
import 'package:sulai/app/view_model/notification.dart';

import '../constant/color.dart';
import '../routes/route.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final notif = Provider.of<NotificationProvider>(context);
    return SizedBox(
      height: size.height * 0.1,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20),
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
              Container(
                height: size.height * 0.05,
                width: size.height * 0.125,
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: MyCollection.notification.snapshots(),
                      builder: (_, snapshot) {
                        if (!snapshot.hasData) {
                          return const Icon(
                            Icons.notifications_outlined,
                            color: MyColor.grey,
                          );
                        }
                        if (notif.getCount == 0) {
                          notif.setCount = snapshot.data!.docs.length;
                        }
                        if (notif.getCount < snapshot.data!.docs.length) {
                          notif.setActive = true;
                        }
                        return Stack(
                          children: [
                            Material(
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(100),
                                onTap: () {
                                  notif.setCount = snapshot.data!.docs.length;
                                  notif.setActiveRef = false;
                                  Navigator.pushNamed(
                                    context,
                                    Routes.notification,
                                  );
                                },
                                child: const Icon(
                                  Icons.notifications_outlined,
                                  color: MyColor.grey,
                                ),
                              ),
                            ),
                            notif.getActive
                                ? Positioned(
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
                                : const SizedBox()
                          ],
                        );
                      },
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
                        onTap: () =>
                            Navigator.pushNamed(context, Routes.orderData),
                        child: const Icon(
                          Icons.shopping_bag_outlined,
                          color: MyColor.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
