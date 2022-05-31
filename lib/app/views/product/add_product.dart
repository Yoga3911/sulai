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
  late TextEditingController _controller3;
  late TextEditingController _controller4;
  late TextEditingController _controller5;
  late TextEditingController _controller6;
  late TextEditingController _controller7;

  int radioVal = -1;

  @override
  void initState() {
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
    _controller4 = TextEditingController();
    _controller5 = TextEditingController();
    _controller6 = TextEditingController();
    _controller7 = TextEditingController();
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

  File? _img2;
  String? _imgUrl2;
  String? _imgName2;

  Future<void> fromGallery2() async {
    XFile? result = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (result != null) {
      _img2 = File(result.path);
      _imgName2 = result.name;
    }
    setState(() {});
  }

  Future<void> getImgUrl2({String? imgName}) async {
    _imgUrl2 =
        await MyCollection.storage.ref("products/$imgName").getDownloadURL();
  }

  Future<void> uploadImg2({String? imgName, File? imgFile}) async {
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
    _controller3.dispose();
    _controller4.dispose();
    _controller5.dispose();
    _controller6.dispose();
    _controller7.dispose();
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
                : (_controller3.text.isEmpty)
                    ? Colors.grey
                    : (_controller4.text.isEmpty)
                        ? Colors.grey
                        : (_controller5.text.isEmpty)
                            ? Colors.grey
                            : (_controller6.text.isEmpty)
                                ? Colors.grey
                                : (_controller7.text.isEmpty)
                                    ? Colors.grey
                                    : (_img == null)
                                        ? Colors.grey
                                        : (_img2 == null)
                                            ? Colors.grey
                                            : const Color.fromARGB(
                                                255, 255, 218, 105),
        onPressed: (_controller1.text.isEmpty)
            ? null
            : (_controller2.text.isEmpty)
                ? null
                : (_controller3.text.isEmpty)
                    ? null
                    : (_controller4.text.isEmpty)
                        ? null
                        : (_controller5.text.isEmpty)
                            ? null
                            : (_controller6.text.isEmpty)
                                ? null
                                : (_controller7.text.isEmpty)
                                    ? null
                                    : (_img == null)
                                        ? null
                                        : (_img2 == null)
                                            ? null
                                            : () async {
                                                showDialog(
                                                  context: context,
                                                  builder: (_) =>
                                                      const CustomLoading(),
                                                );
                                                final DateTime date =
                                                    DateTime.now();
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
                                                (_img2 != null)
                                                    ? await uploadImg2(
                                                        imgFile: _img2,
                                                        imgName:
                                                            "$_imgName2${date.millisecond}",
                                                      )
                                                    : null;
                                                (_img2 != null)
                                                    ? await getImgUrl2(
                                                        imgName:
                                                            "$_imgName2${date.millisecond}",
                                                      )
                                                    : null;
                                                product.addProduct(
                                                  name: _controller1.text,
                                                  price: int.parse(
                                                      _controller5.text),
                                                  image: _imgUrl2,
                                                  discount: int.parse(
                                                      _controller6.text),
                                                  discProd: int.parse(
                                                      _controller7.text),
                                                  userId: user.getUser.id,
                                                  size: "2",
                                                );
                                                product
                                                    .addProduct(
                                                  name: _controller1.text,
                                                  price: int.parse(
                                                      _controller2.text),
                                                  image: _imgUrl,
                                                  discount: int.parse(
                                                      _controller3.text),
                                                  discProd: int.parse(
                                                      _controller4.text),
                                                  userId: user.getUser.id,
                                                  size: "1",
                                                )
                                                    .then(
                                                  (value) {
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            "Add product successfully"),
                                                        backgroundColor:
                                                            Colors.green,
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
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "> Ukuran 220 ml",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                  child: Text("Diskon Produk %")),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                child: TextField(
                  controller: _controller3,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.discount_rounded),
                      helperText: "Beri nilai 0 jika tidak ada diskon",
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
                  child: Text("Jumlah pembelian produk diskon")),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                child: TextField(
                  controller: _controller4,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.production_quantity_limits_rounded),
                      helperText: "Beri nilai 0 jika tidak ada diskon",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      isDense: true,
                      contentPadding: const EdgeInsets.all(13)),
                ),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "> Ukuran 600 ml",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Text("Harga Produk")),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                child: TextField(
                  controller: _controller5,
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
                  child: Text("Diskon Produk %")),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                child: TextField(
                  controller: _controller6,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.discount_rounded),
                      helperText: "Beri nilai 0 jika tidak ada diskon",
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
                  child: Text("Jumlah pembelian produk diskon")),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                child: TextField(
                  controller: _controller7,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.production_quantity_limits_rounded),
                      helperText: "Beri nilai 0 jika tidak ada diskon",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      isDense: true,
                      contentPadding: const EdgeInsets.all(13)),
                ),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
            child: GestureDetector(
              onTap: () async {
                await fromGallery2().then((value) => setState(() {}));
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.3,
                    width: size.width,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: (_img2 != null)
                            ? Image.file(
                                _img2!,
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
