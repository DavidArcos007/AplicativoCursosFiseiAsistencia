import 'package:cursos_fisei_asistencia/data/estudiantes_data.dart';
import 'package:cursos_fisei_asistencia/models/estudiante.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final estudiantesControllerProvider = StateNotifierProvider.family<EstudiantesControllerNotifier, List<Estudiante>,int>((ref,index) {
  return EstudiantesControllerNotifier(estudiantes);
});

class EstudiantesControllerNotifier extends StateNotifier<List<Estudiante>> {
  EstudiantesControllerNotifier(super.state);
	cambiarAsistencia(int index) {
		state = [
			for (int i = 0; i < state.length; i++)
				if (i == index) state[i].copyWith(asiste: !state[i].asiste) else state[i]
		];
	}
	cambiarCalificacion(int index, double calificacion){
		state = [
			for (int i = 0; i < state.length; i++)
				if (i == index) state[i].copyWith(calificacion:calificacion) else state[i]
		];
	}
}

class EstudiantesState {}
