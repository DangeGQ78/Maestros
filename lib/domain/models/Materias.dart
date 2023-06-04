import 'grupos.dart';

class Materia {
  final String nombre;
  final Map<int, Grupo> grupos;

  Materia({
    required this.nombre,
    required this.grupos,
  });

  factory Materia.fromJson(Map<String, dynamic> json) {
    Map<int, Grupo> grupos = {};
    for (Map<String, dynamic> grupoJson in json['grupos']) {
      Grupo grupo = Grupo.fromJson(grupoJson);
      grupos[grupoJson['id']] = grupo;
    }
    return Materia(
      nombre: json['nombre'],
      grupos: grupos,
    );
  }
}
