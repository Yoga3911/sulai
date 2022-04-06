import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/constant/color.dart';
import 'package:sulai/app/views/auth/widgets/register_field.dart';
import 'package:sulai/app/widgets/glow.dart';
import 'package:sulai/app/widgets/loading.dart';

import '../../routes/route.dart';
import '../../services/email.dart';
import '../../view_model/auth_provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final login = Provider.of<LoginProvider>(context);
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: ScrollConfiguration(
        behavior: NoGlow(),
        child: Scaffold(
          body: Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(gradient: MyColor.linerGradient),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.125),
                  SizedBox(
                    height: size.height * 0.3,
                    width: size.width,
                    child: Image.asset(
                      "assets/images/milk.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: size.height,
                    width: size.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/container.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 30),
                            Image.asset("assets/images/sulai.png"),
                            const Text(
                              "Selamat datang di aplikasi Sulai",
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 40),
                            const Text(
                              "SIGN UP",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  BoxShadow(
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                    offset: Offset(2, 5),
                                    color: Color.fromARGB(255, 196, 196, 196),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            UsernameRegister(controller: login.nameRegis),
                            const SizedBox(height: 20),
                            EmailRegister(controller: login.emailRegis),
                            const SizedBox(height: 20),
                            PasswordRegister1(controller: login.pass1Regis),
                            const SizedBox(height: 20),
                            PasswordRegister2(controller: login.pass2Regis),
                            const SizedBox(height: 25),
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => const CustomLoading());
                                login.signUp(
                                  context,
                                  name: login.nameRegis.text,
                                  email: login.emailRegis.text,
                                  password: login.pass1Regis.text,
                                );
                              },
                              child: const Text(
                                "REGISTER",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: MyColor.cream,
                                fixedSize: Size(size.width * 0.4, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                      text: "Sudah memiliki akun ? "),
                                  TextSpan(
                                    text: "masuk",
                                    style: const TextStyle(color: MyColor.blue),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Navigator.pop(context),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 60),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
