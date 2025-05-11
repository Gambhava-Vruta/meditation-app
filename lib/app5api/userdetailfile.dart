// import 'package:flutter/material.dart';
// import 'package:flutter_project/app4/adduserFile.dart';
// import 'package:flutter_project/app4/User.dart';
// import 'package:flutter_project/app4/DatabaseService.dart';
//
// class UserDetailPage extends StatelessWidget {
//   final User user;
//
//   const UserDetailPage({super.key, required this.user});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Row(
//           children: [
//             Image.asset('assets/logo/logo.jpg', height: 40),
//             const SizedBox(width: 10),
//             Flexible(
//               child: Text(
//                 user.name,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                   color: Colors.black87,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFFFFD3C4), // Soft Peach
//               Color(0xFFFF8B7B), // Light Pinkish Orange
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircleAvatar(
//                     radius: 50,
//                     backgroundColor: Colors.pink.shade100,
//                     backgroundImage: AssetImage(_getAvatar(user.gender)),
//                   ),
//                   const SizedBox(height: 10),
//
//                   // Buttons (Edit & Delete) Below Avatar
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       _buildIconButton(Icons.edit, Colors.blue, () => _editUser(context)),
//                       const SizedBox(width: 20),
//                       _buildIconButton(Icons.delete, Colors.red, () => _confirmDelete(context)),
//                     ],
//                   ),
//
//                   const SizedBox(height: 20),
//
//                   Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     elevation: 8,
//                     margin: const EdgeInsets.symmetric(vertical: 10),
//                     child: Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildDetail("Name", user.name),
//                           _buildDetail("Email", user.email),
//                           _buildDetail("Phone", user.phoneNumber),
//                           _buildDetail("Gender", user.gender),
//                           _buildDetail("Date of Birth", user.dob),
//                           _buildDetail("Age", user.age.toString()),
//                           _buildDetail("Height", user.height),
//                           _buildDetail("Weight", "${user.weight} kg"),
//                           _buildDetail("Marital Status", user.maritalStatus),
//                           _buildDetail("Religion", user.religion),
//                           _buildDetail("Caste", user.caste),
//                           _buildDetail("Mother Tongue", user.motherTongue),
//                           _buildDetail("Nationality", user.nationality),
//                           _buildDetail("City", user.city),
//                           _buildDetail("State", user.state),
//                           _buildDetail("Country", user.country),
//                           _buildDetail("Education", user.education),
//                           _buildDetail("Profession", user.profession),
//                           _buildDetail("Income", user.income),
//                           _buildDetail("Diet", user.diet),
//                           _buildDetail("Hobbies", user.hobbies),
//                           _buildDetail("Favourite", user.isFavourite ? "Yes" : "No"),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   String _getAvatar(String gender) {
//     return gender.toLowerCase() == "male"
//         ? "assets/logo/male.webp"
//         : "assets/logo/femail.webp";
//   }
//
//   Widget _buildDetail(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             "$label:",
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           Flexible(
//             child: Text(
//               value,
//               style: const TextStyle(fontSize: 16),
//               overflow: TextOverflow.ellipsis,
//               maxLines: 2,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildIconButton(IconData icon, Color color, VoidCallback onPressed) {
//     return CircleAvatar(
//       radius: 30,
//       backgroundColor: Colors.white,
//       child: IconButton(
//         icon: Icon(icon, color: color),
//         onPressed: onPressed,
//       ),
//     );
//   }
//
//   void _editUser(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AddUserPage(user: user),
//       ),
//     ).then((updatedUser) {
//       if (updatedUser != null) {
//         Navigator.pop(context, updatedUser);
//       }
//     });
//   }
//
//   void _confirmDelete(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Confirm Delete"),
//           content: const Text("Are you sure you want to delete this user?"),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () async {
//                 await DatabaseService.instance.deleteUser(user.id!);
//                 Navigator.pop(context);
//                 Navigator.pop(context, true);
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text("User deleted successfully!")),
//                 );
//               },
//               child: const Text("Delete", style: TextStyle(color: Colors.red)),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
// import 'package:flutter_project/app5api/adduserFile.dart';
// import 'package:flutter_project/app5api/User.dart';
// import 'package:flutter_project/app5api/DatabaseService.dart';
// import 'package:flutter_project/app5api/dashboard.dart';
// import 'package:flutter_project/app5api/userlistfile.dart';
// import 'package:intl/intl.dart';
//
// import 'buttomnavigation.dart';
//
// class UserDetailPage extends StatefulWidget {
//   final User user;
//
//   const UserDetailPage({super.key, required this.user});
//
//   @override
//   State<UserDetailPage> createState() => _UserDetailPageState();
// }
//
// class _UserDetailPageState extends State<UserDetailPage> {
//   String _formatDate(String dateStr) {
//     try {
//       // Using DateFormat to parse the date string in "dd/MM/yyyy" format
//       DateTime date = DateFormat('dd/MM/yyyy').parse(dateStr);
//       return DateFormat('dd/MM/yyyy').format(date); // Format the DateTime object to the desired string
//     } catch (e) {
//       return "Invalid Date"; // Return this if parsing fails
//     }
//   }
//   @override
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Row(
//           children: [
//             Image.asset('assets/logo/logo.jpg', height: 40),
//             const SizedBox(width: 10),
//             Flexible(
//               child: Text(
//                 widget.user.name,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                   color: Colors.black87,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFFFFD3C4), Color(0xFFFF8B7B)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: [
//               _buildProfileHeader(), // Avatar at the top
//               const SizedBox(height: 15), // Add space
//               _buildActionButtons(context), // Buttons directly below Avatar
//               const SizedBox(height: 20), // Add space before details
//
//               _buildInfoCard("Basic Information", [
//                 _buildDetail("Name", widget.user.name),
//                 _buildDetail("Email", widget.user.email),
//                 _buildDetail("Phone", widget.user.phoneNumber),
//                 _buildDetail("Gender", widget.user.gender),
//                 _buildDetail("Date of Birth", _formatDate(widget.user.dob)),
//                 _buildDetail("Age", widget.user.age.toString()),
//               ]),
//
//               _buildInfoCard("Personal Details", [
//                 _buildDetail("Height", widget.user.height),
//                 _buildDetail("Weight", "${widget.user.weight} kg"),
//                 _buildDetail("Marital Status", widget.user.maritalStatus),
//                 _buildDetail("Religion", widget.user.religion),
//                 _buildDetail("Caste", widget.user.caste),
//                 _buildDetail("Mother Tongue", widget.user.motherTongue),
//                 _buildDetail("Nationality", widget.user.nationality),
//               ]),
//
//               _buildInfoCard("Location & Work", [
//                 _buildDetail("City", widget.user.city),
//                 _buildDetail("State", widget.user.state),
//                 _buildDetail("Country", widget.user.country),
//                 _buildDetail("Education", widget.user.education),
//                 _buildDetail("Profession", widget.user.profession),
//                 _buildDetail("Income", widget.user.income),
//               ]),
//
//               _buildInfoCard("Preferences", [
//                 _buildDetail("Diet", widget.user.diet),
//                 _buildDetail("Hobbies", widget.user.hobbies),
//                 _buildDetail("Favourite", widget.user.isFavourite ? "Yes" : "No"),
//               ]),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Profile Header with Avatar
//   Widget _buildProfileHeader() {
//     return Column(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             boxShadow: [
//               BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2)
//             ],
//           ),
//           child: CircleAvatar(
//             radius: 55,
//             backgroundColor: Colors.white,
//             backgroundImage: AssetImage(_getAvatar(widget.user.gender)),
//           ),
//         ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
//
//   // Action Buttons (Now placed below avatar)
//   Widget _buildActionButtons(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         _buildIconButton(Icons.edit, Colors.blue, () => _editUser(context)),
//         const SizedBox(width: 20),
//         _buildIconButton(Icons.delete, Colors.red, () => _confirmDelete(context)),
//       ],
//     );
//   }
//
//   // Single Detail Row
//   Widget _buildDetail(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text("$label:", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//           Flexible(
//             child: Text(
//               value,
//               style: const TextStyle(fontSize: 16),
//               overflow: TextOverflow.ellipsis,
//               maxLines: 2,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Creates a separate card for each section
//   Widget _buildInfoCard(String title, List<Widget> details) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       elevation: 6,
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange,
//               ),
//             ),
//             const Divider(),
//             ...details,
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Button Component
//   Widget _buildIconButton(IconData icon, Color color, VoidCallback onPressed) {
//     return CircleAvatar(
//       radius: 30,
//       backgroundColor: Colors.white,
//       child: IconButton(
//         icon: Icon(icon, color: color),
//         onPressed: onPressed,
//       ),
//     );
//   }
//
//   // Edit User
//   void _editUser(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AddUserPage(user: widget.user),
//       ),
//     ).then((updatedUser) {
//       if (updatedUser != null) {
//         Navigator.pop(context, updatedUser);
//       }
//     });
//   }
//
//   // Confirm Delete User
//   // void _confirmDelete(BuildContext context) {
//   //   showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return AlertDialog(
//   //         title: const Text("Confirm Delete"),
//   //         content: const Text("Are you sure you want to delete this user?"),
//   //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//   //         actions: [
//   //           TextButton(
//   //             onPressed: () => Navigator.pop(context),
//   //             child: const Text("Cancel"),
//   //           ),
//   //           TextButton(
//   //             onPressed: () async {
//   //               await DatabaseService.instance.deleteUser(widget.user.id!);
//   //               Navigator.pop(context);
//   //               Navigator.pop(context, true);
//   //               ScaffoldMessenger.of(context).showSnackBar(
//   //                 const SnackBar(content: Text("User deleted successfully!")),
//   //               );
//   //             },
//   //             child: const Text("Delete", style: TextStyle(color: Colors.red)),
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }
// // Confirm Delete User
//   void _confirmDelete(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Confirm Delete"),
//           content: const Text("Are you sure you want to delete this user?"),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () async {
//                 try {
//                   await DatabaseService().deleteUser(widget.user.id!);
//                   Navigator.pop(context, true);
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => MainScreen(),
//                     ),
//                   );
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("User deleted successfully!")),
//                   );
//                 } catch (e) {
//                   print('Error deleting user: $e'); // Debug
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("Failed to delete user: $e")),
//                   );
//                 }
//               },
//               child: const Text("Delete", style: TextStyle(color: Colors.red)),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//
//   // Avatar Image Based on Gender
//   String _getAvatar(String gender) {
//     return gender.toLowerCase() == "male"
//         ? "assets/logo/male.webp"
//         : "assets/logo/femail.webp";
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_project/app5api/adduserFile.dart';
import 'package:flutter_project/app5api/User.dart';
import 'package:flutter_project/app5api/DatabaseService.dart';
import 'package:flutter_project/app5api/dashboard.dart';
import 'package:flutter_project/app5api/userlistfile.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'buttomnavigation.dart';

