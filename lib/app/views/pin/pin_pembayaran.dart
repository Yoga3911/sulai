import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/models/order_model.dart';
import 'package:sulai/app/routes/route.dart';
import 'package:sulai/app/view_model/order_provider.dart';
import 'package:sulai/app/view_model/user_provider.dart';
import 'package:sulai/app/widgets/app_bar.dart';
import 'package:sulai/app/widgets/loading.dart';
import 'package:sulai/app/widgets/main_style.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant/color.dart';

class PaymentPinPage extends StatefulWidget {
  const PaymentPinPage({Key? key}) : super(key: key);

  @override
  State<PaymentPinPage> createState() => _PaymentPinPageState();
}

class _PaymentPinPageState extends State<PaymentPinPage> {
  TextEditingController pin = TextEditingController();

  String currentText = "";

  Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw "Could not launce $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false);
    final order = Provider.of<OrderProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    OrderModel orderData = args["order_data"];
    return MainStyle(
      widget: [
        const CustomAppBar(),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Container(
                width: size.width,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.pin_rounded,
                      color: MyColor.grey,
                      size: 40,
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "PIN",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Isikan pin untuk keamanan saat pembayaran",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "MASUKKAN PIN",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: PinCodeTextField(
                        length: 6,
                        obscureText: true,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          inactiveColor:
                              const Color.fromARGB(255, 190, 190, 190),
                          inactiveFillColor:
                              const Color.fromARGB(255, 214, 214, 214),
                          selectedColor:
                              const Color.fromARGB(255, 255, 207, 96),
                          selectedFillColor:
                              const Color.fromARGB(255, 255, 219, 134),
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 50,
                          activeFillColor: Colors.white,
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        controller: pin,
                        onCompleted: (v) {
                          debugPrint("Completed");
                        },
                        onChanged: (value) {
                          debugPrint(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          return true;
                        },
                        appContext: context,
                      ),
                    ),
                    const Text("Masukkan pin anda dengan benar"),
                    ElevatedButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (_) => const CustomLoading(),
                        );
                        user
                            .getPin(pin: pin.text, userId: user.getUser.id)
                            .then((valid) async {
                          if (valid) {
                            (orderData.checkoutUrl.isNotEmpty)
                                ? await launchURL(orderData.checkoutUrl)
                                    .then((value) async {
                                    order.updateStatus(
                                      orderId: args["order_id"],
                                      statusId: "2",
                                      address: args["address"],
                                      postalCode: args["post_code"],
                                    );

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Pembayaran berhasil. Kembali ke beranda dalam 3 detik"),
                                        backgroundColor: Colors.green,
                                        duration: Duration(seconds: 3),
                                      ),
                                    );

                                    await Future.delayed(
                                        const Duration(seconds: 3));

                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      Routes.main,
                                      (route) => false,
                                    );
                                  })
                                : null;

                            return;
                          }
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Pin yang anda masukkan salah"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF41E507),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Konfirmasi"),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
