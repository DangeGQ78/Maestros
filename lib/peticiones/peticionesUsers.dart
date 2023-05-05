import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;

class PeticionesUser {
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<String> createUser(String email, String pass) async {
    try {
      final Credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);

      return "resgistro exitoso";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-passwork') {
        return ("the password provides is too weak");
      } else if (e.code == 'email-already-in-use') {
        return ("the account already exits for that email");
      }
    } catch (e) {
      return ("${e}");
    }

    return "no paso nada";
  }

  static Future<UserCredential> iniciarSesion(String email, String pass) async {
    FirebaseAuth credential = FirebaseAuth.instance;
    return await credential.signInWithEmailAndPassword(
        email: email, password: pass);
  }

  static Future<void> consultarUsuario() async {}

  static Future<void> consultarListaUsuarios() async {}
}
