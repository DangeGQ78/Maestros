import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maestros/domain/controllers/controllerMaterias.dart';
import 'package:maestros/domain/controllers/controllerUsers.dart';
import 'package:maestros/domain/models/grupos.dart';

class View_grupos extends StatelessWidget {
  const View_grupos({super.key});
  static Color miColor = const Color.fromRGBO(0, 191, 99, 1);

  @override
  Widget build(BuildContext context) {
    UsersController userc = Get.find();
    MateriasController materiac = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Materias"),
        backgroundColor: miColor,
      ),
      body: Obx(() => ListView.builder(
            itemCount: materiac.MateriaFirebase.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 5,
                color: const Color.fromRGBO(2, 238, 124, 1),
                child: ListTile(
                    title: Text(materiac.MateriaFirebase[index].nombre),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      IconButton(
                          onPressed: () {
                            materiac
                                .eliminarGrupo(
                                    materiac.MateriaFirebase[index].id)
                                .then((value) {
                              Get.snackbar("Materia", materiac.mensaje.value,
                                  duration: const Duration(seconds: 5));
                            });
                          },
                          icon: const Icon(Icons.delete)),
                      IconButton(
                          onPressed: () {
                            materiac
                                .eliminarGrupo(
                                    materiac.MateriaFirebase[index].id)
                                .then((value) {
                              Get.snackbar("Materia", materiac.mensaje.value,
                                  duration: const Duration(seconds: 5));
                            });
                          },
                          icon: const Icon(Icons.edit)),
                    ])),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed("/materiasAdd");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


/*
FutureBuilder(
          future: materiac.consultarMateria(userc.user?.email),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // La carga de materias ha terminado, mostramos la lista
              return ListView.builder(
                itemCount: materiac.MateriaFirebase.value?.length,
                itemBuilder: (BuildContext context, int index) {
                  return ExpansionTile(
                      title:
                          Text(materiac.MateriaFirebase.value![index].nombre),
                      children: _buildGruposPorMateria(
                          materiac.MateriaFirebase.value![index].grupos)
                          );
                },
              );
            } else {
              // La carga de materias está en progreso, mostramos un indicador de carga
              return const CircularProgressIndicator();
            }
          },
        )

*/