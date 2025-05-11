import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Adduser.dart';
import 'StringConst.dart';
import 'User.dart';
import 'UserDeatilPage.dart';

class UserListPage extends StatefulWidget {
  UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  bool isGrid = false;
  List<Map<String, dynamic>>? searchList = [];  // Initialize as an empty list
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    List<Map<String, dynamic>> result = await DatabaseHelper.getUsers();
    setState(() {
      searchList = result;
      print(searchList);// Update the list after fetching data
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,
        title: Text(
          'User List',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isGrid = false;
              });
            },
            icon: Icon(
              Icons.list,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isGrid = true;
              });
            },
            icon: Icon(
              Icons.grid_3x3,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return UserEntryFormPage();
                  },
                ),
              ).then((value) {
                if (value != null) {
                  DatabaseHelper.addUser(
                      name: value[NAME],
                      email: value[EMAIL],
                      phoneNumber: value[PHONENUMBER],
                      age: value[AGE],
                      dob: value[DOB],
                      gender: value[GENDER],
                      city: value[CITY],
                      isFavourite: value['Isfavourite'],
                      password: value[PASSWORD]);
                 // filterCard(searchController.text); // Refresh search list
                  setState(() {});
                }
              });
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade50, Colors.blue.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                // onChanged: (value) {
                //   filterCard(value);
                // },
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue.shade300),
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.pink),
                ),
              ),
            ),
            searchList!.isEmpty
                ? Expanded(
              child: Center(
                child: Text(
                  'No User Found',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
            )
                : (isGrid
                ? Expanded(
              child: GridView.builder(
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: searchList!.length,
                itemBuilder: (context, index) {
                  return getListGridItem(index);
                },
              ),
            )
                : Expanded(
              child: ListView.builder(
                itemCount: searchList!.length,
                itemBuilder: (BuildContext context, int index) {
                  return getListGridItem(index);
                },
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget getListGridItem(int i) {
    print("Rendering item: ${searchList![i][NAME]}");  // Check the data at this index
    return GestureDetector(
      onTap: () {
        // Navigate to the UserDetailPage when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return UserDetailPage(i: i);
            },
          ),
        );
      },
      child: Card(
        color: Colors.pink.shade50,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Row(
            children: [
              // Leading Icon
              Icon(
                Icons.account_circle,
                size: 40,
                color: Colors.blue.shade300,
              ),
              SizedBox(width: 12),
              // User Details (Name, Location, Age)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      '${searchList![i][NAME]}',  // Ensure this is not null
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink.shade700,
                      ),
                    ),
                    SizedBox(height: 2),
                    // Location and Age in a single row
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            size: 18, color: Colors.blue.shade300),
                        SizedBox(width: 4),
                        Text(
                          '${searchList![i][CITY] ?? 'No city'}',  // Handle null values
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade700),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '|',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade500),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.cake, size: 18, color: Colors.pink.shade300),
                        SizedBox(width: 4),
                        Text(
                          '${searchList![i][AGE] ?? 'No age'}',  // Handle null values
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}


