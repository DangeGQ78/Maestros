import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerGlobal extends StatelessWidget {
  const DrawerGlobal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        DrawerHeader(
          decoration: BoxDecoration(
              color: const Color.fromRGBO(0, 191, 99, 1),
              borderRadius: BorderRadius.circular(10)),
          child: Image.asset("ic_launcher.png"),
        ),
        ListTile(
          title: const Center(child: Text("Materias")),
          onTap: () {
            Get.toNamed("/materias");
          },
        ),
        ListTile(
          title: const Center(child: Text("Horario")),
          onTap: () {
            Get.toNamed("/materias");
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
