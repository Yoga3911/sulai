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
  late TextEditingController _controller1;
  late TextEditingController _controller2;
  late TextEditingController _controller3;
  late TextEditingController _controller4;

  @override
  void initState() {
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
    _controller4 = TextEditingController();
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
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    if (_controller1.text.isEmpty) {
      _controller1.text = args["name"];
    }
    if (_controller2.text.isEmpty) {
      _controller2.text = args["price"].toString();
    }
    if (_controller3.text.isEmpty) {
      _controller3.text = args["discount"].toString();
    }
    if (_controller4.text.isEmpty) {
      _controller4.text = args["disc_prod"].toString();
    }
    // if (radioVal == -1) {
    //   radioVal = int.parse(args["size"]);
    // }
    final product = Provider.of<ProductProvider>(context);
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
        title: (args["size"] == "1")? Text(_controller1.text + " (Plastik)") : Text(_controller1.text + " (Botol)"),
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
                        : const Color.fromARGB(255, 255, 218, 105),
        onPressed: (_controller1.text.isEmpty)
            ? null
            : (_controller2.text.isEmpty)
                ? null
                : (_controller3.text.isEmpty)
                    ? null
                    : (_controller4.text.isEmpty)
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
                                .editProduct(
                              name: _controller1.text,
                              price: int.parse(_controller2.text),
                              productId: args["id"],
                              discount: int.parse(_controller3.text),
                              discProd: int.parse(_controller4.text),
                              image: _imgUrl ?? args["image"],
                              // size: radioVal.toString(),
                            )
                                .then(
                              (value) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Update product successfully"),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                FocusManager.instance.primaryFocus?.unfocus();
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
