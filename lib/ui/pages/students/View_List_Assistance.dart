import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maestros/domain/controllers/controllerMaterias.dart';
import 'package:maestros/domain/controllers/controllerStudent.dart';
import 'package:maestros/domain/models/Materias.dart';
import 'package:maestros/domain/models/estudiante.dart';

class ListAssistanceStudent extends StatelessWidget {
  const ListAssistanceStudent({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentController controle = Get.find();
    final MateriasController controlm = Get.find();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        controle.listaEstudiante.clear();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Lista de asistencia"),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Grupos : "),
              _dropDownButton(controlm, controle)
            ],
          ),
          Expanded(
              child: Obx(
            () => ListView.builder(
              itemCount: controle.listaEstudiante.isEmpty
                  ? 1
                  : controle.listaEstudiante.length,
              itemBuilder: (BuildContext context, int index) {
                if (controle.listaEstudiante.isEmpty) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 0.3 * MediaQuery.of(context).size.height,
                      ),
                      const ListTile(
                        title: Text(
                          "Selecciona el grupo",
                          style: TextStyle(color: Colors.black26, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: ListTile(
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text("Asistio"),
                                Checkbox(
                                    value: false,
                                    onChanged: (value) =>
                                        {value! ? false : true}),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text("Excusa"),
                                Checkbox(
                                    value: false,
                                    onChanged: (value) =>
                                        {value! ? false : true}),
                              ],
                            ),
                          ),
                        ],
                      ),
                      leading: Icon(
                        Icons.perm_contact_calendar_sharp,
                        color: Colors.greenAccent.shade400,
                        size: 40,
                      ),
                      title: Text(
                          "Nombres:${controle.listaEstudiante[index].nombre}"),
                      subtitle: Text(
                          "Apellidos  :${controle.listaEstudiante[index].apellidos}"),
                    ),
                  );
                }
              },
            ),
          ))
        ]),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _showFormDialogAdd(context, controle);
          },
          icon: const Icon(Icons.add),
          label: const Text("Guardar asistencia"),
        ),
      ),
    );
  }
}

_dropDownButton(MateriasController mc, StudentController sc) {
  List<Grupo> list = mc.MateriaFirebase;
  return Obx(() => SizedBox(
        width: 200,
        child: DropdownButtonFormField(
            hint: const Text("Seleccione el grupo"),
            alignment: Alignment.centerLeft,
            items: list
                .map((grupo) => DropdownMenuItem(
                      value: grupo.nombre,
                      child: Text(grupo.nombre),
                    ))
                .toList(),
            onChanged: (value) {
              for (var m in list) {
                if (m.nombre == value) {
                  sc.idclass.value = m.id;
                }
              }

              sc.cargarEstudiantes();
            }),
      ));
}

_showFormDialogAdd(context, StudentController controls) {
  final TextEditingController textNombres = TextEditingController();
  final TextEditingController textApellidos = TextEditingController();
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Añadir estudiante"),
          content: SizedBox(
            height: 150,
            child: Form(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: textNombres,
                  decoration: const InputDecoration(label: Text("Nombres")),
                ),
                TextField(
                  controller: textApellidos,
                  decoration: const InputDecoration(label: Text("Apellidos")),
                ),
              ],
            )),
          ),
          actions: [
            ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Cancelar"),
                ),
                TextButton(
                    onPressed: () async {
                      await controls
                          .guardarEstudiantes(
                              textNombres.text, textApellidos.text)
                          .then((value) {
                        Get.snackbar("Estudiante", controls.mensaje.value,
                            duration: const Duration(seconds: 3),
                            icon: const Icon(Icons.warning));
                        Get.back();
                      });
                    },
                    child: const Text("Guardar")),
              ],
            )
          ],
        );
      });
}

bool comprobarCampos(String n, String a) {
  if (n.isEmpty || a.isEmpty) {
    return true;
  } else {
    return false;
  }
}
