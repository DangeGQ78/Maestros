import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maestros/domain/controllers/controllerMaterias.dart';
import 'package:maestros/domain/controllers/controllerUsers.dart';

class AddMaerias extends StatelessWidget {
  const AddMaerias({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nombre = TextEditingController();
    TextEditingController grupos = TextEditingController();
    MateriasController controlm = Get.find();
    UsersController controls = Get.find();
    //scaffoldAdd(nombre: nombre, grupos: grupos, controlm: controlm, controls: controls);
    return scaffoldAdd(
        nombre: nombre, grupos: grupos, controlm: controlm, controls: controls);
  }
}

class scaffoldAdd extends StatelessWidget {
  const scaffoldAdd({
    super.key,
    required this.nombre,
    required this.grupos,
    required this.controlm,
    required this.controls,
  });

  final TextEditingController nombre;
  final TextEditingController grupos;
  final MateriasController controlm;
  final UsersController controls;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar Materia"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          text_nombre(nombre: nombre),
          text_grupos(grupos: grupos),
          TextButton(
              onPressed: () {
                controlm
                    .crearMateria(nombre.text, int.parse(grupos.text),
                        controls.user?.email)
                    .then((value) {
                  Get.snackbar("Materia", controlm.mensaje.value);
                });
                controlm.consultarMateria(controls.user?.email);

                Get.back();
              },
              child: const Text("agregar"))
        ],
      ),
    );
  }
}

class text_grupos extends StatelessWidget {
  const text_grupos({
    super.key,
    required this.grupos,
  });

  final TextEditingController grupos;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 50),
      child: TextField(
        controller: grupos,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: "numero de grupos",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}

class text_nombre extends StatelessWidget {
  const text_nombre({
    super.key,
    required this.nombre,
  });

  final TextEditingController nombre;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 50),
      child: TextField(
        controller: nombre,
        decoration: InputDecoration(
            hintText: "Nombre de la materia",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        keyboardType: TextInputType.text,
      ),
    );
  }
}

void mostrarDialog(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: scaffoldAdd(
          nombre: TextEditingController(),
          grupos: TextEditingController(),
          controlm: MateriasController(),
          controls: UsersController(),
        ),
      );
    },
  );
}
