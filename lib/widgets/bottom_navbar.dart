import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:livekirtanapp/screens/darbar_sahib_kirtan_player.dart';
import 'package:livekirtanapp/screens/kirtan_tiles.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of screens
  final List<Widget> _screens = [
   KirtanListScreen(),   // Your HomeScreen
    // const ExploreScreen(), // Your ExploreScreen
    // const ProfileScreen(), // Your ProfileScreen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],  // Display the selected screen
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const CustomBottomNavBar({super.key, required this.currentIndex, this.onTap});

  @override
  CustomBottomNavBarState createState() => CustomBottomNavBarState();
}

class CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      backgroundColor: Colors.white,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      items: [
        BottomNavigationBarItem(
          icon: Container(
            width: 60.0,
            decoration: BoxDecoration(
              color: widget.currentIndex == 0 ? Colors.orange.shade500 : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'assets/images/guide.svg',  // Replace with your SVG asset path
                width: 30.0,
                height: 30.0,
                color: widget.currentIndex == 0 ? Colors.white : Colors.black,
              ),
            ),
          ),
          label: 'Live',
        ),
        BottomNavigationBarItem(
          icon: Container(
            width: 60.0,
            decoration: BoxDecoration(
              color: widget.currentIndex == 1 ? Colors.orange.shade500 : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'assets/images/space_dashboard.svg',  // Replace with your SVG asset path
                width: 30.0,
                height: 30.0,
                color: widget.currentIndex == 1 ? Colors.white : Colors.black,
              ),
            ),
          ),
          label: 'Recordings',
        ),
        BottomNavigationBarItem(
          icon: Container(
            width: 60.0,
            decoration: BoxDecoration(
              color: widget.currentIndex == 2 ? Colors.orange.shade500 : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'assets/images/account_box.svg',  // Replace with your SVG asset path
                width: 30.0,
                height: 30.0,
                color: widget.currentIndex == 2 ? Colors.white : Colors.black,
              ),
            ),
          ),
          label: 'Path Audio',
        ),
      ],
    );
  }
}