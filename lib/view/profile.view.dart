import 'package:flutter/material.dart';
import 'package:flutter_front/utils/global.colors.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: GlobalColors.mainColor.withOpacity(0.2),
            child: Icon(Icons.person, size: 60, color: GlobalColors.mainColor),
          ),
          const SizedBox(height: 20),
          const Text(
            'Administrador',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'admin@uteq.edu.mx',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'Perfil de usuario',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}