import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/models/notifaction_model.dart';
import 'package:sulai/app/view_model/user_provider.dart';

import '../models/user_model.dart';

class NotifCard extends StatelessWidget {
  const NotifCard({Key? key, required this.notif}) : super(key: key);

  final NotificationModel notif;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context);
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
                  future: user.getUserById(id: notif.userId),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox();
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
          const Icon(
            Icons.more_horiz_rounded,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
