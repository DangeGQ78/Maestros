import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maestros/domain/controllers/controllerUsers.dart';
import 'package:maestros/peticiones/peticionesMateria.dart';
import 'package:maestros/domain/models/dias.dart';

import '../models/Materias.dart';

class MateriasController extends GetxController {
  final RxList<Grupo> MateriaFirebase = RxList<Grupo>([]);
  UsersController userc = Get.find();
  final RxString mensaje = "".obs;

  Future<void> consultarGrupos(correo) async {
    List<Grupo> listafinal = [];
    QuerySnapshot query = await PeticionesMateria.consultarMaterias(correo);

    String id;
    String nombre;

    for (var doc in query.docs) {
      id = doc.id;
      var datos = doc.data() as Map<String, dynamic>;
      nombre = datos['nombre'];
      List<dynamic> list = datos['horario'];
      List<Dia> dias = [];
      for (var e in list) {
        dias.add(Dia(
            nombre: e['nombre'],
            horaInicio: formatHour(e['horaInicio']),
            horaFin: formatHour(e['horaFin'])));
      }

      Grupo grupo = Grupo(nombre: nombre, id: id, dias: dias);
      listafinal.add(grupo);
    }

    MateriaFirebase.value = listafinal;
  }

  Future<void> crearGrupo(nombre, dias, uid) async {
    Grupo g = Grupo(nombre: nombre, dias: dias, id: "");
    mensaje.value = await PeticionesMateria.guardarGrupo(g, uid);
    consultarGrupos(uid);
  }

  Future<void> eliminarGrupo(id) async {
    try {
      mensaje.value = await PeticionesMateria.eliminargrupo(id);
      consultarGrupos(userc.user!.email);
    } catch (e) {
      mensaje.value = "no se pudo eliminar";
    }
  }

  TimeOfDay formatHour(String time) {
    List<String> s = time.split(":");
    return TimeOfDay(hour: int.parse(s.first), minute: int.parse(s.last));
  }

  void comprobarData() {
    if (MateriaFirebase.isEmpty) {
      consultarGrupos(userc.user?.email);
    }
  }
}
