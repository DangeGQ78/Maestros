import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:maestros/domain/controllers/controllerUsers.dart';
import 'package:maestros/domain/models/grupos.dart';
import 'package:maestros/peticiones/peticionesMateria.dart';

import '../models/Materias.dart';

class MateriasController extends GetxController {
  final RxList<Materia> MateriaFirebase = RxList<Materia>([]);
  UsersController userc = Get.find();
  final RxString mensaje = "".obs;

  Future<void> consultarMateria(uid) async {
    List<Materia> listafinal = [];
    QuerySnapshot query = await PeticionesMateria.consultarMaterias(uid);
    for (var doc in query.docs) {
      var datos = doc.data() as Map<String, dynamic>;
      String nombre = datos['nombre'] ?? '';
      Map<String, dynamic> grupos = datos['grupos'] ?? {};
      Map<int, Grupo> gruposMapeados = {};
      grupos.forEach((key, value) {
        int id = int.tryParse(key) ?? 0;
        if (id > 0) {
          Map<String, String> datosGrupo = value.cast<String, String>();
          String nombreGrupo = datosGrupo['nombre'] ?? '';
          Grupo grupo = Grupo(nombre: nombreGrupo);
          gruposMapeados[id] = grupo;
        }
      });
      Materia materia = Materia(nombre: nombre, grupos: gruposMapeados);

      listafinal.add(materia);
    }

    MateriaFirebase.value = listafinal;
    for (int i = 0; i < MateriaFirebase.length; i++) {
      print(MateriaFirebase[i].nombre);
    }
  }

  Future<void> crearMateria(nombre, grupos, uid) async {
    Materia m = Materia(nombre: nombre, grupos: generarGrupos(grupos));
    mensaje.value = await PeticionesMateria.guardarMateria(m, uid);
    consultarMateria(uid);
  }

  Map<int, Grupo> generarGrupos(int cantidadGrupos) {
    Map<int, Grupo> grupos = {};
    for (int i = 1; i <= cantidadGrupos; i++) {
      String nombreGrupo = 'grupo$i';
      grupos[i] = Grupo(nombre: nombreGrupo);
    }
    return grupos;
  }
}
