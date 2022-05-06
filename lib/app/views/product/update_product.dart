import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/view_model/product_provider.dart';
import 'package:sulai/app/widgets/main_style.dart';

import '../../constant/collection.dart';
import '../../widgets/loading.dart';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct({Key? key}) : super(key: key);

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
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
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    _controller.text = args["name"];
    final product = Provider.of<ProductProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
          ),
        ),
        title: const Text("Edit Product"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 255, 218, 105),
        onPressed: () async {
          showDialog(
            context: context,
            builder: (_) => const CustomLoading(),
          );
          final DateTime date = DateTime.now();
          (_img != null)
              ? await uploadImg(
                  imgFile: _img,
                  imgName: "$_imgName${date.millisecond}",
                )
              : null;
          (_img != null)
              ? await getImgUrl(
                  imgName: "$_imgName${date.millisecond}",
                )
              : null;
          product
              .editProduct(
            name: _controller.text,
            productId: args["id"],
            image: _imgUrl ?? args["image"],
          )
              .then(
            (value) {
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Update product successfully"),
                  backgroundColor: Colors.green,
                ),
              );
            },
          );
        },
        child: const Icon(
          Icons.save_rounded,
          color: Colors.white,
        ),
      ),
      body: MainStyle(
        widget: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: TextField(
              controller: _controller,
              autofocus: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: GestureDetector(
              onTap: () async {
                await fromGallery().then((value) => setState(() {}));
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.3,
                    width: size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: (_img != null)
                          ? Image.file(
                              _img!,
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                            )
                          : CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: args["image"],
                              width: double.infinity,
                              height: double.infinity,
                            ),
                    ),
                  ),
                  Container(
                    height: size.height * 0.3,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(76, 0, 0, 0),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  const Icon(
                    Icons.image_rounded,
                    color: Colors.white,
                    size: 50,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