class UserDetailPage extends StatefulWidget {
  final User user;

  const UserDetailPage({super.key, required this.user});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  String _formatDate(String dateStr) {
    try {
      DateTime date = DateFormat('dd/MM/yyyy').parse(dateStr);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return "Invalid Date";
    }
  }

  // Function to generate the PDF
  Future<void> _generatePdf(User user) async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          children: [
            pw.Text("User Details", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text("Name: ${user.name}"),
            pw.Text("Email: ${user.email}"),
            pw.Text("Phone: ${user.phoneNumber}"),
            pw.Text("Gender: ${user.gender}"),
            pw.Text("Date of Birth: ${_formatDate(user.dob)}"),
            pw.Text("Age: ${user.age}"),
            pw.Text("Height: ${user.height}"),
            pw.Text("Weight: ${user.weight} kg"),
            pw.Text("Marital Status: ${user.maritalStatus}"),
            pw.Text("Religion: ${user.religion}"),
            pw.Text("Caste: ${user.caste}"),
            pw.Text("Mother Tongue: ${user.motherTongue}"),
            pw.Text("Nationality: ${user.nationality}"),
            pw.Text("City: ${user.city}"),
            pw.Text("State: ${user.state}"),
            pw.Text("Country: ${user.country}"),
            pw.Text("Education: ${user.education}"),
            pw.Text("Profession: ${user.profession}"),
            pw.Text("Income: ${user.income}"),
            pw.Text("Diet: ${user.diet}"),
            pw.Text("Hobbies: ${user.hobbies}"),
            pw.Text("Favourite: ${user.isFavourite ? "Yes" : "No"}"),
          ],
        );
      },
    ));

    // Save PDF to a file or print
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Image.asset('assets/logo/logo.jpg', height: 40),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                widget.user.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFD3C4), Color(0xFFFF8B7B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 15),
              _buildActionButtons(context),
              const SizedBox(height: 20),
              _buildInfoCard("Basic Information", [
                _buildDetail("Name", widget.user.name),
                _buildDetail("Email", widget.user.email),
                _buildDetail("Phone", widget.user.phoneNumber),
                _buildDetail("Gender", widget.user.gender),
                _buildDetail("Date of Birth", _formatDate(widget.user.dob)),
                _buildDetail("Age", widget.user.age.toString()),
              ]),
              _buildInfoCard("Personal Details", [
                _buildDetail("Height", widget.user.height),
                _buildDetail("Weight", "${widget.user.weight} kg"),
                _buildDetail("Marital Status", widget.user.maritalStatus),
                _buildDetail("Religion", widget.user.religion),
                _buildDetail("Caste", widget.user.caste),
                _buildDetail("Mother Tongue", widget.user.motherTongue),
                _buildDetail("Nationality", widget.user.nationality),
              ]),
              _buildInfoCard("Location & Work", [
                _buildDetail("City", widget.user.city),
                _buildDetail("State", widget.user.state),
                _buildDetail("Country", widget.user.country),
                _buildDetail("Education", widget.user.education),
                _buildDetail("Profession", widget.user.profession),
                _buildDetail("Income", widget.user.income),
              ]),
              _buildInfoCard("Preferences", [
                _buildDetail("Diet", widget.user.diet),
                _buildDetail("Hobbies", widget.user.hobbies),
                _buildDetail("Favourite", widget.user.isFavourite ? "Yes" : "No"),
              ]),
              ElevatedButton(
                onPressed: () => _generatePdf(widget.user),
                child: const Text('Convert to PDF & Print'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2)
            ],
          ),
          child: CircleAvatar(
            radius: 55,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage(_getAvatar(widget.user.gender)),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildIconButton(Icons.edit, Colors.blue, () => _editUser(context)),
        const SizedBox(width: 20),
        _buildIconButton(Icons.delete, Colors.red, () => _confirmDelete(context)),
      ],
    );
  }

  Widget _buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$label:", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> details) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange,
              ),
            ),
            const Divider(),
            ...details,
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, Color color, VoidCallback onPressed) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.white,
      child: IconButton(
        icon: Icon(icon, color: color),
        onPressed: onPressed,
      ),
    );
  }

  void _editUser(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddUserPage(user: widget.user),
      ),
    ).then((updatedUser) {
      if (updatedUser != null) {
        Navigator.pop(context, updatedUser);
      }
    });
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this user?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await DatabaseService().deleteUser(widget.user.id!);
                  Navigator.pop(context, true);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(content: Text("User deleted successfully!")),
                                      );
                } catch

                 (e) {
                  print('Error deleting user: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to delete user: $e")),
                  );
                }
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  String _getAvatar(String gender) {
    return gender.toLowerCase() == "male"
        ? "assets/logo/male.webp"
        : "assets/logo/female.webp";
  }
}
