import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

class ViewHorario extends StatelessWidget {
  const ViewHorario({super.key});

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
        controller: EventController(),
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Calendario'),
            ),
            body: WeekView(
              weekDayStringBuilder: (p0) {
                var dias = ["lun", "mar", "mie", "jue", "vie", "sab", "dom"];
                return dias[p0];
              },
            )));
  }
}
