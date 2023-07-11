import 'package:camera/camera.dart';
import 'package:cursos_fisei_asistencia/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './color_schemes.g.dart';

	   late List<CameraDescription> cameras;
void main() async{
	 WidgetsFlutterBinding.ensureInitialized();
	 cameras = await availableCameras();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      themeMode: ThemeMode.light,
      routerConfig: ref.read(routerProvider),
    );
  }
}
