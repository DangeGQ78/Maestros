import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maestros/ui/auth/login.dart';
import 'package:maestros/ui/auth/registrarse.dart';
import 'package:maestros/ui/pages/maters/View_materias.dart';
import 'package:maestros/ui/pages/actividades.dart';
import 'package:maestros/ui/pages/home/home.dart';
import 'package:maestros/ui/pages/listas.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "maestros",
      theme: ThemeData(primaryColor: Colors.green),
      home: const Login(),
      routes: {
        "/login": (context) => const Login(),
        "/home": (context) => const Home(),
        "/materias": (context) => const View_Materias(),
        "/actividades": (context) => const Actividades(),
        "/listas": (context) => const Listas(),
        "/registrarse": (context) => const Regristrase()
      },
    );
  }
}
