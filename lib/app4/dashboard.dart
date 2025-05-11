// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'loging_screen.dart';
//
// class DashboardPage extends StatelessWidget {
//   final Function(int) onTabChange; // Callback function to change tab
//   Future<void> _logout(BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', false);
//
//     // Navigate back to the login screen after logout
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => LoginScreen()),
//     );
//   }
//   const DashboardPage({super.key,required this.onTabChange});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Row(
//           children: [
//
//             Image.asset('assets/logo/logo.jpg', height: 40), // Replace with your logo asset
//             const SizedBox(width: 10),
//             const Expanded(
//               child: Text(
//                 "Matrimo",
//                 style: TextStyle(
//                   color: Colors.black87,
//                   fontWeight: FontWeight.bold,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ),
//
//           ],
//         ),
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () => _logout(context),
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xFFFFD3C4), // Soft Peach
//               Color(0xFFFF8B7B), // Coral Pink
//             ],
//           ),
//         ),
//         child: Center(
//           child: GridView.count(
//             crossAxisCount: 2,
//             crossAxisSpacing: 20,
//             mainAxisSpacing: 20,
//             padding: const EdgeInsets.all(20),
//             children: [
//               _buildDashboardCard(
//                 icon: Icons.person_add,
//                 text: "Add User",
//                 onTap: () {
//                   onTabChange(1); // Switch to Add User tab
//                 },
//               ),
//               _buildDashboardCard(
//                 icon: Icons.list,
//                 text: "User List",
//                 onTap: () {
//                   onTabChange(2); // Switch to User List tab
//                 },
//               ),
//               _buildDashboardCard(
//                 icon: Icons.favorite,
//                 text: "Favourite Users",
//                 onTap: () {
//                   onTabChange(3); // Switch to Favorites tab
//                 },
//               ),
//               _buildDashboardCard(
//                 icon: Icons.info,
//                 text: "About Us",
//                 onTap: () {
//                   onTabChange(4); // Switch to About Us tab
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDashboardCard({required IconData icon, required String text, required VoidCallback onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         color: Colors.white.withOpacity(0.9),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 40, color: Colors.deepOrange),
//             const SizedBox(height: 10),
//             Text(
//               text,
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'loging_screen.dart'; // Make sure the path is correct for LoginScreen
//
// class DashboardPage extends StatelessWidget {
//   final Function(int) onTabChange; // Callback function to change tab
//
//   // Logout function to clear SharedPreferences and navigate back to login screen
//   Future<void> _logout(BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     // Clear the isLoggedIn key or any other user-specific information
//     await prefs.setBool('isLoggedIn', false); // or prefs.remove('email') if you store email
//
//     // Navigate to the LoginScreen after clearing SharedPreferences
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => LoginScreen()), // Replace with LoginScreen
//     );
//   }
//
//   const DashboardPage({super.key, required this.onTabChange});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Row(
//           children: [
//             Image.asset('assets/logo/logo.jpg', height: 40), // Replace with your logo asset
//             const SizedBox(width: 10),
//             const Expanded(
//               child: Text(
//                 "Matrimo",
//                 style: TextStyle(
//                   color: Colors.black87,
//                   fontWeight: FontWeight.bold,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () => _logout(context), // Call the logout function
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xFFFFD3C4), // Soft Peach
//               Color(0xFFFF8B7B), // Coral Pink
//             ],
//           ),
//         ),
//         child: Center(
//           child: GridView.count(
//             crossAxisCount: 2,
//             crossAxisSpacing: 20,
//             mainAxisSpacing: 20,
//             padding: const EdgeInsets.all(20),
//             children: [
//               _buildDashboardCard(
//                 icon: Icons.person_add,
//                 text: "Add User",
//                 onTap: () {
//                   onTabChange(1); // Switch to Add User tab
//                 },
//               ),
//               _buildDashboardCard(
//                 icon: Icons.list,
//                 text: "User List",
//                 onTap: () {
//                   onTabChange(2); // Switch to User List tab
//                 },
//               ),
//               _buildDashboardCard(
//                 icon: Icons.favorite,
//                 text: "Favourite Users",
//                 onTap: () {
//                   onTabChange(3); // Switch to Favorites tab
//                 },
//               ),
//               _buildDashboardCard(
//                 icon: Icons.info,
//                 text: "About Us",
//                 onTap: () {
//                   onTabChange(4); // Switch to About Us tab
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDashboardCard({required IconData icon, required String text, required VoidCallback onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         color: Colors.white.withOpacity(0.9),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 40, color: Colors.deepOrange),
//             const SizedBox(height: 10),
//             Text(
//               text,
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:pie_chart/pie_chart.dart';
// import 'DatabaseService.dart';
// import 'User.dart';
//
// class DashboardPage extends StatefulWidget {
//   @override
//   State<DashboardPage> createState() => _DashboardPageState();
// }
//
// class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin {
//   final DatabaseService _databaseService = DatabaseService.instance;
//   late List<User> _allUsers = []; // Initialize _allUsers
//   double femaleAmount = 0;
//   double maleAmount = 0.00;
//   int totalAmount = 0;
//   Map<String,double> dataMap={};
//   // Animation controller
//   late AnimationController _controller;
//   late Animation<double> _femaleAnimation;
//   late Animation<double> _maleAnimation;
//   late Animation<double> _totalAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Initialize animation controller
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2), // Animation duration
//     );
//
//     // Initialize animations for female, male, and total
//     _femaleAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
//     _maleAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
//     _totalAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
//
//     // Fetch users and start animation
//     _fetchUsers();
//   }
//
//   Future<void> _fetchUsers() async {
//     try {
//       List<User> users = await _databaseService.getUsers();
//
//       setState(() {
//         _allUsers = users;
//         totalAmount = users.length;
//         femaleAmount = _allUsers
//             .where((user) => user.gender.toLowerCase() == "female")
//             .length+0.00;
//         maleAmount = _allUsers
//             .where((user) => user.gender.toLowerCase() == "male")
//             .length+0.00;
//         adddeatil();
//         // Update dataMap1 after fetching the users
//
//       });
//
//       // Start the animation after fetching data
//       _controller.forward();
//     } catch (e) {
//       print("Error fetching users: $e");
//       // Handle the error appropriately
//     }
//   }
//
//   final colorList = <Color>[
//     Colors.blue,
//     Colors.pinkAccent,
//   ];
//
//   @override
//   void dispose() {
//     _controller.dispose(); // Dispose the animation controller
//     super.dispose();
//
//   }
//   void adddeatil(){
//     dataMap = {
//       "Male": maleAmount,
//       "Female": femaleAmount,
//     };
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Balance Overview'),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       backgroundColor: Color(0xFFFFD3C4),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFFFFD3C4),
//               Color(0xFFFF8B7B),
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           children: [
//             // PieChart container
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: PieChart(
//                 dataMap: dataMap,
//                 animationDuration: Duration(milliseconds: 800),
//                 chartLegendSpacing: 32,
//                 chartRadius: MediaQuery.of(context).size.width / 3.2,
//                 colorList: colorList,
//                 initialAngleInDegree: 0,
//                 chartType: ChartType.ring,
//                 ringStrokeWidth: 32,
//                 centerText: "HYBRID",
//                 legendOptions: LegendOptions(
//
//                   showLegendsInRow: false,
//                   legendPosition: LegendPosition.right,
//                   showLegends: true,
//                   legendTextStyle: TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 chartValuesOptions: ChartValuesOptions(
//                   showChartValueBackground: true,
//                   showChartValues: true,
//
//                   showChartValuesInPercentage: false,
//                   showChartValuesOutside: false,
//                   decimalPlaces: 1,
//
//                 ),
//                 // gradientList: ---To add gradient colors---
//                 // emptyColorGradient: ---Empty Color gradient---
//               )
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:pie_chart/pie_chart.dart';
// import 'DatabaseService.dart';
// import 'User.dart';
//
// class DashboardPage extends StatefulWidget {
//   @override
//   State<DashboardPage> createState() => _DashboardPageState();
// }
//
// class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin {
//   final DatabaseService _databaseService = DatabaseService.instance;
//   late List<User> _allUsers = []; // Initialize _allUsers
//   double femaleAmount = 0;
//   double maleAmount = 0.00;
//   int totalAmount = 0;
//   Map<String, double> dataMap = {};
//
//   // Animation controller
//   late AnimationController _controller;
//   late Animation<double> _femaleAnimation;
//   late Animation<double> _maleAnimation;
//   late Animation<double> _totalAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Initialize animation controller
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2), // Animation duration
//     );
//
//     // Initialize animations for female, male, and total
//     _femaleAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
//     _maleAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
//     _totalAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
//
//     // Fetch users and start animation
//     _fetchUsers();
//   }
//
//   Future<void> _fetchUsers() async {
//     try {
//       List<User> users = await _databaseService.getUsers();
//
//       setState(() {
//         _allUsers = users;
//         totalAmount = users.length;
//         femaleAmount = _allUsers
//             .where((user) => user.gender.toLowerCase() == "female")
//             .length + 0.00;
//         maleAmount = _allUsers
//             .where((user) => user.gender.toLowerCase() == "male")
//             .length + 0.00;
//         addDetail();
//       });
//
//       // Start the animation after fetching data
//       _controller.forward();
//     } catch (e) {
//       print("Error fetching users: $e");
//       // Handle the error appropriately
//     }
//   }
//
//   final colorList = <Color>[
//     Colors.blue,
//     Colors.pinkAccent,
//   ];
//
//   @override
//   void dispose() {
//     _controller.dispose(); // Dispose the animation controller
//     super.dispose();
//   }
//
//   void addDetail() {
//     dataMap = {
//       "Male": maleAmount,
//       "Female": femaleAmount,
//     };
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Balance Overview'),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       backgroundColor: Color(0xFFFFD3C4),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFFFFD3C4),
//               Color(0xFFFF8B7B),
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           children: [
//             // PieChart container
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               height: MediaQuery.of(context).size.height * 0.5, // Set a height for the chart
//               child: Stack(
//                 children: [
//                   PieChart(
//                     dataMap: dataMap,
//                     animationDuration: Duration(milliseconds: 800),
//                     chartLegendSpacing: 32,
//                     chartRadius: MediaQuery.of(context).size.width / 3.2,
//                     colorList: colorList,
//                     initialAngleInDegree: 0,
//                     chartType: ChartType.ring,
//                     ringStrokeWidth: 32,
//                     legendOptions: LegendOptions(
//                       showLegends: false, // Disable default legend
//                     ),
//                     chartValuesOptions: ChartValuesOptions(
//                       showChartValueBackground: true,
//                       showChartValues: true,
//                       showChartValuesInPercentage: false,
//                       showChartValuesOutside: false,
//                       decimalPlaces: 1,
//                     ),
//                   ),
//                   Center(
//                     child: Text(
//                       "HYBRID",
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Custom Legend with Icons
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _buildLegendItem(
//                     icon: Icons.male,
//                     color: Colors.blue,
//                     label: "Male: $maleAmount",
//                   ),
//                   SizedBox(width: 20), // Spacing between items
//                   _buildLegendItem(
//                     icon: Icons.female,
//                     color: Colors.pinkAccent,
//                     label: "Female: $femaleAmount",
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Helper method to build a legend item with an icon
//   Widget _buildLegendItem({required IconData icon, required Color color, required String label}) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(icon, color: color, size: 24),
//         SizedBox(width: 8), // Spacing between icon and text
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'DatabaseService.dart';
import 'User.dart';

import 'loging_screen.dart'; // Import your LoginScreen

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin {
  final DatabaseService _databaseService = DatabaseService.instance;
  late List<User> _allUsers = []; // Initialize _allUsers
  double femaleAmount = 0;
  double maleAmount = 0;
  int totalAmount = 0;
  Map<String, double> genderDataMap = {};
  Map<String, double> cityDataMap = {};
  Map<String, double> ageDataMap = {};

  // Animation controller
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Animation duration
    );

    // Fetch users and start animation
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      List<User> users = await _databaseService.getUsers();

      setState(() {
        _allUsers = users;
        totalAmount = users.length;
        femaleAmount = _allUsers
            .where((user) => user.gender.toLowerCase() == "female")
            .length + 0.00;
        maleAmount = _allUsers
            .where((user) => user.gender.toLowerCase() == "male")
            .length + 0.00;
        _calculateCityDistribution();
        _calculateAgeDistribution();
        addDetail();
      });

      // Start the animation after fetching data
      _controller.forward();
    } catch (e) {
      print("Error fetching users: $e");
      // Handle the error appropriately
    }
  }

  final genderColorList = <Color>[
    Colors.blue,
    Colors.pinkAccent,
  ];

  final cityColorList = <Color>[
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];

  final ageColorList = <Color>[
    Colors.teal,
    Colors.amber,
    Colors.red,
  ];

  @override
  void dispose() {
    _controller.dispose(); // Dispose the animation controller
    super.dispose();
  }

  void addDetail() {
    genderDataMap = {
      "Male": maleAmount,
      "Female": femaleAmount,
    };
  }

  void _calculateCityDistribution() {
    // Example: Group users by city
    var cityCounts = _allUsers.fold<Map<String, int>>({}, (map, user) {
      map[user.city] = (map[user.city] ?? 0) + 1;
      return map;
    });

    cityDataMap = cityCounts.map((key, value) => MapEntry(key, value.toDouble()));
  }

  void _calculateAgeDistribution() {
    // Group users by age ranges
    int age18to50 = _allUsers.where((user) => user.age >= 18 && user.age < 50).length;
    int age50to60 = _allUsers.where((user) => user.age >= 50 && user.age < 60).length;
    int age60to80 = _allUsers.where((user) => user.age >= 60 && user.age <= 80).length;

    ageDataMap = {
      "18-50": age18to50.toDouble(),
      "50-60": age50to60.toDouble(),
      "60-80": age60to80.toDouble(),
    };
  }

  // Logout function to clear SharedPreferences and navigate back to login screen
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Clear the isLoggedIn key or any other user-specific information
    await prefs.setBool('isLoggedIn', false); // or prefs.remove('email') if you store email

    // Navigate to the LoginScreen after clearing SharedPreferences
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()), // Replace with LoginScreen
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate percentages
    double malePercentage = totalAmount > 0 ? (maleAmount / totalAmount) * 100 : 0;
    double femalePercentage = totalAmount > 0 ? (femaleAmount / totalAmount) * 100 : 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Keep existing AppBar style
        elevation: 0,
        title: Row(
          children: [
            Image.asset('assets/logo/logo.jpg', height: 40),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                "Dashboard",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.black87),
            onPressed: () => _logout(context), // Call the logout function
          ),
        ],
      ),
      backgroundColor: Color(0xFFF5F5F5), // Light background color
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFD3C4), // Soft Peach
              Color(0xFFFF8B7B), // Light Pinkish Orange
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Gender Pie Chart Card
                _buildCard(
                  title: 'Gender Distribution',
                  pieChart: PieChart(
                    dataMap: genderDataMap,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32,
                    chartRadius: MediaQuery.of(context).size.width / 4,
                    colorList: genderColorList,
                    initialAngleInDegree: 0,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 32,
                    legendOptions: LegendOptions(
                      showLegends: false,
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: true,
                      showChartValuesInPercentage: true,
                      showChartValuesOutside: false,
                      decimalPlaces: 1,
                    ),
                  ),
                  legend: Column(
                    children: [
                      _buildLegendItem(
                        icon: Icons.male,
                        color: Colors.blue,
                        label: "Male: ${malePercentage.toStringAsFixed(1)}%",
                      ),
                      SizedBox(height: 8),
                      _buildLegendItem(
                        icon: Icons.female,
                        color: Colors.pinkAccent,
                        label: "Female: ${femalePercentage.toStringAsFixed(1)}%",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                // City Pie Chart Card
                _buildCard(
                  title: 'City Distribution',
                  pieChart: PieChart(
                    dataMap: cityDataMap,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32,
                    chartRadius: MediaQuery.of(context).size.width / 4, // Consistent size
                    colorList: cityColorList,
                    initialAngleInDegree: 0,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 32,
                    legendOptions: LegendOptions(
                      showLegends: false,
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: true,
                      showChartValuesInPercentage: true,
                      showChartValuesOutside: false,
                      decimalPlaces: 1,
                    ),
                  ),
                  legend: SingleChildScrollView(
                    child: Column(
                      children: cityDataMap.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4), // Add spacing between items
                          child: _buildLegendItem(
                            icon: Icons.location_city,
                            color: cityColorList[cityDataMap.keys.toList().indexOf(entry.key)],
                            label: "${entry.key}: ${((entry.value / totalAmount) * 100).toStringAsFixed(1)}%",
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Age Pie Chart Card
                _buildCard(
                  title: 'Age Distribution',
                  pieChart: PieChart(
                    dataMap: ageDataMap,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32,
                    chartRadius: MediaQuery.of(context).size.width / 4, // Consistent size
                    colorList: ageColorList,
                    initialAngleInDegree: 0,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 32,
                    legendOptions: LegendOptions(
                      showLegends: false,
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: true,
                      showChartValuesInPercentage: true,
                      showChartValuesOutside: false,
                      decimalPlaces: 1,
                    ),
                  ),
                  legend: SingleChildScrollView(
                    child: Column(
                      children: ageDataMap.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4), // Add spacing between items
                          child: _buildLegendItem(
                            icon: Icons.calendar_today,
                            color: ageColorList[ageDataMap.keys.toList().indexOf(entry.key)],
                            label: "${entry.key}: ${((entry.value / totalAmount) * 100).toStringAsFixed(1)}%",
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build a card with consistent size and design
  Widget _buildCard({required String title, required Widget pieChart, required Widget legend}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: EdgeInsets.all(12), // Reduced padding
        height: 300, // Fixed height for all cards
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16, // Reduced font size
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16), // Reduced spacing
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 0,
                    child: pieChart,
                  ),
                  SizedBox(width: 12), // Reduced spacing
                  Expanded(
                    child: SingleChildScrollView(
                      child: legend,
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

  // Helper method to build a legend item with an icon
  Widget _buildLegendItem({required IconData icon, required Color color, required String label}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
  






