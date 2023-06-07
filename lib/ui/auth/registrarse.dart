import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maestros/domain/controllers/controllerUsers.dart';

class Regristrase extends StatelessWidget {
  const Regristrase({super.key});
  static final textImail = TextEditingController();
  static final TextEditingController textPassword = TextEditingController();
  static var colors = const Color.fromRGBO(0, 191, 99, 1);
  static UsersController controlu = UsersController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("registrarse"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          text_email(textImail: textImail, colors: colors),
          text_pass(textPassword: textPassword, colors: colors),
          button_signUp(
              colors: colors,
              controlu: controlu,
              textImail: textImail,
              textPassword: textPassword),
        ],
      ),
    );
  }
}

class button_signUp extends StatelessWidget {
  const button_signUp({
    super.key,
    required this.colors,
    required this.controlu,
    required this.textImail,
    required this.textPassword,
  });

  final Color colors;
  final UsersController controlu;
  final TextEditingController textImail;
  final TextEditingController textPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
            color: colors,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, style: BorderStyle.solid)),
        child: OutlinedButton(
            onPressed: () {
              controlu
                  .crearUsuario(textImail.text, textPassword.text)
                  .then((value) {
                Get.snackbar(
                  'Maestros',
                  controlu.mensaje.value,
                  duration: const Duration(seconds: 3),
                  icon: const Icon(Icons.info),
                  shouldIconPulse: true,
                );
              });

              Get.back();
            },
            child: const Text(
              "registrarse",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}

class text_pass extends StatelessWidget {
  const text_pass({
    super.key,
    required this.textPassword,
    required this.colors,
  });

  final TextEditingController textPassword;
  final Color colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: TextField(
        controller: textPassword,
        obscureText: true,
        decoration: InputDecoration(
          hintText: "password",
          prefixIcon: const Icon(Icons.key),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: colors)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: colors)),
        ),
        cursorColor: colors,
      ),
    );
  }
}

class text_email extends StatelessWidget {
  const text_email({
    super.key,
    required this.textImail,
    required this.colors,
  });

  final TextEditingController textImail;
  final Color colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 50),
      child: TextField(
        controller: textImail,
        decoration: InputDecoration(
          hintText: "imail@example.com",
          prefixIcon: const Icon(Icons.account_circle),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: colors)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: colors)),
        ),
        cursorColor: colors,
      ),
    );
  }
}
