import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:maestros/peticiones/peticionesUsers.dart';

import '../models/users.dart';

class UsersController extends GetxController {
  final Rxn<List<Users>> _usersFirebase = Rxn<List<Users>>();
  late RxString mensaje = "".obs;
  User? user;

  Future<void> consultarUsuario() async {
    user = FirebaseAuth.instance.currentUser;
  }

  Future<void> crearUsuario(String email, String pass) async {
    mensaje.value = await PeticionesUser.createUser(email, pass);
  }

  Future<bool> iniciarSesion(String email, String pass) async {
    try {
      UserCredential userCredential =
          await PeticionesUser.iniciarSesion(email, pass);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password") {
        mensajeDeError("Contraseña incorrecta");
      }

      if (e.code == "user-not-found") {
        mensajeDeError("Usuario no registrado");
      }

      if (e.code == "network-request-failed") {
        mensajeDeError("Sin conexion a internet");
      }

      return false;
    }
  }

  void cerrarSesion() async {
    PeticionesUser.cerrarSesion();
  }

  void mensajeDeError(String mensaje) {
    Get.snackbar('error', mensaje, duration: const Duration(seconds: 5));
  }
}
