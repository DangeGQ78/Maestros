import 'package:flutter/material.dart';
import 'package:maestros/ui/pages/utils/drawer.dart';

class View_Materias extends StatelessWidget {
  const View_Materias({super.key});
  static Color miColor = const Color.fromRGBO(0, 191, 99, 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Materias"),
        backgroundColor: miColor,
      ),
    );
  }
}
