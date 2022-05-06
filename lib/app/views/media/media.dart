import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constant/collection.dart';
import '../../widgets/main_style.dart';

class MediaPage extends StatelessWidget {
  const MediaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MainStyle(
      widget: [
        Image.asset(
          "assets/images/milk.png",
          fit: BoxFit.cover,
          width: double.infinity,
          height: size.height * 0.3,
        ),
        Container(
          height: 15,
          width: size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 5),
                spreadRadius: 1,
                blurRadius: 2,
                color: Color.fromARGB(255, 189, 189, 189),
              )
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                bottom: -70,
                child: CircleAvatar(
                  backgroundColor: const Color(0xFFDEDBD4),
                  radius: 70,
                  child: ClipOval(
                    child: FutureBuilder<QuerySnapshot>(
                      future: MyCollection.user
                          .where("role_id", isEqualTo: "2")
                          .get(),
                      builder: (_, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox();
                        }
                        return CachedNetworkImage(
                          imageUrl: snapshot.data!.docs.first["image_url"],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 100,
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
            top: 10,
            bottom: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 3,
                  offset: Offset(1, 3),
                  spreadRadius: 2,
                  color: Colors.grey)
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                "KUNJUNG SOSIAL MEDIA KAMI",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Divider(
                height: 2,
                thickness: 3,
              ),
              SizedBox(
                width: size.height * 0.15,
                height: size.height * 0.15,
                child: Image.asset("assets/images/insta.png"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "@SULAIMANIA",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.ios_share_rounded)
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
