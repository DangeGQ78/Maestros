import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maestros/domain/controllers/controllerMaterias.dart';
import 'package:maestros/domain/controllers/controllerUsers.dart';
import 'package:maestros/ui/app.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyDFCfb2L3mNWnyBgMyJIiL07nr_l9p4pxM",
    appId: "1:188585215886:android:6d982eff6adc653113c6df",
    messagingSenderId: "188585215886",
    projectId: "maestros-1136f",
  ));
  Get.put(UsersController());
  Get.put(MateriasController());
  runApp(const App());
}

//añadir options si quieres hacer el debug usando el navegador
//en caso de hacer el building directamente en el dispositio eliminar el object option

/*
 
*/