import 'package:flutter/material.dart';
import 'package:flutter_project/app1/Registration.dart';
import 'package:flutter_project/app1/StringConst.dart';
import 'package:flutter_project/app1/about_us.dart';
import 'package:flutter_project/app1/view_user_list.dart';
import 'FavouritePage.dart';
import 'User.dart';


class Dashbord extends StatefulWidget {
  const Dashbord({super.key});
  @override
  State<Dashbord> createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord> {
  User user=User();

  Map<String,dynamic> map1={};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard',style: TextStyle(color: Colors.white),),

        backgroundColor: Colors.pink.shade200,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBoxWithIconAndText(
                context,
                'Add User',
                Icons.person_add,
                Colors.blue.shade200,
                Colors.white,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserEntryFormPage(),
                    ),
                  ).then((value) {
                    user.userList.add(value);
                    setState(() {
                    }); // Refresh the dashboard after returning
                  });
                },
              ),
              SizedBox(width: 20),
              _buildBoxWithIconAndText(
                context,
                'View Users',
                Icons.list,
                Colors.blue.shade200,
                Colors.white,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserListPage(userList: user.userList),
                        ),
                      );
                    }

              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBoxWithIconAndText(
                context,
                'Favourite Users',
                Icons.favorite,
                Colors.pink.shade200,
                Colors.white,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Favouritepage(userList:user.userList);
                    }),
                  );
                },
              ),
              SizedBox(width: 20),
              _buildBoxWithIconAndText(
                context,
                'About Us',
                Icons.info,
                Colors.pink.shade200,
                Colors.white,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return AboutUs();
                    }),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Method to build the box with both text and an icon
  Widget _buildBoxWithIconAndText(BuildContext context, String label,
      IconData icon, Color boxColor, Color textColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 150,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30,
                color: textColor,
              ),
              SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
