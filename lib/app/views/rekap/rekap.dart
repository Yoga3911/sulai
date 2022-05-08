import 'package:flutter/material.dart';
import 'package:sulai/app/widgets/app_bar.dart';
import 'package:sulai/app/widgets/main_style.dart';

import '../../constant/color.dart';

class RekapPage extends StatelessWidget {
  const RekapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MainStyle(
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
        ),
      ],
    );
  }
}
