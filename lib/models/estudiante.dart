// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Estudiante {
  final String nombre;
  final bool asiste;
  final double calificacion;
  const Estudiante({
    required this.nombre,
    this.asiste = false,
     this.calificacion=0,
  });

  Estudiante copyWith({
    String? nombre,
    bool? asiste,
    double? calificacion,
  }) {
    return Estudiante(
      nombre: nombre ?? this.nombre,
      asiste: asiste ?? this.asiste,
      calificacion: calificacion ?? this.calificacion,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nombre': nombre,
      'asiste': asiste,
      'calificacion': calificacion,
    };
  }

  factory Estudiante.fromMap(Map<String, dynamic> map) {
    return Estudiante(
      nombre: map['nombre'] as String,
      asiste: map['asiste'] as bool,
      calificacion: map['calificacion'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Estudiante.fromJson(String source) => Estudiante.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Estudiante(nombre: $nombre, asiste: $asiste, calificacion: $calificacion)';

  @override
  bool operator ==(covariant Estudiante other) {
    if (identical(this, other)) return true;
  
    return 
      other.nombre == nombre &&
      other.asiste == asiste &&
      other.calificacion == calificacion;
  }

  @override
  int get hashCode => nombre.hashCode ^ asiste.hashCode ^ calificacion.hashCode;
}
