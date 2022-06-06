import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/constant/collection.dart';
import 'package:sulai/app/models/notifaction_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../view_model/notification.dart';

class NotifCard extends StatelessWidget {
  const NotifCard({Key? key, required this.notif}) : super(key: key);

  final NotificationModel notif;

  Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw "Could not launce $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final notification =
        Provider.of<NotificationProvider>(context, listen: false);
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
                FutureBuilder<DocumentSnapshot>(
                  future: MyCollection.user.doc(notif.adminId).get(),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircleAvatar(
                        radius: 25,
                        backgroundColor: Color(0xFFDEDBD4),
                      );
                    }
                    return CircleAvatar(
                      radius: 25,
                      backgroundColor: const Color(0xFFDEDBD4),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          height: double.infinity,
                          width: double.infinity,
                          imageUrl: (snapshot.data!.data()
                              as Map<String, dynamic>)["image_url"],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Text(
                          notif.title,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Text(
                          notif.subtitle,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        onTap: () async {
                          await notification.deleteById(notif.id);
                          Navigator.pop(ctx);
                        },
                        title: const Text("Hapus"),
                      ),
                    ],
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
