import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maestros/domain/controllers/controllerUsers.dart';
import 'package:maestros/domain/models/Materias.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:maestros/domain/controllers/controllerMaterias.dart';
import '../models/dias.dart';

class HorarioController extends GetxController {
  final RxList<Appointment> listaClases = RxList<Appointment>([]);
  final MateriasController materiac = Get.find();
  final UsersController userc = Get.find();

  void cargarClases() {
    if (materiac.MateriaFirebase.isEmpty) {
      materiac.consultarGrupos(userc.user!.email).then((value) {
        cargarEventos();
      });
    } else {
      cargarEventos();
    }
  }

  void cargarEventos() {
    DateTime diaActual;
    for (Grupo materia in materiac.MateriaFirebase) {
      for (var e in materia.dias) {
        diaActual = determinarfechaInicial(e.nombre);
        RecurrenceProperties recurrence =
            RecurrenceProperties(startDate: diaActual);
        recurrence.recurrenceType = RecurrenceType.daily;
        recurrence.interval = 7;
        Appointment appointment = Appointment(
            color: getRandomColor(),
            subject: materia.nombre,
            startTime: DateTime(diaActual.year, diaActual.month, diaActual.day,
                e.horaInicio.hour, e.horaInicio.minute),
            endTime: DateTime(diaActual.year, diaActual.month, diaActual.day,
                    e.horaInicio.hour, e.horaInicio.minute)
                .add(Duration(
                    hours: restarHora(e.horaInicio.hour, e.horaFin.hour))),
            recurrenceRule: SfCalendar.generateRRule(recurrence, DateTime.now(),
                DateTime.now().add(const Duration(hours: 2))));
        listaClases.add(appointment);
      }
    }
  }

  int restarHora(int hi, int hf) => hf - hi;

  DateTime determinarfechaInicial(String dia) {
    if (dia == "lunes") {
      return DateTime(2023, 1, 2);
    }

    if (dia == "martes") {
      return DateTime(2023, 1, 3);
    }

    if (dia == "miercoles") {
      return DateTime(2023, 1, 4);
    }

    if (dia == "jueves") {
      return DateTime(2023, 1, 5);
    }

    if (dia == "viernes") {
      return DateTime(2023, 1, 6);
    }

    if (dia == "sabado") {
      return DateTime(2023, 1, 7);
    }
    return DateTime(2023, 1, 2);
  }
}

Color getRandomColor() {
  Random random = Random();
  int r = random.nextInt(256);
  int g = random.nextInt(256);
  int b = random.nextInt(256);
  return Color.fromARGB(255, r, g, b);
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}
