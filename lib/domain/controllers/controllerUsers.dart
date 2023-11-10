import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:maestros/domain/controllers/login_controller.dart';
import 'package:maestros/peticiones/peticionesUsers.dart';

import '../models/users.dart';

class UsersController extends GetxController {
  final Rxn<List<Users>> _usersFirebase = Rxn<List<Users>>();
  late RxString mensaje = "".obs;
  static LoginController loginController = Get.find();
  User? user;

  Future<void> consultarUsuario() async {
    user = FirebaseAuth.instance.currentUser;
  }

  Future<bool> crearUsuario(String email, String pass) async {
    try {
      mensaje.value = await PeticionesUser.createUser(email, pass);
      return true;
    } catch (e) {
      mensaje.value = "Error al registrarse";
      return false;
    }
  }

  Future<bool> iniciarSesion(String email, String pass) async {
    if (politicasDeSeguridad(email, pass)) {
      try {
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
      }
    }
    return false;
  }

  void cerrarSesion() async {
    PeticionesUser.cerrarSesion();
  }

  void mensajeDeError(String mensaje) {
    Get.snackbar('error', mensaje, duration: const Duration(seconds: 3));
  }

  bool politicasDeSeguridad(String email, String pass) {
    if (email.isEmpty && pass.isEmpty) {
      mensajeDeError("llenar los campos");
      return false;
    } else if (pass.isEmpty) {
      mensajeDeError("coloque su contraseña");
      return false;
    } else if (pass.length > 15) {
      mensajeDeError("contraseña demasiado larga(max 15)");
      return false;
    } else if (pass.length < 6) {
      mensajeDeError("contraseña invalida");
      return false;
    } else {
      return true;
    }
  }
}
