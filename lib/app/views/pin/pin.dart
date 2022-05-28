import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/routes/route.dart';
import 'package:sulai/app/view_model/user_provider.dart';
import 'package:sulai/app/widgets/app_bar.dart';
import 'package:sulai/app/widgets/loading.dart';
import 'package:sulai/app/widgets/main_style.dart';

import '../../constant/color.dart';

class PinPage extends StatefulWidget {
  const PinPage({Key? key}) : super(key: key);

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  TextEditingController pin = TextEditingController();

  String currentText = "";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
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
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => const CustomLoading(),
                        );
                        user
                            .insertPin(pin: pin.text, userId: user.getUser.id)
                            .then((_) {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, Routes.main);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF41E507),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Simpan"),
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
