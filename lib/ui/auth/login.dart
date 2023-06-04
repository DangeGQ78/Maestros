import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maestros/domain/controllers/controllerUsers.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController textEmail = TextEditingController();
  TextEditingController textPassword = TextEditingController();
  UsersController controlu = UsersController();
  var colors = const Color.fromRGBO(0, 191, 99, 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50, top: 50),
              child: Image.asset(
                "assets/ic_launcher.png",
              ),
            ),
            text_email(textEmail: textEmail, colors: colors),
            const SizedBox(height: 50),
            text_pass(textPassword: textPassword, colors: colors),
            Row(
              // botones del login
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                button_signUp(colors: colors),
                button_signIn(
                    colors: colors,
                    controlu: controlu,
                    textEmail: textEmail,
                    textPassword: textPassword)
              ],
            )
          ]),
        ),
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
    required this.textEmail,
    required this.colors,
  });

  final TextEditingController textEmail;
  final Color colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: TextField(
        controller: textEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "imail@example.com",
          prefixIcon: const Icon(
            Icons.account_circle,
          ),
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

class button_signIn extends StatelessWidget {
  const button_signIn({
    super.key,
    required this.colors,
    required this.controlu,
    required this.textEmail,
    required this.textPassword,
  });

  final Color colors;
  final UsersController controlu;
  final TextEditingController textEmail;
  final TextEditingController textPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 70, bottom: 50, left: 10),
        width: 150,
        height: 50,
        decoration: BoxDecoration(
            color: colors,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, style: BorderStyle.solid)),
        child: TextButton(
            onPressed: () {
              controlu
                  .iniciarSesion(textEmail.text, textPassword.text)
                  .then((value) {
                if (value) {
                  Get.toNamed("/home");
                }
              });
            },
            child: const Text(
              "ingresar",
              style: TextStyle(color: Colors.white, fontSize: 20),
            )));
  }
}

class button_signUp extends StatelessWidget {
  const button_signUp({
    super.key,
    required this.colors,
  });

  final Color colors;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 70, bottom: 50, right: 10),
        width: 150,
        height: 50,
        decoration: BoxDecoration(
            color: colors,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, style: BorderStyle.solid)),
        child: TextButton(
            onPressed: () {
              Get.toNamed("/registrarse");
            },
            child: const Text(
              "resgistrarse",
              style: TextStyle(color: Colors.white, fontSize: 20),
            )));
  }
}
