import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../controllers/cursos_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final cursosState = ref.watch(cursosControllerProvider);
    final cursos = cursosState.cursosFiltrados;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                ref.read(cursosControllerProvider.notifier).setFilter(value);
              },
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.search),
                hintText: 'Buscar',
              ),
            ),
            const SizedBox.square(dimension: 20),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(height: 1, thickness: 1),
                padding: const EdgeInsets.all(16),
                itemCount: cursos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Hero(
                      tag: '$index',
                      child: Image.asset(
                        cursos[index].imagen,
                        fit: BoxFit.cover,
                        height: 150,
                        width: 80,
                      ),
                    ),
                    title: Text(
                      cursos[index].titulo,
                      style: textTheme.titleMedium!.copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      cursos[index].descripcion,
                      softWrap: false,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    isThreeLine: true,
                    onTap: () {
											context.goNamed( 'curso', params: {'id': '$index'});
										},
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
