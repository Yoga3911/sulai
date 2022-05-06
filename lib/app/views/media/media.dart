import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/models/ulasan_model.dart';
import 'package:sulai/app/models/user_model.dart';
import 'package:sulai/app/routes/route.dart';
import 'package:sulai/app/view_model/user_provider.dart';

import '../../constant/collection.dart';
import '../../view_model/ulasan_provider.dart';
import '../../widgets/main_style.dart';

class MediaPage extends StatefulWidget {
  const MediaPage({Key? key}) : super(key: key);

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context, listen: false);
    final ulasan = Provider.of<UlasanProvider>(context, listen: false);
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
                "KUNJUNGI SOSIAL MEDIA KAMI",
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
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Container(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 10,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 3,
                  offset: Offset(1, 3),
                  color: Colors.grey,
                )
              ],
            ),
            child: FutureBuilder<QuerySnapshot>(
              future: MyCollection.ulasan
                  .where("user_id", isEqualTo: user.getUser.id)
                  .get(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text((snapshot.data!.docs.first.data()
                          as Map<String, dynamic>)["ulasan"]),
                    ),
                    IconButton(
                      onPressed: () {
                        _controller.text = (snapshot.data!.docs.first.data()
                            as Map<String, dynamic>)["ulasan"];
                        Navigator.pushNamed(context, Routes.ulasan, arguments: {
                          "ulasan": _controller.text,
                          "ulasan_id": (snapshot.data!.docs.first.data()
                              as Map<String, dynamic>)["id"]
                        });
                      },
                      icon: const Icon(Icons.edit_rounded),
                    )
                  ],
                );
              },
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
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
                "ULASAN",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Divider(
                height: 2,
                thickness: 3,
              ),
              FutureBuilder<List<UlasanModel>>(
                future: ulasan.getAll(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox();
                  }
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  }
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) {
                      return FutureBuilder<UserModel>(
                        future:
                            user.getById(userId: snapshot.data![index].userId),
                        builder: (_, snapshot2) {
                          if (snapshot2.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox();
                          }
                          return ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(snapshot2.data!.name),
                                Text(
                                  DateFormat("dd-MM-yyyy").format(
                                    snapshot.data![index].date,
                                  ),
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                )
                              ],
                            ),
                            subtitle: Text(
                              snapshot.data![index].ulasan,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: CircleAvatar(
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: snapshot2.data!.imageUrl,
                                  height: double.infinity,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
