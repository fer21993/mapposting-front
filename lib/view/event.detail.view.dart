import 'package:flutter/material.dart';
import 'package:flutter_front/utils/global.colors.dart';
import 'package:flutter_front/view/event.confirmation.view.dart';

class EventDetailView extends StatelessWidget {
  final String eventName;
  final String days;
  final String schedule;

  const EventDetailView({
    Key? key,
    required this.eventName,
    required this.days,
    required this.schedule,
  }) : super(key: key);

  // ✅ Generar código único de confirmación
  String _generateConfirmationCode() {
    // TODO: En producción, esto vendría del backend
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'EVT-${eventName.substring(0, 3).toUpperCase()}-$timestamp';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: GlobalColors.textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          eventName,
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
            // Imagen del evento (placeholder)
            Container(
              width: double.infinity,
              height: 200,
              color: GlobalColors.mainColor.withOpacity(0.2),
              child: Icon(
                Icons.event,
                size: 80,
                color: GlobalColors.mainColor,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nombre del evento
                  Text(
                    eventName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Días
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: GlobalColors.mainColor),
                      const SizedBox(width: 12),
                      Text(
                        days,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Horario
                  Row(
                    children: [
                      Icon(Icons.access_time, color: GlobalColors.mainColor),
                      const SizedBox(width: 12),
                      Text(
                        schedule,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Ubicación
                  Row(
                    children: [
                      Icon(Icons.location_on, color: GlobalColors.mainColor),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'UTEQ - Universidad Tecnológica de Querétaro',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Descripción
                  const Text(
                    'Descripción',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Evento de programa educativo embajadores. Los estudiantes podrán participar en diversas actividades académicas y culturales.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Botón de registrarse
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // ✅ Generar código y navegar a confirmación
                        final confirmationCode = _generateConfirmationCode();
                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventConfirmationView(
                              eventName: eventName,
                              days: days,
                              schedule: schedule,
                              confirmationCode: confirmationCode,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: GlobalColors.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Registrarme al evento',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Botón de ver en mapa
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: GlobalColors.mainColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Ver en mapa',
                        style: TextStyle(
                          color: GlobalColors.mainColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
}
