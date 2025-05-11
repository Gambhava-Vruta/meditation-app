import 'package:flutter/material.dart';

import 'Registration.dart';
import 'StringConst.dart';
import 'User.dart';
import 'UserDetailPage.dart';

class Favouritepage extends StatefulWidget {
  List<Map<String, dynamic>>? userList;



  Favouritepage({super.key, required this.userList});  // Constructor fix

  @override
  _FavouritepageState createState() => _FavouritepageState();
}

class _FavouritepageState extends State<Favouritepage> {
  User _user = User();
  bool isGrid = false;
  List<Map<String, dynamic>>? searchList;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Ensure the list is not null; if null, fallback to an empty list
    _user.userList = widget.userList ?? [];
    searchList = _user.userList;
  }

  void filterCard(String query) {
    List<Map<String, dynamic>> result = [];
    if (query.isEmpty) {
      result = _user.userList;
    } else {
      result = (_user.userList ?? [])
          .where(
              (user) => user[NAME].toLowerCase() || user[EMAIL].toLowerCase() || user[CITY].toLowerCase() || user[PHONE].toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {
      searchList = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Safely filter the list to only include users who are marked as favourites
    List<Map<String, dynamic>> favouriteUsers = (searchList ?? [])
        .where((user) => user['Isfavourite'] == true)
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,
        title: Text(
          'Favourite Users',
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
        color: Colors.pink.shade50,
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
                  hintText: 'Search by name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            // If no favourites are found
            favouriteUsers.isEmpty
                ? Expanded(
              child: Center(
                child: Text(
                  'No Favourite Users Found',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
            )
                : Expanded(
              child: ListView.builder(
                itemCount: favouriteUsers.length,
                itemBuilder: (BuildContext context, int index) {
                  return getListGridItem(favouriteUsers, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getListGridItem(List<Map<String, dynamic>> favouriteUsers, int i) {
    return GestureDetector(
      onTap: () {
        // Navigate to the UserDetailPage when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return UserDetailPage(userDetails: favouriteUsers[i]);
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
