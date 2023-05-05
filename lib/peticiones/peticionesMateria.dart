import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;

class PeticionesMateria {
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> crearMateria() async {
    await _db.collection('materias').add({
      'nombre': 'naturales',
      'grupos': {
        'Grupo 1': {
          'lunes': '10 am - 12 pm',
          'miércoles': '2 pm - 4 pm',
        },
        'Grupo 2': {
          'martes': '8 am - 10 am',
          'jueves': '4 pm - 6 pm',
        },
      },
    });
  }
}
