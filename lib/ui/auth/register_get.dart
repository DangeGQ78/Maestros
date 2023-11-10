import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:maestros/domain/controllers/controllerUsers.dart';
import 'package:maestros/domain/controllers/login_controller.dart';

class RegisterGet extends StatelessWidget {
  const RegisterGet({super.key});
  static Color mycolor = const Color.fromRGBO(0, 191, 99, 1);
  static late Size mediaSize;
  static TextEditingController emailText = TextEditingController();
  static TextEditingController passText = TextEditingController();
  static TextEditingController passTextConfirm = TextEditingController();
  static LoginController loginController = Get.find();
  static UsersController usersController = Get.find();
  @override
  Widget build(BuildContext context) {
    mycolor = const Color.fromRGBO(0, 191, 99, 1);
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: mycolor,
        image: DecorationImage(
            image: const AssetImage("assets/cover.jpg"),
            fit: BoxFit.cover,
            colorFilter:
                ColorFilter.mode(mycolor.withOpacity(0.2), BlendMode.dstATop)),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(top: 50, child: _buildTop()),
            Positioned(bottom: 0, child: Obx(() => _buildBottom()))
          ],
        ),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.school,
            size: 100,
            color: Colors.white,
          ),
          Text(
            "MAESTROS",
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _BuildForm(),
        ),
      ),
    );
  }

  Widget _BuildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Bienvenido",
          style: TextStyle(
              color: mycolor, fontSize: 32, fontWeight: FontWeight.w500),
        ),
        _BuildTextGray("Ingrese sus credenciales"),
        const SizedBox(height: 50),
        _BuildTextGray("Correo electronico"),
        _BuildInputField(emailText),
        const SizedBox(height: 40),
        _BuildTextGray("Contraseña"),
        _BuildInputField(passText, isPassword: true),
        const SizedBox(height: 40),
        _BuildTextGray("Confirmar contraseña"),
        _BuildInputField(passTextConfirm, isPassword: true),
        const SizedBox(height: 40),
        _BuildBottomAction("Guardar"),
        const SizedBox(height: 20),
        _BuildBottomAction("Cancelar")
      ],
    );
  }

  Widget _BuildTextGray(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _BuildInputField(TextEditingController textcontroller,
      {isPassword = false}) {
    if (isPassword) {
      return TextField(
        controller: textcontroller,
        maxLength: 15,
        obscureText: loginController.isObcured.value,
        decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () {
                  loginController.isObcured.value =
                      !loginController.isObcured.value;
                },
                icon: Icon(loginController.isObcured.value
                    ? Icons.visibility_off
                    : Icons.visibility))),
      );
    } else {
      return TextField(
        controller: textcontroller,
        decoration: const InputDecoration(suffixIcon: Icon(Icons.email)),
      );
    }
  }

  Widget _BuildBottomAction(String titulo) {
    return Center(
      child: Container(
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: mycolor,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(3, 3),
                  blurRadius: 5,
                  spreadRadius: 2,
                )
              ]),
          child: TextButton(
              onPressed: () {
                if (titulo == "Guardar") {
                  if (comprobar(passText.text, passTextConfirm.text)) {
                    usersController
                        .crearUsuario(emailText.text, passText.text)
                        .then((value) {
                      if (value) {
                        Get.toNamed("/login");
                      }
                    });
                  } else {
                    Get.snackbar("Error", "las contraseñas no coinciden",
                        duration: const Duration(seconds: 3));
                  }
                }
                if (titulo == "Cancelar") {
                  Get.back();
                }
              },
              child: Text(
                titulo,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ))),
    );
  }

  bool comprobar(String pass1, String pass2) {
    if (pass1 == pass2) {
      return true;
    }
    return false;
  }
}
