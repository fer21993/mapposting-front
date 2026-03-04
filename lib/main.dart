import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_front/features/auth/views/splash.view.dart';
import 'package:flutter_front/features/auth/controllers/auth_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MAPPOSTING',
      initialBinding: BindingsBuilder(() {
        // Inicializar controladores al inicio
        Get.put(AuthController());
      }),
      home: const SplashView(),
    );
  }
}
