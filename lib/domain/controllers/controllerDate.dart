import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maestros/domain/controllers/controllerMaterias.dart';
import 'package:maestros/domain/models/dias.dart';

class DateController extends GetxController {
  final MateriasController materiac = Get.find();
  final Rx<TimeOfDay> hora = Rx(const TimeOfDay(hour: 00, minute: 00));
  RxList<Dia> dias = <Dia>[].obs;
  RxList<Dia> dias2 = <Dia>[].obs;
  void cargarDias() {
    dias.add(Dia(
        nombre: "Lunes",
        horaInicio: const TimeOfDay(hour: 0, minute: 0),
        horaFin: const TimeOfDay(hour: 0, minute: 0)));
  }

  void cargarDias2() {
    dias2.add(Dia(
        nombre: "Lunes",
        horaInicio: const TimeOfDay(hour: 0, minute: 0),
        horaFin: const TimeOfDay(hour: 0, minute: 0)));
  }

  void cargarDiasEdit(int i) {
    dias2.value = materiac.MateriaFirebase[i].dias;
  }

  void eliminar(i) {
    dias.removeAt(i);
  }

  void eliminar2(i) {
    dias2.removeAt(i);
  }

  void setHoraInicio(int index, TimeOfDay t) {
    dias[index].horaInicio = t;
  }

  void setHoraInicio2(int index, TimeOfDay t) {
    dias2[index].horaInicio = t;
  }

  void setHorafin(int index, TimeOfDay t) {
    dias[index].horaFin = t;
  }

  void setHorafin2(int index, TimeOfDay t) {
    dias2[index].horaFin = t;
  }

  void setDia(int index, String diaSemana) {
    dias[index].nombre = diaSemana;
    dias.refresh();
  }

  void setDia2(int index, String diaSemana) {
    dias2[index].nombre = diaSemana;
    dias2.refresh();
  }
}
