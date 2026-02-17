import 'package:flutter/material.dart';
import 'package:flutter_front/utils/global.colors.dart';
import 'package:flutter_front/view/search.professor.view.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: GlobalColors.mainColor,
            ),
            child: const Text(
              'MAPPOSTING',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
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
                MaterialPageRoute(builder: (context) => const SearchProfessorView()),
              );
            },
          ),
          
          const Divider(),
          
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Cerrar sesión',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              Navigator.pop(context);
              // TODO: Logout
            },
          ),
        ],
      ),
    );
  }
}