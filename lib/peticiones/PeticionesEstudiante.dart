import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:maestros/domain/controllers/controllerUsers.dart';
import 'package:maestros/domain/models/estudiante.dart';

class PeticionesEstudiantes {
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<QuerySnapshot<Map<String, dynamic>>> cargarEstudiantes(
      idclass) async {
    var querySnapshot = await _db
        .collection('estudiantes')
        .where('idclass', isEqualTo: idclass)
        .get();

    return querySnapshot;
  }

  static Future<String> guardarEstudiantes(Estudiante e) async {
    try {
      await _db.collection('estudiantes').add({
        'nombres': e.nombre,
        'apellidos': e.apellidos,
        'idclass': e.classID,
        'id': e.id
      });
      return "Estudiante guardado";
    } catch (e) {
      return "No se pudo guardar";
    }
  }

  static Future<void> editarEstudiantes() async {}

  static Future<void> eliminarEstudiantes() async {}
}
