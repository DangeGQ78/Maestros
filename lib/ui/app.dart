import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:maestros/ui/auth/login.dart';
import 'package:maestros/ui/auth/registrarse.dart';
import 'package:maestros/ui/pages/horario/ViewHorario.dart';
import 'package:maestros/ui/pages/maters/View_Grupos.dart';
import 'package:maestros/ui/pages/actividades.dart';
import 'package:maestros/ui/pages/home/home.dart';
import 'package:maestros/ui/pages/students/View_List_Assistance.dart';
import 'package:maestros/ui/pages/students/View_List_Studen.dart';
import 'package:maestros/ui/pages/maters/View_Add_Materias.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
//ViewaddMaterias

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "maestros",
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        SfGlobalLocalizations.delegate
      ],
      supportedLocales: [Locale('es'), Locale('Es')],
      locale: Locale('es'),
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
        "/materias": (context) => const View_grupos(),
        "/materiasAdd": (context) => const AddMaerias(),
        "/actividades": (context) => const Actividades(),
        "/horario": (context) => ViewHorario(),
        "/listas": (context) => const ListStudent(),
        "/listaAsistencia": (context) => const ListAssistanceStudent(),
        "/registrarse": (context) => const Regristrase()
      },
    );
  }
}
