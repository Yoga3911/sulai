import 'package:flutter/material.dart';
import 'package:sulai/app/constant/color.dart';

class UsernameLogin extends StatefulWidget {
  const UsernameLogin({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  State<UsernameLogin> createState() => _UsernameLogin();
}

class _UsernameLogin extends State<UsernameLogin> {
  Color _color = Colors.grey;

  final _focusNode = FocusNode();
  @override
  void initState() {
    _focusNode.addListener(
      () => setState(
        () => _color = _focusNode.hasFocus ? MyColor.cream : Colors.grey,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.1),
      child: TextField(
        controller: widget.controller,
        cursorColor: MyColor.cream,
        focusNode: _focusNode,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person_rounded,
            color: _color,
          ),
          isDense: true,
          contentPadding: const EdgeInsets.all(15),
          hintText: "Username ...",
          label: const Text("Username"),
          labelStyle: const TextStyle(color: MyColor.cream),
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0, color: Colors.transparent),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: MyColor.cream,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}

class PasswordLogin extends StatefulWidget {
  const PasswordLogin({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  State<PasswordLogin> createState() => _PasswordLoginState();
}

class _PasswordLoginState extends State<PasswordLogin> {
  Color _color = Colors.grey;
  bool isVisible = false;

  final _focusNode = FocusNode();
  @override
  void initState() {
    _focusNode.addListener(
      () => setState(
        () => _color = _focusNode.hasFocus ? MyColor.cream : Colors.grey,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.1),
      child: TextField(
        controller: widget.controller,
        cursorColor: MyColor.cream,
        focusNode: _focusNode,
        obscureText: isVisible? false : true,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock_rounded,
            color: _color,
          ),
          suffixIcon: IconButton(
            onPressed: () => setState(() => isVisible = !isVisible),
            icon: isVisible
                ? const Icon(Icons.visibility_rounded)
                : const Icon(Icons.visibility_off_rounded),
            color: _color,
          ),
          isDense: true,
          contentPadding: const EdgeInsets.all(15),
          hintText: "Password ...",
          label: const Text("Password"),
          labelStyle: const TextStyle(color: MyColor.cream),
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0, color: Colors.transparent),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: MyColor.cream,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
