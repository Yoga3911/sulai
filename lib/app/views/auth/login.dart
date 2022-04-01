import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sulai/app/constant/color.dart';
import 'package:sulai/app/views/auth/widgets/button.dart';
import 'package:sulai/app/views/auth/widgets/circle.dart';
import 'package:sulai/app/views/auth/widgets/txt_field.dart';
import 'package:sulai/app/widgets/glow.dart';

class LoginPage extends HookWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final usernameTxt = TextEditingController();
    final passwordTxt = TextEditingController();
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
                            UsernameTxt(controller: usernameTxt),
                            const SizedBox(height: 20),
                            PasswordTxt(controller: passwordTxt),
                            const SizedBox(height: 25),
                            const AuthButton(),
                            const SizedBox(height: 20),
                            const Text(
                              "Lupa Password ?",
                              style: TextStyle(
                                color: MyColor.blue,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: "Belum memiliki akun ? "),
                                  TextSpan(
                                    text: "buat akun",
                                    style: TextStyle(color: MyColor.blue),
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
                                  onPressed: () {},
                                  icon: Image.asset("assets/icons/google.png"),
                                ),
                                const SizedBox(width: 20),
                                IconButton(
                                  onPressed: () {},
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
