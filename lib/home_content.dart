import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  List<dynamic> bookings = [];
  List<dynamic> filteredBookings = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadBookings();
    searchController.addListener(_filterBookings);
  }

  Future<void> _loadBookings() async {
    final String response = await rootBundle.loadString('assets/bookings.json');
    setState(() {
      bookings = json.decode(response);
      filteredBookings = bookings;
    });
  }

  void _filterBookings() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredBookings = bookings.where((booking) {
        return booking["name"].toLowerCase().contains(query) ||
               booking["room"].toLowerCase().contains(query) ||
               booking["status"].toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 800;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Summary Cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: _buildInfoCard("Total Bookings", Colors.blue)),
                    SizedBox(width: 10),
                    Expanded(child: _buildInfoCard("Available Rooms", Colors.green)),
                    SizedBox(width: 10),
                    Expanded(child: _buildInfoCard("Pending Check-ins", Colors.orange)),
                  ],
                ),

                SizedBox(height: 20),

                // Recent Bookings Card (Matching Table Width)
                Align(
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 800, // Adjust this based on your layout needs
                    ),
                    child: Card(
                      color: Colors.grey[200],
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        height: 400, // Fixed height
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title and Search Bar
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Recent Bookings",
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),

                            // Search Bar - Full Width Inside Card
                            SizedBox(
                              width: double.infinity,
                              child: TextField(
                                controller: searchController,
                                decoration: InputDecoration(
                                  hintText: "Search bookings...",
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),

                            SizedBox(height: 10),

                            // Scrollable Table
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: DataTable(
                                      columnSpacing: isMobile ? 10 : null,
                                      dataRowHeight: 50,
                                      headingRowHeight: 50,
                                      columns: [
                                        DataColumn(label: Text("No")),
                                        DataColumn(label: Text("Name")),
                                        DataColumn(label: Text("Room")),
                                        DataColumn(label: Text("Check-in")),
                                        DataColumn(label: Text("Check-out")),
                                        DataColumn(label: Text("Status")),
                                      ],
                                      rows: filteredBookings.map((booking) {
                                        return DataRow(cells: [
                                          DataCell(Text(booking["no"].toString())),
                                          DataCell(Text(booking["name"])),
                                          DataCell(Text(booking["room"])),
                                          DataCell(Text(booking["checkin"])),
                                          DataCell(Text(booking["checkout"])),
                                          DataCell(Text(booking["status"])),
                                        ]);
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to create summary cards
  Widget _buildInfoCard(String text, Color color) {
    return Card(
      color: color,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 80,
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
