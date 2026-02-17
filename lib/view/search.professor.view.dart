import 'package:flutter/material.dart';
import 'package:flutter_front/utils/global.colors.dart';
import 'package:flutter_front/view/login.view.dart';
import 'package:flutter_front/view/register.view.dart';
import 'package:flutter_front/view/building.professors.view.dart';

class SearchProfessorView extends StatefulWidget {
  const SearchProfessorView({Key? key}) : super(key: key);

  @override
  State<SearchProfessorView> createState() => _SearchProfessorViewState();
}

class _SearchProfessorViewState extends State<SearchProfessorView> {
  bool isLoggedIn = true; // TODO: Verificar sesión real desde backend
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredBuildings = [];

  // TODO: Traer del backend
  final List<Map<String, String>> _buildings = [
    {'nombre': 'Edificio A', 'profesores': '12'},
    {'nombre': 'Edificio B', 'profesores': '8'},
    {'nombre': 'Edificio C', 'profesores': '15'},
    {'nombre': 'Edificio K', 'profesores': '10'},
    {'nombre': 'Auditorio', 'profesores': '5'},
    {'nombre': 'PIDET', 'profesores': '7'},
    {'nombre': 'Biblioteca', 'profesores': '4'},
  ];

  @override
  void initState() {
    super.initState();
    _filteredBuildings = _buildings;
    _searchController.addListener(_filterBuildings);
  }

  void _filterBuildings() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredBuildings = _buildings
          .where((building) => building['nombre']!.toLowerCase().contains(query))
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
          'Buscar Profesor',
          style: TextStyle(
            color: GlobalColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoggedIn ? _buildBuildingsList() : _buildLoginRequired(),
    );
  }

  Widget _buildLoginRequired() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_outline,
              size: 100,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 30),
            const Text(
              'Inicia sesión para continuar',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Text(
              'Por seguridad, solo usuarios con cuenta institucional pueden acceder a la información de profesores',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalColors.mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Iniciar sesión',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '¿No tienes cuenta? ',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterView()),
                    );
                  },
                  child: Text(
                    'Regístrate',
                    style: TextStyle(
                      color: GlobalColors.mainColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBuildingsList() {
    return Column(
      children: [
        // Buscador
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Buscar edificio...',
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
                'Edificios',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                '${_filteredBuildings.length} edificios',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Lista de edificios
        Expanded(
          child: _filteredBuildings.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 60, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'No se encontraron edificios',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _filteredBuildings.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final building = _filteredBuildings[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: GlobalColors.mainColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.business,
                          color: GlobalColors.mainColor,
                          size: 28,
                        ),
                      ),
                      title: Text(
                        building['nombre']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${building['profesores']} profesores',
                        style: TextStyle(color: Colors.grey[600]),
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
                            builder: (context) => BuildingProfessorsView(
                              buildingName: building['nombre']!,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}