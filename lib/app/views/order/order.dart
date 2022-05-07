import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/models/product_model.dart';
import 'package:sulai/app/view_model/dropdown.dart';
import 'package:sulai/app/view_model/location.dart';
import 'package:sulai/app/view_model/order_provider.dart';
import 'package:sulai/app/view_model/product_provider.dart';
import 'package:sulai/app/widgets/app_bar.dart';
import 'package:sulai/app/widgets/loading.dart';
import 'package:sulai/app/widgets/main_style.dart';
import '../../routes/route.dart';
import '../../view_model/user_provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late TextEditingController quantityController;
  bool isEmpty = true;

  @override
  void initState() {
    quantityController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final location = Provider.of<MyLocation>(context, listen: false);
    final order = Provider.of<OrderProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);
    final dropdown = Provider.of<DropDownNotifier>(context, listen: false);
    final product = Provider.of<ProductProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return MainStyle(
      widget: [
        FutureBuilder<List<ProductModel>>(
          future: product.getAll(),
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (dropdown.rasa.isEmpty) {
              dropdown.rasa = snapshot.data!.first.id;
            }
            if (dropdown.image.isEmpty) {
              dropdown.image = snapshot.data!.first.imageUrl;
            }
            return Column(
              children: [
                const CustomAppBar(),
                Consumer<DropDownNotifier>(
                  builder: (_, val, __) => SizedBox(
                    height: size.height * 0.25,
                    width: size.width,
                    child: CachedNetworkImage(
                      imageUrl: val.getImg,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  width: size.width * 0.85,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 4,
                            offset: Offset(2, 1),
                            spreadRadius: 1,
                            color: Color.fromARGB(255, 193, 193, 193))
                      ]),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "ISI PESANANMU !!",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: Consumer<DropDownNotifier>(
                                  builder: (_, val, __) =>
                                      DropdownButton<String>(
                                    style: const TextStyle(color: Colors.grey),
                                    value: val.getRasa,
                                    onChanged: (value) {
                                      val.setRasa = value!;
                                      val.setImg = snapshot
                                          .data![snapshot.data!.indexWhere(
                                              (element) => element.id == value)]
                                          .imageUrl;
                                    },
                                    items: [
                                      for (ProductModel item in snapshot.data!)
                                        DropdownMenuItem(
                                          child: Text(item.name),
                                          value: item.id,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          height: 2,
                          thickness: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: Consumer<DropDownNotifier>(
                                  builder: (_, val, __) => DropdownButton<int>(
                                    style: const TextStyle(color: Colors.grey),
                                    value: val.getKemasan,
                                    onChanged: (value) {
                                      val.setKemasan = value!;
                                    },
                                    items: const [
                                      DropdownMenuItem(
                                        child: Text("220mL"),
                                        value: 1,
                                      ),
                                      DropdownMenuItem(
                                        child: Text("600mL"),
                                        value: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          height: 2,
                          thickness: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 28, right: 40),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: quantityController,
                                onChanged: (_) {
                                  if (quantityController.text.isEmpty) {
                                    isEmpty = true;
                                  } else {
                                    isEmpty = false;
                                  }
                                  setState(() {});
                                },
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(13),
                                  hintText: "Jumlah",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          height: 2,
                          thickness: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: Consumer<DropDownNotifier>(
                                  builder: (_, val, __) => DropdownButton<int>(
                                    style: const TextStyle(color: Colors.grey),
                                    value: val.getPembayaran,
                                    onChanged: (value) {
                                      val.setPembayaran = value!;
                                    },
                                    items: [
                                      DropdownMenuItem(
                                        child: SizedBox(
                                          height: 20,
                                          width: 60,
                                          child: Image.asset(
                                            "assets/images/gopay.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        value: 1,
                                      ),
                                      DropdownMenuItem(
                                        child: SizedBox(
                                          height: 20,
                                          width: 60,
                                          child: Image.asset(
                                            "assets/images/ovo.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        value: 2,
                                      ),
                                      DropdownMenuItem(
                                        child: SizedBox(
                                          height: 20,
                                          width: 60,
                                          child: Image.asset(
                                            "assets/images/dana.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        value: 3,
                                      ),
                                      DropdownMenuItem(
                                        child: SizedBox(
                                          height: 20,
                                          width: 60,
                                          child: Image.asset(
                                            "assets/images/cod.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        value: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          height: 2,
                          thickness: 2,
                        ),
                      ),
                      Consumer<DropDownNotifier>(
                        builder: (_, val, __) => GestureDetector(
                          onTap: () => val.selectDate(context),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40, right: 40),
                            child: SizedBox(
                              height: 45,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      DateFormat('EEEE, d MMM yyyy')
                                          .format(val.selectedDate),
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.date_range_rounded,
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          height: 2,
                          thickness: 2,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.only(left: 40, right: 40),
                        child: Text(
                          "Pastikan pesananmu sudah sesuai dengan kriteria",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: (isEmpty)
                            ? null
                            : () async {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (_) => const CustomLoading(),
                                );
                                String orderId = await order.insertOrder(
                                  userId: user.getUser.id,
                                  categoryId: dropdown.getRasa.toString(),
                                  paymentId: dropdown.getPembayaran.toString(),
                                  quantity: int.parse(quantityController.text),
                                  sizeId: dropdown.getKemasan.toString(),
                                  date: dropdown.selectedDate,
                                );
                                location.getAddress().then(
                                  (value) {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(
                                        context, Routes.checkout, arguments: {
                                      "order_id": orderId,
                                      "category_id": dropdown.getRasa.toString()
                                    });
                                  },
                                );
                              },
                        child: const Text(
                          "PESAN",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(size.width * 0.3, 40),
                          primary: const Color(0xFF41E507),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            );
          },
        ),
      ],
    );
  }
}
