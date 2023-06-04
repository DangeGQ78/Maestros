import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controllers/controllerMaterias.dart';
import '../../../domain/controllers/controllerUsers.dart';

class DrawerGlobal extends StatelessWidget {
  const DrawerGlobal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MateriasController materiac = Get.find();
    UsersController userc = Get.find();
    return Drawer(
      child: ListView(children: [
        DrawerHeader(
          decoration: BoxDecoration(
              color: const Color.fromRGBO(0, 191, 99, 1),
              borderRadius: BorderRadius.circular(10)),
          child: Image.asset("assets/ic_launcher.png"),
        ),
        ListTile(
          title: const Center(child: Text("Materias")),
          onTap: () {
            materiac
                .consultarMateria(userc.user?.email)
                .then((value) => Get.toNamed("/materias"));
          },
        ),
        ListTile(
          title: const Center(child: Text("Horario")),
          onTap: () {
            Get.toNamed("/horario");
          },
        ),
        ListTile(
          title: const Center(child: Text("Listas")),
          onTap: () {
            Get.toNamed("/materias");
          },
        ),
        ListTile(
          title: const Center(child: Text("Notas")),
          onTap: () {
            Get.toNamed("/materias");
          },
        ),
      ]),
    );
  }
}
