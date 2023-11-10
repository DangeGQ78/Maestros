import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:mockito/mockito.dart';
import 'package:maestros/domain/controllers/controllerUsers.dart';

class MockPeticionesUser extends Mock implements UsersController {}

void main() {
  test("prueba", () async {
    final usercontroller = UsersController();

    var resultado = usercontroller.iniciarSesion("1212", "asdad");
    expect(resultado, true);
  });
}
