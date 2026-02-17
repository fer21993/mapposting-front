import 'package:flutter/material.dart';
import 'package:flutter_front/utils/global.colors.dart';

class ProfessorDetailView extends StatelessWidget {
  final String professorName;
  final String subject;
  final String office;
  final String building;

  const ProfessorDetailView({
    Key? key,
    required this.professorName,
    required this.subject,
    required this.office,
    required this.building,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Traer del backend
    final horarios = [
      {'dia': 'Lunes', 'hora': '08:00 - 10:00'},
      {'dia': 'Lunes', 'hora': '14:00 - 16:00'},
      {'dia': 'Miércoles', 'hora': '08:00 - 10:00'},
      {'dia': 'Viernes', 'hora': '10:00 - 12:00'},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: GlobalColors.textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Información del Profesor',
          style: TextStyle(
            color: GlobalColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header con foto
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              color: GlobalColors.mainColor.withOpacity(0.1),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: GlobalColors.mainColor.withOpacity(0.3),
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: GlobalColors.mainColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    professorName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subject,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ubicación
                  const Text(
                    'Ubicación',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(Icons.business, 'Edificio', building),
                  const SizedBox(height: 12),
                  _buildInfoRow(Icons.door_front_door, 'Cubículo', office),

                  const SizedBox(height: 30),

                  // Horarios de atención
                  Row(
                    children: [
                      const Text(
                        'Horarios de atención',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.schedule, color: GlobalColors.mainColor),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Lista de horarios
                  ...horarios.map((horario) => Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 40,
                              decoration: BoxDecoration(
                                color: GlobalColors.mainColor,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    horario['dia']!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    horario['hora']!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),

                  const SizedBox(height: 30),

                  // Botón de contacto
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Enviar mensaje o email
                      },
                      icon: const Icon(Icons.email, color: Colors.white),
                      label: const Text(
                        'Enviar mensaje',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: GlobalColors.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Botón de ver en mapa
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // TODO: Ver ubicación en mapa
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      icon: Icon(Icons.map, color: GlobalColors.mainColor),
                      label: Text(
                        'Ver en mapa',
                        style: TextStyle(
                          color: GlobalColors.mainColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: GlobalColors.mainColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: GlobalColors.mainColor, size: 24),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
