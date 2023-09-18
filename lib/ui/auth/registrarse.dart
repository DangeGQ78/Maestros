import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maestros/domain/controllers/controllerUsers.dart';

class Regristrase extends StatelessWidget {
  const Regristrase({super.key});
  static final textImail = TextEditingController();
  static final TextEditingController textPassword = TextEditingController();
  static final TextEditingController textPasswordConfirm =
      TextEditingController();
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
          text_pass(
            textPassword: textPassword,
            colors: colors,
            hiddentext: "Contraseña",
          ),
          text_pass(
              textPassword: textPasswordConfirm,
              colors: colors,
              hiddentext: "Confirmar contraseña"),
          button_signUp(
            colors: colors,
            controlu: controlu,
            textImail: textImail,
            textPassword: textPassword,
            textPasswordConfirm: textPasswordConfirm,
          ),
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
    required this.textPasswordConfirm,
  });

  final Color colors;
  final UsersController controlu;
  final TextEditingController textImail;
  final TextEditingController textPassword;
  final TextEditingController textPasswordConfirm;

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
              if (verificarPass(textPassword.text, textPasswordConfirm.text)) {
                controlu.crearUsuario(textImail.text, textPassword.text).then(
                  (value) {
                    Get.snackbar(
                      'Maestros',
                      controlu.mensaje.value,
                      duration: const Duration(seconds: 3),
                      icon: const Icon(Icons.info),
                      shouldIconPulse: true,
                    );
                  },
                );
                Get.back();
              } else {
                Get.snackbar(
                  'Maestros',
                  'la contraseñas no coinciden',
                  duration: const Duration(seconds: 3),
                  icon: const Icon(Icons.info),
                  shouldIconPulse: true,
                );
              }
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
  const text_pass(
      {super.key,
      required this.textPassword,
      required this.colors,
      required this.hiddentext});

  final TextEditingController textPassword;
  final Color colors;
  final String hiddentext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50, top: 40),
      child: TextField(
        controller: textPassword,
        obscureText: true,
        decoration: InputDecoration(
          hintText: hiddentext,
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
      padding: const EdgeInsets.only(
        top: 50,
        left: 50,
        right: 50,
      ),
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

bool verificarPass(textPass, textEmailConfirm) {
  if (textPass == textEmailConfirm) {
    return true;
  }
  return false;
}
