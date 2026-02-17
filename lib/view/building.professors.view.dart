import 'package:flutter/material.dart';
import 'package:flutter_front/utils/global.colors.dart';
import 'package:flutter_front/view/professor.detail.view.dart';

class BuildingProfessorsView extends StatefulWidget {
  final String buildingName;

  const BuildingProfessorsView({
    Key? key,
    required this.buildingName,
  }) : super(key: key);

  @override
  State<BuildingProfessorsView> createState() => _BuildingProfessorsViewState();
}

class _BuildingProfessorsViewState extends State<BuildingProfessorsView> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredProfessors = [];

  // TODO: Traer del backend según edificio
  final List<Map<String, String>> _professors = [
    {
      'nombre': 'Dr. Juan Pérez García',
      'materia': 'Matemáticas Avanzadas',
      'cubiculo': '101-A',
    },
    {
      'nombre': 'Ing. María Rodríguez López',
      'materia': 'Programación Web',
      'cubiculo': '102-B',
    },
    {
      'nombre': 'Lic. Carlos Hernández',
      'materia': 'Administración de Proyectos',
      'cubiculo': '103-C',
    },
    {
      'nombre': 'Dra. Ana Martínez Silva',
      'materia': 'Física Cuántica',
      'cubiculo': '104-A',
    },
    {
      'nombre': 'Mtro. Luis González',
      'materia': 'Base de Datos',
      'cubiculo': '105-B',
    },
  ];

  @override
  void initState() {
    super.initState();
    _filteredProfessors = _professors;
    _searchController.addListener(_filterProfessors);
  }

  void _filterProfessors() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProfessors = _professors
          .where((prof) =>
              prof['nombre']!.toLowerCase().contains(query) ||
              prof['materia']!.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
          widget.buildingName,
          style: TextStyle(
            color: GlobalColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // Buscador
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar profesor o materia...',
                prefixIcon: Icon(Icons.search, color: GlobalColors.mainColor),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(15),
              ),
            ),
          ),

          // Título
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text(
                  'Profesores',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '${_filteredProfessors.length} profesores',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Lista de profesores
          Expanded(
            child: _filteredProfessors.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_search, size: 60, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'No se encontraron profesores',
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredProfessors.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final professor = _filteredProfessors[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        leading: CircleAvatar(
                          radius: 28,
                          backgroundColor: GlobalColors.mainColor.withOpacity(0.2),
                          child: Icon(
                            Icons.person,
                            color: GlobalColors.mainColor,
                            size: 30,
                          ),
                        ),
                        title: Text(
                          professor['nombre']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              professor['materia']!,
                              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Icon(Icons.door_front_door, size: 14, color: Colors.grey[600]),
                                const SizedBox(width: 4),
                                Text(
                                  'Cubículo ${professor['cubiculo']}',
                                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: GlobalColors.mainColor,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfessorDetailView(
                                professorName: professor['nombre']!,
                                subject: professor['materia']!,
                                office: professor['cubiculo']!,
                                building: widget.buildingName,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}