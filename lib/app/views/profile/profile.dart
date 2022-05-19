import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sulai/app/view_model/user_provider.dart';
import 'package:sulai/app/widgets/loading.dart';
import 'package:sulai/app/widgets/main_style.dart';

import '../../constant/collection.dart';
import '../../services/email.dart';
import '../../services/facebook.dart';
import '../../services/google.dart';
import '../../view_model/auth_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEdit = false;
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    final user = Provider.of<UserProvider>(context, listen: false);
    _controller = TextEditingController();
    _controller.text = user.getUser.name;
    super.initState();
  }

  File? _img;
  String? _imgUrl;
  String? _imgName;

  Future<void> fromGallery() async {
    XFile? result = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (result != null) {
      _img = File(result.path);
      _imgName = result.name;
    }
    setState(() {});
  }

  Future<void> getImgUrl({String? imgName}) async {
    _imgUrl =
        await MyCollection.storage.ref("products/$imgName").getDownloadURL();
  }

  Future<void> uploadImg({String? imgName, File? imgFile}) async {
    try {
      await MyCollection.storage.ref("products/$imgName").putFile(imgFile!);
      log("Image uploaded");
    } on FirebaseException catch (e) {
      log(e.message!);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false);

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
                    child: (isEdit)
                        ? GestureDetector(
                            onTap: () async {
                              await fromGallery()
                                  .then((value) => setState(() {}));
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                (_img != null)
                                    ? Image.file(
                                        _img!,
                                        fit: BoxFit.cover,
                                        height: double.infinity,
                                        width: double.infinity,
                                      )
                                    : CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: user.getUser.imageUrl,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                Container(
                                  color: const Color.fromARGB(66, 0, 0, 0),
                                ),
                                const Icon(
                                  Icons.image_rounded,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ],
                            ),
                          )
                        : CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: user.getUser.imageUrl,
                            width: double.infinity,
                            height: double.infinity,
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
              (isEdit)
                  ? TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                    )
                  : Text(
                      user.getUser.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              (isEdit) ? const SizedBox(height: 10) : const SizedBox(),
              Text(
                user.getUser.email,
                style: const TextStyle(color: Color(0xFF717171)),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: (isEdit)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Material(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              child: InkWell(
                                onTap: () => setState(() {
                                  isEdit = !isEdit;
                                  _controller.text = user.getUser.name;
                                }),
                                borderRadius: BorderRadius.circular(100),
                                child: const Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(
                                    Icons.clear_rounded,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Material(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              child: InkWell(
                                onTap: () async {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (_) => const CustomLoading());
                                  final date = DateTime.now();
                                  isEdit = !isEdit;
                                  (_img != null)
                                      ? await uploadImg(
                                          imgFile: _img,
                                          imgName:
                                              "$_imgName${date.millisecond}",
                                        )
                                      : null;
                                  (_img != null)
                                      ? await getImgUrl(
                                          imgName:
                                              "$_imgName${date.millisecond}",
                                        )
                                      : null;
                                  await user
                                      .changeProfile(
                                        name: _controller.text,
                                        userId: user.getUser.id,
                                        img: _imgUrl ?? user.getUser.imageUrl,
                                      )
                                      .then((value) => Navigator.pop(context));
                                },
                                borderRadius: BorderRadius.circular(100),
                                child: const Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(
                                    Icons.save_rounded,
                                    size: 20,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Material(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          child: InkWell(
                            onTap: () => setState(() {
                              isEdit = !isEdit;
                              _focusNode.requestFocus();
                            }),
                            borderRadius: BorderRadius.circular(100),
                            child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.edit_rounded,
                                size: 20,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 10),
              const Divider(
                height: 2,
                thickness: 3,
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Akun",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF717171),
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    profileItem(
                        icon: Icons.shield_rounded, label: "Setting Privasi"),
                    const SizedBox(height: 10),
                    const Divider(
                      height: 2,
                      thickness: 1,
                    ),
                    const SizedBox(height: 10),
                    profileItem(icon: Icons.info_rounded, label: "About"),
                    const SizedBox(height: 10),
                    const Divider(
                      height: 2,
                      thickness: 1,
                    ),
                    const SizedBox(height: 10),
                    profileItem(
                      icon: Icons.logout_rounded,
                      label: "Logout",
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      height: 2,
                      thickness: 1,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget profileItem({IconData? icon, String? label, String? action}) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        if (label == "Logout") {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => AlertDialog(
              title: const Text(
                "Apakah anda yakin ingin keluar?",
                style: TextStyle(fontSize: 16),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text("Batal"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) => const CustomLoading(),
                    );
                    final pref = await SharedPreferences.getInstance();
                    final String social = pref.getString("social")!;
                    switch (social) {
                      case "email":
                        auth.logout(
                          context,
                          EmailService(),
                        );
                        break;
                      case "facebook":
                        auth.logout(
                          context,
                          FacebookService(),
                        );
                        break;
                      case "google":
                        auth.logout(
                          context,
                          GoogleService(),
                        );
                        break;
                    }
                  },
                  child: const Text("Ya"),
                ),
              ],
            ),
          );
        }
      },
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF717171),
          ),
          const SizedBox(width: 15),
          Text(
            label!,
            style: const TextStyle(
              color: Color(0xFF717171),
            ),
          )
        ],
      ),
    );
  }
}
