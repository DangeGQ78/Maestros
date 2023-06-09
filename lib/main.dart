import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maestros/domain/controllers/controllerDate.dart';
import 'package:maestros/domain/controllers/controllerHorario.dart';
import 'package:maestros/domain/controllers/controllerMaterias.dart';
import 'package:maestros/domain/controllers/controllerStudent.dart';
import 'package:maestros/domain/controllers/controllerUsers.dart';
import 'package:maestros/ui/app.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetPlatform.isWeb
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyDFCfb2L3mNWnyBgMyJIiL07nr_l9p4pxM",
              authDomain: "maestros-1136f.firebaseapp.com",
              projectId: "maestros-1136f",
              storageBucket: "maestros-1136f.appspot.com",
              messagingSenderId: "188585215886",
              appId: "1:188585215886:web:52ddc76cf0650a8b13c6df"))
      : await Firebase.initializeApp();

  /*await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyDFCfb2L3mNWnyBgMyJIiL07nr_l9p4pxM",
    appId: "1:188585215886:android:6d982eff6adc653113c6df",
    messagingSenderId: "188585215886",
    projectId: "maestros-1136f",
  ));*/
  Get.put(UsersController());
  Get.put(MateriasController());
  Get.put(DateController());
  Get.put(HorarioController());
  Get.put(StudentController());
  runApp(const App());
}

//añadir options si quieres hacer el debug usando el navegador
//en caso de hacer el building directamente en el dispositio eliminar el object option

/*
 
*/