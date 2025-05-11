import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Registration.dart';
import 'StringConst.dart';
import 'User.dart';
import 'FavouritePage.dart';
import 'UserDetailPage.dart';

class UserListPage extends StatefulWidget {
  List<Map<String, dynamic>>? userList;

  UserListPage({super.key, required List<Map<String, dynamic>> userList}) {
    this.userList = userList;
    print(userList);
  }

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  User _user = User();
  bool isGrid = false;
  List<Map<String, dynamic>>? searchList;
  TextEditingController searchController = TextEditingController();


  @override
  @override
  void initState() {
    super.initState();
    _user.userList = widget.userList ?? []; // Prevent null list
    searchList = List.from(_user.userList); // Ensure searchList is initialized properly
  }


  void filterCard(String query) {
    if (query.isEmpty) {
      setState(() {
        searchList = List.from(_user.userList); // Reset to full list
      });
      return;
    }

    List<Map<String, dynamic>> result = _user.userList.where((user) {
      return user[NAME].toString().toLowerCase().contains(query.toLowerCase()) ||
          user[EMAIL].toString().toLowerCase().contains(query.toLowerCase()) ||
          user[CITY].toString().toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      searchList = result;
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
                  _user.userList.add(value);
                  filterCard(searchController.text); // Refresh search list
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
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  filterCard(value);
                },
                decoration: InputDecoration(
                  hintText: 'Search ',
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
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
    return GestureDetector(
      onTap: () {
        // Navigate to the UserDetailPage when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return UserDetailPage(userDetails: searchList![i]);
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Name
                    Text(
                      '${searchList![i][NAME]}',
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
                        Icon(Icons.location_on, size: 18, color: Colors.blue.shade300),
                        SizedBox(width: 4),
                        Text(
                          '${searchList![i][CITY]}',
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '|',
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.cake, size: 18, color: Colors.pink.shade300),
                        SizedBox(width: 4),
                        Text(
                          '${searchList![i][AGE]} years',
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Edit Icon
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blue.shade400),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return UserEntryFormPage(
                          userDetail: searchList![i],
                        );
                      },
                    ),
                  ).then((value) {
                    if (value != null) {
                      _user.updateUser(
                          name: value[NAME],
                          email: value[EMAIL],
                          phoneNumber: value[PHONENUMBER],
                          age: value[AGE],
                          Dob: value[DOB],
                          id: i,
                          Gender: value[GENDER],
                          city: value[CITY],
                          Isfavourite: value['Isfavourite'],
                          Password: value[PASSWORD]);
                      filterCard(searchController.text);
                      setState(() {});
                    }
                  })
                  ;
                },
              ),
              // Delete Icon
              IconButton(
                icon: Icon(Icons.delete, color: Colors.pink),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Are you sure?'),
                        content: Text('Do you really want to delete this user?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                // Delete the user from the original list
                                _user.deleteUser(i);  // This method should remove the user from _user.userList
                                // After deleting, reapply the filter to refresh the search list
                                filterCard(searchController.text);  // Apply the current search filter
                              });
                              Navigator.of(context).pop();
                            },
                            child: Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),

              // Favorite Icon
              IconButton(
                icon: Icon(
                  searchList![i]['Isfavourite'] ?? false
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: searchList![i]['Isfavourite'] ?? false
                      ? Colors.pink
                      : Colors.grey.shade400,
                ),
                onPressed: () {
                  setState(() {
                    searchList![i]['Isfavourite'] =
                    !(searchList![i]['Isfavourite'] ?? false);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


}
