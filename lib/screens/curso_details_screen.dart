import 'package:cursos_fisei_asistencia/controllers/estudiantes_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../controllers/cursos_controller.dart';

class CursoDetails extends ConsumerWidget {
  const CursoDetails(this.index, {super.key});
  final int index;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final cursosState = ref.watch(cursosControllerProvider);
    final estudiantesState = ref.watch(estudiantesControllerProvider(index));
    final cursos = cursosState.cursos;
    final estudiantes = estudiantesState;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Text(
          cursos[index].titulo,
          style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold, color: colorScheme.primary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: '$index',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    cursos[index].imagen,
                    fit: BoxFit.cover,
                    height: 120,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                cursos[index].descripcion,
                style: textTheme.bodyLarge!.copyWith(color: colorScheme.primary),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 80,
                child: ListView(
                  primary: false, scrollDirection: Axis.horizontal,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(cursos[index].tutor,
                                style: textTheme.headlineSmall!
                                    .copyWith(fontWeight: FontWeight.bold, color: colorScheme.secondary)),
                            const Text(
                              'Tutor',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(cursos[index].precio.toString(),
                                style: textTheme.headlineSmall!
                                    .copyWith(fontWeight: FontWeight.bold, color: colorScheme.secondary)),
                            const Text(
                              'Precio',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(cursos[index].duracion.toInt().toString(),
                                style: textTheme.headlineSmall!
                                    .copyWith(fontWeight: FontWeight.bold, color: colorScheme.secondary)),
                            const Text(
                              'Horas',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: colorScheme.onPrimary,
                      child: InkWell(
                        onTap: () => context.goNamed('camera', params: {'id': '$index'}),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.camera_alt,
                            size: 40,
                            color: colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const TabBar(
                tabs: [
                  Tab(text: 'Asistencia'),
                  Tab(text: 'Calificaciones'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ListView.builder(
                      itemBuilder: (context, i) => CheckboxListTile(
                        title: Text(estudiantes[i].nombre),
                        value: estudiantes[i].asiste,
                        onChanged: (value) {
                          ref.read(estudiantesControllerProvider(index).notifier).cambiarAsistencia(i);
                        },
                      ),
                      itemCount: estudiantes.length,
                    ),
                    ListView.builder(
                      itemBuilder: (context, i) => ListTile(
                        title: Text(estudiantes[i].nombre),
                        trailing: SizedBox(
                          width: 75,
                          child: TextFormField(
                            initialValue: estudiantes[i].calificacion.toString(),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                            ],
                            onChanged: (value) {
                              if (double.tryParse(value) != null) {
                                ref
                                    .read(estudiantesControllerProvider(index).notifier)
                                    .cambiarCalificacion(i, double.parse(value));
                              }
                            },
                          ),
                        ),
                      ),
                      itemCount: estudiantes.length,
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Text('headlineLarge', style: textTheme.headlineLarge),
          // Text('headlineMedium', style: textTheme.headlineMedium),
          // Text('headlineSmall', style: textTheme.headlineSmall),
          // Text('labelLarge', style: textTheme.labelLarge),
          // Text('labelMedium', style: textTheme.labelMedium),
          // Text('labelSmall', style: textTheme.labelSmall),
          // Text('bodyLarge', style: textTheme.bodyLarge),
          // Text('bodyMedium', style: textTheme.bodyMedium),
          // Text('bodySmall', style: textTheme.bodySmall),
          // Text('titleLarge', style: textTheme.titleLarge),
          // Text('titleMedium', style: textTheme.titleMedium),
          // Text('titleSmall', style: textTheme.titleSmall),
          // Text('displayLarge', style: textTheme.displayLarge),
          // Text('displayMedium', style: textTheme.displayMedium),
          // Text('displaySmall', style: textTheme.displaySmall),
        ),
      ),
    );
  }
}
