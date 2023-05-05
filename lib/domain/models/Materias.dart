class Materia {
  final String nombre;
  final Map<String, Map<String, String>> grupos;

  Materia({
    required this.nombre,
    required this.grupos,
  });

  factory Materia.fromMap(Map<String, dynamic> map) {
    return Materia(
      nombre: map['nombre'] ?? '',
      grupos: Map<String, Map<String, String>>.from(map['grupos'] ?? {}),
    );
  }
}
