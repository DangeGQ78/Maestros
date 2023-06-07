import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maestros/domain/models/dias.dart';

class DateController extends GetxController {
  final Rx<TimeOfDay> hora = Rx(const TimeOfDay(hour: 00, minute: 00));
  RxList<Dia> dias = <Dia>[].obs;
  void cargarDias() {
    dias.add(Dia(
        nombre: "Lunes",
        horaInicio: const TimeOfDay(hour: 0, minute: 0),
        horaFin: const TimeOfDay(hour: 0, minute: 0)));
  }

  void eliminar(i) {
    dias.removeAt(i);
  }

  void setHoraInicio(int index, TimeOfDay t) {
    dias[index].horaInicio = t;
  }

  void setHorafin(int index, TimeOfDay t) {
    dias[index].horaFin = t;
  }

  void setDia(int index, String diaSemana) {
    dias[index].nombre = diaSemana;
    dias.refresh();
  }
}
