import 'package:cursos_fisei_asistencia/screens/camera.dart';
import 'package:cursos_fisei_asistencia/screens/curso_details_screen.dart';
import 'package:cursos_fisei_asistencia/screens/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import './screens/login.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'cursos/:id',
            name: 'curso',
            builder: (context, state) => CursoDetails(int.parse(state.params['id']!)),
            routes: [
              GoRoute(
                path: 'camera',
                name: 'camera',
                builder: (context, state) => const CameraScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const Login(),
      ),
    ],
  );
});
