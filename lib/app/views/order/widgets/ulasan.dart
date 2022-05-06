import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sulai/app/routes/route.dart';
import 'package:sulai/app/view_model/ulasan_provider.dart';
import 'package:sulai/app/widgets/app_bar.dart';
import 'package:sulai/app/widgets/loading.dart';
import 'package:sulai/app/widgets/main_style.dart';

import '../../../constant/color.dart';
import '../../../view_model/user_provider.dart';

class UlasanPage extends StatefulWidget {
  const UlasanPage({Key? key}) : super(key: key);

  @override
  State<UlasanPage> createState() => _UlasanPageState();
}

class _UlasanPageState extends State<UlasanPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ulasan = Provider.of<UlasanProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false).getUser;
    final ulasanUser =
        ModalRoute.of(context)?.settings.arguments ?? {"ulasan": ""};
    _controller.text = (ulasanUser as Map<String, dynamic>)["ulasan"];
    return MainStyle(
      widget: [
        const CustomAppBar(),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            padding: const EdgeInsets.all(10),
            width: size.width,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                const Icon(
                  Icons.comment,
                  color: MyColor.grey,
                  size: 40,
                ),
                const SizedBox(width: 5),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "ULASAN",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Silahkan berikan ulasan kepada kami.",
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
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Text("Ulasan", style: TextStyle(fontSize: 16)),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: double.infinity,
              maxWidth: double.infinity,
              minHeight: 25.0,
              maxHeight: 135.0,
            ),
            child: Scrollbar(
              child: TextField(
                autofocus: true,
                controller: _controller,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.all(10),
                  hintText: "Type your message",
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => const CustomLoading(),
                  );
                  (ulasanUser["ulasan"] != "")
                      ? ulasan
                          .updateDate(
                              ulasan: _controller.text,
                              ulasanId: ulasanUser["ulasan_id"])
                          .then(
                            (value) => Navigator.pushNamedAndRemoveUntil(
                              context,
                              Routes.home,
                              (route) => false,
                            ),
                          )
                      : ulasan
                          .insertData(
                            ulasan: _controller.text,
                            userId: user.id,
                          )
                          .then(
                            (value) => Navigator.pushNamedAndRemoveUntil(
                              context,
                              Routes.home,
                              (route) => false,
                            ),
                          );
                },
                child: (ulasanUser["ulasan"] != "")
                    ? const Text("Ubah")
                    : const Text("Kirim"),
              )
            ],
          ),
        )
      ],
    );
  }
}
