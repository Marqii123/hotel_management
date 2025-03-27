import 'package:flutter/material.dart';
import 'blank_page.dart';
import 'home_content.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isExpanded = false;
  int selectedIndex = 0;
  int hoveredIndex = -1;

  //  List<dynamic> bookings = [];

  List<Map<String, dynamic>> menuItems = [
    {"icon": Icons.home, "text": "Home"},
    {"icon": Icons.book, "text": "Booking"},
    {"icon": Icons.hotel, "text": "Rooms"},
    {"icon": Icons.people, "text": "Guests"},
    {"icon": Icons.person, "text": "Staff"},
    {"icon": Icons.settings, "text": "Settings"},
  ];


  void _onMenuItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: isExpanded ? 200 : 60,
            color: Colors.blue,
            child: Column(
              children: [
                IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                ),
              
                ...List.generate(menuItems.length, (index){
                  return MouseRegion(
                    onEnter: (_) => setState(() => hoveredIndex = index),
                    onExit: (_) => setState(() => hoveredIndex = -1),
                    child: GestureDetector(
                      onTap: () => _onMenuItemTapped(index),
                      child: Container(
                        color: selectedIndex == index
                        ? Colors.white.withOpacity(0.2)
                        : hoveredIndex == index
                          ? Colors.white.withOpacity(0.1)
                          :Colors.transparent,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isExpanded ? 16 : 0,
                            vertical: 12
                          ),
                          child: Row(
                            mainAxisAlignment: isExpanded ? MainAxisAlignment.start : MainAxisAlignment.center,
                            children: [
                              Padding(
                                 padding: EdgeInsets.only(left: isExpanded ? 16 : 0), //add margin when expanded
                                child: Icon(
                                  menuItems[index]["icon"], 
                                  color: Colors.white, 
                                  size: 24
                                ),
                              ),
                              if (isExpanded) ...[
                                SizedBox(width: 16), // Space between icon and text
                                Text(
                                  menuItems[index]["text"],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
                )
              ],
            
            ),
          ),

          //table recent booking
          Expanded(
            child: selectedIndex == 0 ? HomeContent() : BlankPage(menuItems[selectedIndex]["text"]),
          ),
        ],
      ),
    );
  }
}