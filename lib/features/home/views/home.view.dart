import 'package:flutter/material.dart';
import 'package:flutter_front/utils/global.colors.dart';
import 'package:flutter_front/widgets/app_drawer.dart';
import 'package:flutter_front/features/map/views/map.view.dart';
import 'package:flutter_front/features/events/views/calendar.view.dart';
import 'package:flutter_front/features/profile/views/profile.view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const MapView(),
    const CalendarView(),
    const ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        // ✅ Notificaciones a la IZQUIERDA
        leading: IconButton(
          icon: Icon(
            Icons.notifications_outlined,
            color: GlobalColors.textColor,
          ),
          onPressed: () {
            print('TODO: Notificaciones');
          },
        ),
        title: Text(
          'MAPPOSTING',
          style: TextStyle(
            color: GlobalColors.mainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        // ✅ Menú hamburguesa a la DERECHA
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu, color: GlobalColors.textColor),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: const AppDrawer(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: GlobalColors.mainColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Eventos',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
