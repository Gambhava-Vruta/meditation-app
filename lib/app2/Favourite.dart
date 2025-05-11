import 'package:flutter/material.dart';
import 'User.dart';
import 'DatabaseService.dart';
import 'addUser.dart';


class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  _FavouritePageState createState() => _FavouritePageState(); // ✅ Fixed
}


class _FavouritePageState extends State<FavouritePage> {
  List<User> favouriteUsers = [];
  TextEditingController searchController = TextEditingController();
  bool isGrid = false;

  @override
  void initState() {
    super.initState();
    _loadFavouriteUsers();
  }

  Future<void> _loadFavouriteUsers() async {
    List<User> allUsers = await DatabaseService.instance.getUsers();
    setState(() {
      favouriteUsers = allUsers.where((user) => user.isFavourite).toList();
    });
  }
  void toggleFavourite(User user) async {
    setState(() {
      user.isFavourite = !user.isFavourite;
    });

  }

  void _filterUsers(String query) {
    setState(() {
      favouriteUsers = favouriteUsers
          .where((user) =>
      user.name.toLowerCase().contains(query.toLowerCase()) ||
          user.email.toLowerCase().contains(query.toLowerCase()) ||
          user.city.toLowerCase().contains(query.toLowerCase()) ||
          user.phoneNumber.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,
        title: const Text(
          'Favourite Users',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () => setState(() => isGrid = false),
            icon: const Icon(Icons.list, color: Colors.white),
          ),
          IconButton(
            onPressed: () => setState(() => isGrid = true),
            icon: const Icon(Icons.grid_3x3, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserEntryFormPage()),
              ).then((_) => _loadFavouriteUsers());
            },
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              onChanged: _filterUsers,
              decoration: const InputDecoration(
                hintText: 'Search by name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: favouriteUsers.isEmpty
                ? const Center(
              child: Text(
                'No Favourite Users Found',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            )
                : ListView.builder(
              itemCount: favouriteUsers.length,
              itemBuilder: (context, index) => _buildUserItem(favouriteUsers[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserItem(User user) {
    return Card(
      color: Colors.pink.shade50,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.account_circle, size: 40, color: Colors.blue),
        title: Text(user.name, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink.shade700)),
        subtitle: Text('${user.city} | ${user.age} years'),
        trailing:IconButton(
          icon: Icon(
            user.isFavourite ? Icons.favorite : Icons.favorite_border,
            color: user.isFavourite ? Colors.pink : Colors.grey.shade400,
          ),
          onPressed: () => toggleFavourite(user),
        ),


      ),
    );
  }
}
