import 'package:get/get.dart';
import 'package:maestros/domain/controllers/controllerHorario.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';

class ViewHorario extends StatelessWidget {
  ViewHorario({super.key});
  final HorarioController horarioc = Get.find();
  @override
  Widget build(BuildContext context) {
    horarioc.cargarClases();
    /*
    List<Appointment> lista = [];

    RecurrenceProperties recurrence =
        RecurrenceProperties(startDate: DateTime.now());
    recurrence.recurrenceType = RecurrenceType.daily;
    recurrence.interval = 7;
    Appointment appointment = Appointment(
        subject: "ingles 01",
        startTime: DateTime.now(),
        endTime: DateTime.now().add(const Duration(hours: 2)),
        recurrenceRule: SfCalendar.generateRRule(recurrence, DateTime.now(),
            DateTime.now().add(const Duration(hours: 2))));
    Appointment appointment2 = Appointment(
        subject: "ingles 02",
        startTime: DateTime.now(),
        endTime: DateTime.now().add(const Duration(hours: 2)),
        recurrenceRule: SfCalendar.generateRRule(recurrence, DateTime.now(),
            DateTime.now().add(const Duration(hours: 2))));
    lista.add(appointment2);
    lista.add(appointment);
   */

    return Scaffold(
        appBar: AppBar(
          title: const Text("horario de claes"),
        ),
        body: Obx(() => SfCalendar(
              firstDayOfWeek: 1,
              view: CalendarView.week,
              dataSource: DataSource(horarioc.listaClases.value),
              timeSlotViewSettings: const TimeSlotViewSettings(
                startHour: 5,
                endHour: 23,
                nonWorkingDays: <int>[DateTime.sunday],
              ),
            )));
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}
