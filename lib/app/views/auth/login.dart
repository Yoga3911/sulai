import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/constant/color.dart';
import 'package:sulai/app/services/facebook.dart';
import 'package:sulai/app/services/google.dart';
import 'package:sulai/app/views/auth/widgets/login_field.dart';
import 'package:sulai/app/widgets/glow.dart';
import 'package:sulai/app/widgets/hash.dart';

import '../../routes/route.dart';
import '../../services/email.dart';
import '../../view_model/auth_provider.dart';
import '../../widgets/loading.dart';

class LoginPage extends HookWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    // final user = Provider.of<UserProvider>(context);
    final size = MediaQuery.of(context).size;
    final emailLogin = useTextEditingController();
    final passLogin = useTextEditingController();
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
                              "SIGN IN",
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
                            EmailLogin(controller: emailLogin),
                            const SizedBox(height: 20),
                            PasswordLogin(controller: passLogin),
                            const SizedBox(height: 25),
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => const CustomLoading(),
                                );
                                auth.login(
                                  context: context,
                                  social: EmailService(),
                                  provider: "email",
                                  email: emailLogin.text,
                                  password: hashPass(passLogin.text),
                                );
                              },
                              child: const Text(
                                "LOGIN",
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
                            const Text(
                              "Lupa Password ?",
                              style: TextStyle(
                                color: MyColor.blue,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                      text: "Belum memiliki akun ? "),
                                  TextSpan(
                                    text: "buat akun",
                                    style: const TextStyle(color: MyColor.blue),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Navigator.pushNamed(
                                          context, Routes.register),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 2,
                                  width: size.width * 0.15,
                                  color: Colors.black,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Text(
                                    "OR",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 2,
                                  width: size.width * 0.15,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (_) => const CustomLoading(),
                                    );
                                    auth.login(
                                      context: context,
                                      social: GoogleService(),
                                      provider: "google",
                                    );
                                  },
                                  icon: Image.asset("assets/icons/google.png"),
                                ),
                                const SizedBox(width: 20),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (_) => const CustomLoading(),
                                    );
                                    auth.login(
                                      context: context,
                                      social: FacebookService(),
                                      provider: "facebook",
                                    );
                                  },
                                  icon:
                                      Image.asset("assets/icons/facebook.png"),
                                ),
                              ],
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
