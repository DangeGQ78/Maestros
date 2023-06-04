import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:maestros/domain/controllers/controllerUsers.dart';
import 'package:maestros/domain/models/Materias.dart';

class PeticionesMateria {
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<String> guardarMateria(Materia materia, uid) async {
    if (uid == null) {
      return "no inicio sesion";
    }
    try {
      Map<String, dynamic> gruposMap = {};

      materia.grupos.forEach((id, grupo) {
        gruposMap[id.toString()] = {'nombre': grupo.nombre};
      });
      await _db.collection('materias').add({
        'idUser': uid,
        'nombre': materia.nombre,
        'grupos': gruposMap,
      });
      return "Materia guardada";
    } on FirebaseException catch (e) {
      return e.code;
    }
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> consultarMaterias(
      uid) async {
    print(
        "$uid--------------------------------------------------------------------");
    int i = 0;
    var querySnapshot =
        await _db.collection('materias').where('idUser', isEqualTo: uid).get();

    return querySnapshot;
  }
}
