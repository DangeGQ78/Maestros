import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maestros/domain/controllers/controllerUsers.dart';
import 'package:maestros/ui/pages/utils/drawer.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  static Color micolor = const Color.fromRGBO(0, 191, 99, 1);
  @override
  Widget build(BuildContext context) {
    UsersController controlu = Get.find();
    return Scaffold(
        appBar: AppBar(
          title: const Text("HOME"),
          backgroundColor: micolor,
          actions: [
            IconButton(
                onPressed: () {
                  controlu.cerrarSesion();
                  Get.offAllNamed("/login");
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        drawer: const DrawerGlobal(),
        body: Center(
          child: Column(
            children: [const Boxdate(), Text(recuperarUsuario())],
          ),
        ));
  }
}

String recuperarUsuario() {
  UsersController controlu = Get.find();
  String email = "";
  controlu
      .consultarUsuario()
      .then((value) => {email = controlu.user!.email.toString()});
  print(email);
  return email;
}

class Boxdate extends StatelessWidget {
  const Boxdate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("proxima clase"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${DateTime.now()}"),
          )
        ],
      ),
    );
  }
}
