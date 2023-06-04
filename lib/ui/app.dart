import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maestros/ui/auth/login.dart';
import 'package:maestros/ui/auth/registrarse.dart';
import 'package:maestros/ui/pages/horario/ViewHorario.dart';
import 'package:maestros/ui/pages/maters/View_materias.dart';
import 'package:maestros/ui/pages/actividades.dart';
import 'package:maestros/ui/pages/home/home.dart';
import 'package:maestros/ui/pages/list_student/listas.dart';
import 'package:maestros/ui/pages/maters/ViewaddMaterias.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "maestros",
      theme: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: const Color.fromRGBO(0, 191, 99, 1),
            ),
      ),
      home: FutureBuilder(
        future: FirebaseAuth.instance.authStateChanges().first,
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Mostrar una pantalla de carga mientras se verifica el estado de autenticación
            return const CircularProgressIndicator();
          } else {
            if (snapshot.hasData) {
              // Usuario autenticado, redirigir a la pantalla de inicio de la aplicación
              return const Home();
            } else {
              // No hay usuario autenticado, redirigir a la pantalla de inicio de sesión
              return const Login();
            }
          }
        },
      ),
      routes: {
        "/login": (context) => const Login(),
        "/home": (context) => const Home(),
        "/materias": (context) => const View_Materias(),
        "/materiasAdd": (context) => const AddMaerias(),
        "/actividades": (context) => const Actividades(),
        "/horario": (context) => const ViewHorario(),
        "/listas": (context) => const Listas(),
        "/registrarse": (context) => const Regristrase()
      },
    );
  }

  void comprobarUser() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Get.toNamed("/login");
      } else {
        Get.toNamed("/home");
      }
    });
  }
}
