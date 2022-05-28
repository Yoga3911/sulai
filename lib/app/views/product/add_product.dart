import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/view_model/product_provider.dart';
import 'package:sulai/app/widgets/main_style.dart';

import '../../constant/collection.dart';
import '../../view_model/user_provider.dart';
import '../../widgets/loading.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  late TextEditingController _controller1;
  late TextEditingController _controller2;
  int radioVal = -1;

  @override
  void initState() {
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
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
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 20,
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
          ),
        ),
        title: const Text("Add Product"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: (_controller1.text.isEmpty)
            ? Colors.grey
            : (_controller2.text.isEmpty)
                ? Colors.grey
                : (radioVal == -1)
                    ? Colors.grey
                    : (_img == null)
                        ? Colors.grey
                        : const Color.fromARGB(255, 255, 218, 105),
        onPressed: (_controller1.text.isEmpty)
            ? null
            : (_controller2.text.isEmpty)
                ? null
                : (radioVal == -1)
                    ? null
                    : (_img == null)
                        ? null
                        : () async {
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
                                .addProduct(
                              name: _controller1.text,
                              price: int.parse(_controller2.text),
                              image: _imgUrl,
                              userId: user.getUser.id,
                              size: radioVal.toString(),
                            )
                                .then(
                              (value) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                FocusManager.instance.primaryFocus?.unfocus();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Add product successfully"),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                setState(() {});
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
          const Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Text("Nama Produk")),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
            child: TextField(
              controller: _controller1,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: const Icon(Icons.fastfood_rounded),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                  isDense: true,
                  contentPadding: const EdgeInsets.all(13)),
            ),
          ),
          const Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Text("Harga Produk")),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
            child: TextField(
              controller: _controller2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.price_change_rounded),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                  isDense: true,
                  contentPadding: const EdgeInsets.all(13)),
            ),
          ),
          const Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Text("Ukuran Produk")),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio<int>(
                      value: 1,
                      activeColor: const Color.fromARGB(255, 255, 218, 105),
                      groupValue: radioVal,
                      onChanged: (val) {
                        radioVal = val!;
                        setState(() {});
                      },
                    ),
                    const Text("220 ml")
                  ],
                ),
                Row(
                  children: [
                    Radio<int>(
                      value: 2,
                      activeColor: const Color.fromARGB(255, 255, 218, 105),
                      groupValue: radioVal,
                      onChanged: (val) {
                        radioVal = val!;
                        setState(() {});
                      },
                    ),
                    const Text("600 ml")
                  ],
                ),
              ],
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
                            : Container(
                                color: const Color.fromARGB(83, 104, 104, 104),
                              )),
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
