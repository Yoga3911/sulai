import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/models/product_model.dart';
import 'package:sulai/app/view_model/user_provider.dart';
import 'package:sulai/app/widgets/loading.dart';

import '../../constant/collection.dart';
import '../../view_model/product_provider.dart';
import '../../widgets/main_style.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
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
    final size = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context, listen: false).getUser;
    final product = Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 255, 218, 105),
      ),
      body: MainStyle(
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
                      child: Image.asset(
                        "assets/images/admin_pp.png",
                        fit: BoxFit.cover,
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
          (user.roleId == "2")
              ? FutureBuilder<List<ProductModel>>(
                  future: product.getAll(),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox();
                    }
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) {
                        final ProductModel productModel = snapshot.data![index];
                        return ListTile(
                          leading: CircleAvatar(
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: productModel.imageUrl,
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(productModel.name),
                          trailing: IconButton(
                            onPressed: () => showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Alert"),
                                content: const Text(
                                    "Apakah anda yakin ingin menghapus produk ini?"),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Tidak"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text("Ya"),
                                  ),
                                ],
                              ),
                            ),
                            icon: const Icon(Icons.delete_rounded),
                            color: Colors.red,
                          ),
                          onTap: () {
                            _controller.text = productModel.name;
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Edit Product"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        await fromGallery()
                                            .then((value) => setState(() {}));
                                      },
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          SizedBox(
                                            height: size.height * 0.2,
                                            width: size.width,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: (_img != null)
                                                  ? Image.file(
                                                      _img!,
                                                      fit: BoxFit.cover,
                                                      height: double.infinity,
                                                      width: double.infinity,
                                                    )
                                                  : CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl:
                                                          productModel.imageUrl,
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                    ),
                                            ),
                                          ),
                                          (_img != null)
                                              ? Text("dsa")
                                              : SizedBox(),
                                          Container(
                                            height: size.height * 0.2,
                                            width: size.width,
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    76, 0, 0, 0),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                          const Icon(
                                            Icons.image_rounded,
                                            color: Colors.white,
                                            size: 50,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: _controller,
                                      autofocus: true,
                                    )
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _img = null;
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Batal"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        builder: (_) => const CustomLoading(),
                                      );
                                      final DateTime date = DateTime.now();
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
                                      product
                                          .editProduct(
                                        name: _controller.text,
                                        productId: productModel.id,
                                        image: _imgUrl ?? productModel.imageUrl,
                                      )
                                          .then(
                                        (value) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                    child: const Text("Simpan"),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                )
              : Container(
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
                      const Text(
                        "SULAI",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "sulaijember@gmail.com",
                        style: TextStyle(
                            color: Color(0xFF717171),
                            fontStyle: FontStyle.italic),
                      ),
                      const Text(
                        "+6285233605081",
                        style: TextStyle(color: Color(0xFF717171)),
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
                      Column(
                        children: [
                          profileItem(
                            icon: Image.asset("assets/icons/pin.png"),
                            label: "Jl Mastrip No. 5 , Sumbersari, Jember",
                            sublabel: "KODE POS : 57681",
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            height: 2,
                            thickness: 1,
                          ),
                          const SizedBox(height: 10),
                          profileItem(
                            icon: Image.asset("assets/icons/shop2.png"),
                            label: "Berdiri Sejak 2011",
                            sublabel:
                                "Rumah Produksi Sulai sudah berdiri sejak 24 Novermber 2011",
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            height: 2,
                            thickness: 1,
                          ),
                          const SizedBox(height: 10),
                          profileItem(
                            icon: Image.asset("assets/icons/arrow.png"),
                            // label: "About",
                            isRating: true,
                            sublabel: "Google Play Rating",
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            height: 2,
                            thickness: 1,
                          ),
                          const SizedBox(height: 10),
                          profileItem(
                              icon: Image.asset("assets/icons/profile.png"),
                              label: "Ibu Naupal",
                              sublabel: "Pemilik Rumah Produksi Sulai"),
                          const SizedBox(height: 10),
                          const Divider(
                            height: 2,
                            thickness: 1,
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    ],
                  ),
                ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget profileItem({
    Widget? icon,
    String? label,
    Widget? route,
    String? sublabel,
    bool? isRating = false,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          IconButton(
            icon: icon!,
            onPressed: null,
            color: const Color(0xFF717171),
          ),
          const SizedBox(width: 15),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                (isRating!)
                    ? RatingBar.builder(
                        initialRating: 4.5,
                        itemSize: 20,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      )
                    : Text(
                        label!,
                      ),
                Text(
                  sublabel!,
                  style: const TextStyle(
                    color: Color(0xFF717171),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
