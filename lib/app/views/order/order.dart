import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/view_model/dropdown.dart';
import 'package:sulai/app/view_model/location.dart';
import 'package:sulai/app/widgets/app_bar.dart';
import 'package:sulai/app/widgets/main_style.dart';
import '../../routes/route.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final location = Provider.of<MyLocation>(context);
    final size = MediaQuery.of(context).size;
    return MainStyle(widget: [
      Column(
        children: [
          const CustomAppBar(),
          Consumer<DropDownNotifier>(
            builder: (_, val, __) => SizedBox(
              height: size.height * 0.25,
              width: size.width,
              child: Image.asset(
                val.getImg,
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
                            builder: (_, val, __) => DropdownButton<int>(
                              style: const TextStyle(color: Colors.grey),
                              value: val.getRasa,
                              onChanged: (value) {
                                val.setRasa = value!;
                                if (value == 1) {
                                  val.setImg = "assets/images/sulai2.png";
                                } else if (value == 2) {
                                  val.setImg = "assets/images/sulai2.jpg";
                                } else if (value == 3) {
                                  val.setImg = "assets/images/sulai3.jpg";
                                }
                              },
                              items: const [
                                DropdownMenuItem(
                                  child: Text("Sulai Original"),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text("Sulai Stroberi"),
                                  value: 2,
                                ),
                                DropdownMenuItem(
                                  child: Text("Sulai Melon"),
                                  value: 3,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.info_rounded,
                        color: Colors.blue,
                      )
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
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.info_rounded,
                        color: Colors.blue,
                      )
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
                    children: const [
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
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
                      SizedBox(width: 10),
                      Icon(
                        Icons.info_rounded,
                        color: Colors.blue,
                      )
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
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.info_rounded,
                        color: Colors.blue,
                      )
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
                                style: const TextStyle(color: Colors.grey),
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
                  onPressed: () async {
                    await location.getAddress().then(
                          (value) => Navigator.pushNamed(
                            context,
                            Routes.checkout,
                          ),
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
                      )),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    ]);
  }
}
