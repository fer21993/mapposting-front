import 'package:flutter/material.dart';
import 'package:flutter_front/utils/global.colors.dart';
import 'package:flutter_front/view/event.detail.view.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Esto vendrá del backend
    final eventos = [
      {
        'nombre': 'Edificio K',
        'dias': 'Lunes',
        'horario': '04:00 pm - 08:30 p.m.',
      },
      {
        'nombre': 'Edificio C',
        'dias': 'Lunes, Miercoles',
        'horario': '06:00 pm - 09:00 p.m.',
      },
      {
        'nombre': 'Auditorio',
        'dias': 'Lunes, Miercoles, Viernes',
        'horario': '04:00 pm - 08:30 p.m.',
      },
      {
        'nombre': 'PIDET',
        'dias': 'Viernes',
        'horario': '06:00 pm - 07:00 p.m.',
      },
    ];

    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Row(
            children: [
              const Text(
                'Edificios con eventos',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  // Volver al mapa
                },
              ),
            ],
          ),
        ),

        // Lista de eventos
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: eventos.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final evento = eventos[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                title: Text(
                  evento['nombre']!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      evento['dias']!,
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      'Horario: ${evento['horario']}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: GlobalColors.mainColor,
                  size: 20,
                ),
                onTap: () {
                  // ✅ Navegar a detalles del evento
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailView(
                        eventName: evento['nombre']!,
                        days: evento['dias']!,
                        schedule: evento['horario']!,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),

        // Footer
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.grey[100],
          child: Text(
            'Los horarios pueden sufrir cambios sin previo aviso',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }
}