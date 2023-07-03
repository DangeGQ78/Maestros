import 'package:get/get.dart';
import 'package:maestros/domain/models/estudiante.dart';

class Asistencia {
  Estudiante e;
  bool asistio = false;
  bool excusa = false;
  Asistencia({required this.e, required this.asistio, required this.excusa});
}
