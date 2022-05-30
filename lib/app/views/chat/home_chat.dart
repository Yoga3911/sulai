import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/widgets/app_bar.dart';
import 'package:sulai/app/widgets/main_style.dart';

import '../../constant/collection.dart';
import '../../constant/color.dart';
import '../../models/user_model.dart';
import '../../view_model/user_provider.dart';
import 'room_chat.dart';

class HomeChat extends StatefulWidget {
  const HomeChat({Key? key}) : super(key: key);

  @override
  State<HomeChat> createState() => _HomeChatState();
}

class _HomeChatState extends State<HomeChat> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context, listen: false).getUser;
    final CollectionReference getUser =
        FirebaseFirestore.instance.collection("user");
    return Scaffold(
      floatingActionButton: (user.roleId == "2")
          ? null
          : FutureBuilder<QuerySnapshot>(
              future: MyCollection.user.doc(user.id).collection("chats").get(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }
                return FutureBuilder<QuerySnapshot>(
                    future: MyCollection.user
                        .where("role_id", isEqualTo: "2")
                        .get(),
                    builder: (_, snapshot2) {
                      if (snapshot2.connectionState ==
                          ConnectionState.waiting) {
                        return const SizedBox();
                      }
                      final userModel = UserModel.fromJson(
                        snapshot2.data!.docs.first.data()
                            as Map<String, dynamic>,
                      );
                      return FloatingActionButton(
                        heroTag: "home",
                        onPressed: () {
                          for (var i in snapshot.data!.docs) {
                            if ((i.data() as Map<String, dynamic>)["user_id"] ==
                                userModel.id) {
                              MyCollection.user
                                  .doc(userModel.id)
                                  .collection("chats")
                                  .doc(i.id)
                                  .update({
                                "unread": 0,
                                "onRoom": true,
                              });

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => RoomChat(
                                    userModel: userModel,
                                    docId: i.id,
                                    onRoom: true,
                                  ),
                                ),
                              );
                              return;
                            }
                          }
                          final doc = MyCollection.chat.doc();
                          doc.set({
                            "members": [user.id, userModel.id]
                          });
                          MyCollection.user
                              .doc(user.id)
                              .collection("chats")
                              .doc(doc.id)
                              .set({
                            "user_id": userModel.id,
                            "unread": 0,
                            "onRoom": false,
                            "isTyping": false,
                            "date": DateTime.now(),
                          });
                          MyCollection.user
                              .doc(userModel.id)
                              .collection("chats")
                              .doc(doc.id)
                              .set({
                            "user_id": user.id,
                            "unread": 0,
                            "isTyping": false,
                            "onRoom": true,
                            "date": DateTime.now(),
                          });
                          // FirebaseMessaging.instance.subscribeToTopic(doc.id);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RoomChat(
                                userModel: userModel,
                                docId: doc.id,
                                onRoom: true,
                              ),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.chat_rounded,
                          color: Colors.white,
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 255, 219, 134),
                      );
                    });
              }),
      body: MainStyle(
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
                  const Icon(
                    Icons.chat_rounded,
                    color: MyColor.grey,
                    size: 40,
                  ),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "SULAI MESSENGER",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Pada laman ini kamu bisa chatting dengan penyedia layanan sulai.",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: getUser
                    .doc(user.id)
                    .collection("chats")
                    .orderBy("date", descending: true)
                    .snapshots(),
                builder: (_, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      final userData = (snapshot.data!.docs[index].data()
                          as Map<String, dynamic>);
                      return StreamBuilder<DocumentSnapshot>(
                        stream: getUser.doc(userData["user_id"]).snapshots(),
                        builder: (_, snapshot2) {
                          if (!snapshot2.hasData) {
                            return const SizedBox();
                          }
                          final UserModel userModel = UserModel.fromJson(
                              snapshot2.data!.data() as Map<String, dynamic>);
                          return StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("chat")
                                .doc(snapshot.data!.docs[index].id)
                                .collection("message")
                                .orderBy("date", descending: false)
                                .snapshots(),
                            builder: (_, snapshot2) {
                              if (!snapshot2.hasData) {
                                return const SizedBox();
                              }
                              if (snapshot2.data!.docs.isEmpty) {
                                return const SizedBox();
                              }
                              return Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  top: 10,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl: userModel.imageUrl,
                                          fit: BoxFit.cover,
                                          height: double.infinity,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ),
                                    trailing: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              (userData["unread"] == 0)? const SizedBox() : Container(
                                                decoration: const BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 255, 219, 134),
                                                    shape: BoxShape.circle),
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Text(
                                                  userData["unread"].toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              ((DateTime.now()
                                                                  .month ==
                                                              (userData["date"]
                                                                      as Timestamp)
                                                                  .toDate()
                                                                  .month) && DateTime.now()
                                                                  .day ==
                                                          (userData["date"]
                                                                      as Timestamp)
                                                                  .toDate().day)
                                                  ? Text(
                                                      DateFormat.Hm().format(
                                                        (userData["date"]
                                                                as Timestamp)
                                                            .toDate(),
                                                      ),
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                    )
                                                  : ((DateTime.now()
                                                                  .month ==
                                                              (userData["date"]
                                                                      as Timestamp)
                                                                  .toDate()
                                                                  .month) && DateTime.now()
                                                                  .day -
                                                          (userData["date"]
                                                                      as Timestamp)
                                                                  .toDate().day == 1)
                                                      ? const Text(
                                                          "Kemarin",
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        )
                                                      : Text(
                                                          DateFormat(
                                                                  "dd/MM/yyyy")
                                                              .format(
                                                            (userData["date"]
                                                                    as Timestamp)
                                                                .toDate(),
                                                          ),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12),
                                                        ),
                                            ],
                                          ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          userModel.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 3),
                                        ((userData["isTyping"]))
                                            ? const Text(
                                                "Sedang mengetik ...",
                                                style: TextStyle(fontSize: 12),
                                              )
                                            : (user.email !=
                                                    (snapshot2.data!.docs.last
                                                            .data()
                                                        as Map<String,
                                                            dynamic>)["user"])
                                                ? Flexible(
                                                    child: Text(
                                                      (snapshot2.data!.docs.last
                                                                  .data()
                                                              as Map<String,
                                                                  dynamic>)[
                                                          "message"],
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  )
                                                : Row(
                                                    children: [
                                                      ((snapshot2.data!.docs.last
                                                                      .data()
                                                                  as Map<String,
                                                                      dynamic>)[
                                                              "isRead"])
                                                          ? const Icon(
                                                              Icons.check,
                                                              color:
                                                                  Colors.blue,
                                                              size: 20,
                                                            )
                                                          : const Icon(
                                                              Icons.check,
                                                              size: 20,
                                                            ),
                                                      const SizedBox(width: 5),
                                                      Flexible(
                                                        child: Text(
                                                          (snapshot2.data!.docs.last
                                                                      .data()
                                                                  as Map<String,
                                                                      dynamic>)[
                                                              "message"],
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                      ],
                                    ),
                                    onTap: () {
                                      // FirebaseMessaging.instance
                                      //     .subscribeToTopic(
                                      //         snapshot.data!.docs[index].id);
                                      FirebaseFirestore.instance
                                          .collection("user")
                                          .doc(userModel.id)
                                          .collection("chats")
                                          .doc(snapshot.data!.docs[index].id)
                                          .update({
                                        "onRoom": true,
                                      });
                                      FirebaseFirestore.instance
                                          .collection("user")
                                          .doc(user.id)
                                          .collection("chats")
                                          .doc(snapshot.data!.docs[index].id)
                                          .update({
                                        "unread": 0,
                                      });
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => RoomChat(
                                            userModel: userModel,
                                            docId:
                                                snapshot.data!.docs[index].id,
                                            onRoom: (snapshot.data!.docs[index]
                                                        .data()
                                                    as Map<String, dynamic>)[
                                                "onRoom"],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
