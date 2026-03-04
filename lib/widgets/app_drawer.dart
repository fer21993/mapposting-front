import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_front/utils/global.colors.dart';
import 'package:flutter_front/features/professors/views/search.professor.view.dart';
import 'package:flutter_front/features/auth/controllers/auth_controller.dart';
import 'package:flutter_front/features/auth/views/login.view.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: GlobalColors.mainColor),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'MAPPOSTING',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (authController.isLoggedIn.value)
                    Text(
                      authController.user.value?['email'] ?? 'Usuario',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    )
                  else
                    const Text(
                      'Sin sesión iniciada',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Buscar profesores'),
            onTap: () {
              Navigator.pop(context); // Cerrar drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchProfessorView(),
                ),
              );
            },
          ),
          const Divider(),

          // Mostrar login o logout según el estado
          Obx(() {
            if (authController.isLoggedIn.value) {
              return ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  'Cerrar sesión',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  authController.logout();
                },
              );
            } else {
              return ListTile(
                leading: Icon(Icons.login, color: GlobalColors.mainColor),
                title: Text(
                  'Iniciar sesión',
                  style: TextStyle(color: GlobalColors.mainColor),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                  );
                },
              );
            }
          }),
        ],
      ),
    );
  }
}
