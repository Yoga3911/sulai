import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/view_model/notification.dart';
import 'package:sulai/app/view_model/user_provider.dart';
import 'package:sulai/app/widgets/app_bar.dart';
import 'package:sulai/app/widgets/main_style.dart';
import 'package:sulai/app/views/notification/widgets/notif_card.dart';

import '../../constant/color.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context, listen: false);
    final notif = Provider.of<NotificationProvider>(context, listen: false);
    return MainStyle(
      widget: [
        const CustomAppBar(),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        const Icon(
                          Icons.notifications_outlined,
                          color: MyColor.grey,
                          size: 40,
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            height: size.height * 0.015,
                            width: size.height * 0.015,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "NOTIFIKASI",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Seluruh Informasi pemberitahuan anda terekam dalam laman ini.",
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
              FutureBuilder(
                future: notif.getAll(userId: user.getUser.id),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox();
                  }
                  return Consumer<NotificationProvider>(
                    builder: (_, val, __) => ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: val.getData.length,
                      itemBuilder: (_, index) {
                        if (index > 0) {
                          if (val.getData[index].createAt !=
                              val.getData[index - 1].createAt) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    DateFormat('EEEE, d MMM yyyy').format(
                                      val.getData[index].createAt,
                                    ),
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  NotifCard(notif: val.getData[index]),
                                ],
                              ),
                            );
                          }
                          return NotifCard(notif: val.getData[index]);
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('EEEE, d MMM yyyy').format(
                                  val.getData[index].createAt,
                                ),
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              NotifCard(notif: val.getData[index])
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
