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
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, bottom: 50),
            child: TextField(
              controller: textImail,
              decoration: InputDecoration(
                hintText: "imail@example.com",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: colors)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: colors)),
              ),
              cursorColor: colors,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: TextField(
              controller: textPassword,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "password",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: colors)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: colors)),
              ),
              cursorColor: colors,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Container(
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                  color: colors,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Colors.black, style: BorderStyle.solid)),
              child: OutlinedButton(
                  onPressed: () {
                    controlu
                        .crearUsuario(textImail.text, textPassword.text)
                        .then((value) {
                      Get.snackbar('Maestros', controlu.mensaje.value,
                          duration: const Duration(seconds: 3),
                          icon: const Icon(Icons.info),
                          shouldIconPulse: true,
                          backgroundColor: Colors.yellow);
                    });

                    Get.back();
                  },
                  child: const Text(
                    "registrarse",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
