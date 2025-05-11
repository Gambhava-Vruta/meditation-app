// import 'package:flutter/material.dart';
// import 'databasehelper.dart';
// import 'Task.dart';
//
// class ScreenPage extends StatefulWidget {
//   const ScreenPage({super.key});
//
//   @override
//   State<ScreenPage> createState() => _ScreenPageState();
// }
//
// class _ScreenPageState extends State<ScreenPage> {
//   final databasehelper _databaseService = databasehelper.instance;
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   int? selectedPriority = 0; // Default priority (Low)
//
//   List<Task> tasks = []; // Store tasks as Task objects
//   bool isSorted = false; // Flag to track if tasks are sorted
//
//   @override
//   void initState() {
//     super.initState();
//     _loadTasks();
//   }
//
//   // Load tasks from the database
//   void _loadTasks() async {
//     var taskList = await _databaseService.getTasks();
//     setState(() {
//       tasks = taskList;
//     });
//   }
//
//   // Show the dialog for creating or editing a task
//   void _showCustomDialog(BuildContext context, {Task? task}) {
//     if (task != null) {
//       // If we're editing a task, pre-fill the fields
//       titleController.text = task.titel;
//       descriptionController.text = task.desc;
//       selectedPriority = task.priority;
//     } else {
//       // Clear fields for adding a new task
//       titleController.clear();
//       descriptionController.clear();
//       selectedPriority = 0; // Default to Low
//     }
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(task != null ? 'Edit Task' : 'Enter Task Details'),
//           content: SingleChildScrollView(
//             child: Column(
//               children: [
//                 TextField(
//                   controller: titleController,
//                   decoration: InputDecoration(
//                     labelText: 'Title',
//                   ),
//                 ),
//                 TextField(
//                   controller: descriptionController,
//                   decoration: InputDecoration(
//                     labelText: 'Description',
//                   ),
//                 ),
//                 DropdownButtonFormField<int>(
//                   value: selectedPriority ?? 0, // Default value if null
//                   onChanged: (int? newValue) {
//                     setState(() {
//                       selectedPriority = newValue;
//                     });
//                   },
//                   items: [
//                     DropdownMenuItem<int>(
//                       value: 0,
//                       child: Text('Low'),
//                     ),
//                     DropdownMenuItem<int>(
//                       value: 1,
//                       child: Text('Medium'),
//                     ),
//                     DropdownMenuItem<int>(
//                       value: 2,
//                       child: Text('High'),
//                     ),
//                   ],
//                   decoration: InputDecoration(
//                     labelText: 'Priority',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 // Handle saving or updating data
//                 String title = titleController.text;
//                 String description = descriptionController.text;
//                 int priority = selectedPriority ?? 0;
//
//                 if (title.isEmpty || description.isEmpty || priority == null) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Please fill in all fields with valid data')),
//                   );
//                   return;
//                 }
//
//                 if (task == null) {
//                   // Add new task
//                   await _databaseService.addTask(Task(
//                     titel: title,
//                     desc: description,
//                     priority: priority,
//                   ));
//                 } else {
//                   // Update existing task
//                   await _databaseService.updateTask(Task(
//                     id: task.id,
//                     titel: title,
//                     desc: description,
//                     priority: priority,
//                   ));
//                 }
//
//                 Navigator.of(context).pop();
//                 _loadTasks(); // Reload tasks after save or update
//               },
//               child: Text(task != null ? 'Update' : 'Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   // Delete task
//   void _deleteTask(int taskId) async {
//     await _databaseService.deleteTask(taskId);
//     _loadTasks(); // Reload tasks after delete
//   }
//
//   // Sorting Action
//   void _sortTasks() {
//     if (!isSorted) {
//       setState(() {
//         tasks.sort((a, b) => a.titel.compareTo(b.titel)); // Sort alphabetically A-Z
//         isSorted = true; // Mark as sorted
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('To-Do List'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.sort_by_alpha),
//             onPressed: _sortTasks, // Sorting action when clicked
//           ),
//         ],
//       ),
//       body: tasks.isEmpty
//           ? Center(child: Text('No tasks available'))
//           : ListView.builder(
//         itemCount: tasks.length,
//         itemBuilder: (context, index) {
//           final task = tasks[index];
//           Color priorityColor;
//
//           // Set the priority color based on priority
//           switch (task.priority) {
//             case 0:
//               priorityColor = Colors.green; // Low
//               break;
//             case 1:
//               priorityColor = Colors.yellow; // Medium
//               break;
//             case 2:
//               priorityColor = Colors.red; // High
//               break;
//             default:
//               priorityColor = Colors.grey;
//           }
//
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//             child: Card(
//               elevation: 5,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: ListTile(
//                 contentPadding: EdgeInsets.all(16),
//                 title: Text(
//                   task.titel,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//                 subtitle: Text(
//                   'Priority: ${task.priority == 1 ? "High" : task.priority == 2 ? "Medium" : "Low"}',
//                   style: TextStyle(color: priorityColor, fontSize: 16),
//                 ),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.edit),
//                       onPressed: () {
//                         _showCustomDialog(context, task: task);
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.delete),
//                       onPressed: () {
//                         _deleteTask(task.id!);
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.blueGrey,
//         child: Icon(Icons.add, color: Colors.white),
//         onPressed: () {
//           _showCustomDialog(context);
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'databasehelper.dart';
import 'Task.dart';

class ScreenPage extends StatefulWidget {
  const ScreenPage({super.key});

  @override
  State<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {
  final databasehelper _databaseService = databasehelper.instance;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  int? selectedPriority = 0; // Default priority (Low)

  List<Task> tasks = []; // Store tasks as Task objects
  bool isSorted = false; // Flag to track if tasks are sorted

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  // Load tasks from the database
  void _loadTasks() async {
    var taskList = await _databaseService.getTasks();
    setState(() {
      tasks = taskList;
    });
  }

  // Show the dialog for creating or editing a task
  void _showCustomDialog(BuildContext context, {Task? task}) {
    if (task != null) {
      // If we're editing a task, pre-fill the fields
      titleController.text = task.titel;
      descriptionController.text = task.desc;
      selectedPriority = task.priority;
    } else {
      // Clear fields for adding a new task
      titleController.clear();
      descriptionController.clear();
      selectedPriority = 0; // Default to Low
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(task != null ? 'Edit Task' : 'Enter Task Details'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                ),
                DropdownButtonFormField<int>(
                  value: selectedPriority ?? 0, // Default value if null
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedPriority = newValue;
                    });
                  },
                  items: [
                    DropdownMenuItem<int>(
                      value: 0,
                      child: Text('Low'),
                    ),
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text('Medium'),
                    ),
                    DropdownMenuItem<int>(
                      value: 2,
                      child: Text('High'),
                    ),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Priority',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Handle saving or updating data
                String title = titleController.text;
                String description = descriptionController.text;
                int priority = selectedPriority ?? 0;

                if (title.isEmpty || description.isEmpty || priority == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in all fields with valid data')),
                  );
                  return;
                }

                if (task == null) {
                  // Add new task
                  await _databaseService.addTask(Task(
                    titel: title,
                    desc: description,
                    priority: priority,
                  ));
                } else {
                  // Update existing task
                  await _databaseService.updateTask(Task(
                    id: task.id,
                    titel: title,
                    desc: description,
                    priority: priority,
                  ));
                }

                Navigator.of(context).pop();
                _loadTasks(); // Reload tasks after save or update
              },
              child: Text(task != null ? 'Update' : 'Save'),
            ),
          ],
        );
      },
    );
  }

  // Delete task
  void _deleteTask(int taskId) async {
    await _databaseService.deleteTask(taskId);
    _loadTasks(); // Reload tasks after delete
  }

  // Sorting Action
  void _sortTasks(String sortType) {
    setState(() {
      if (sortType == 'A-Z') {
        tasks.sort((a, b) => a.titel.compareTo(b.titel)); // Sort A-Z
      } else if (sortType == 'Z-A') {
        tasks.sort((a, b) => b.titel.compareTo(a.titel)); // Sort Z-A
      }
    });
  }

  // Get card color based on priority
  Color _getCardColor(int priority) {
    switch (priority) {
      case 0:
        return Colors.green.withOpacity(0.2); // Low priority
      case 1:
        return Colors.yellow.withOpacity(0.2); // Medium priority
      case 2:
        return Colors.red.withOpacity(0.2); // High priority
      default:
        return Colors.grey.withOpacity(0.2); // Default
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              _sortTasks(value); // Call sorting function based on selected option
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'A-Z',
                  child: Text('Sort A-Z'),
                ),
                PopupMenuItem<String>(
                  value: 'Z-A',
                  child: Text('Sort Z-A'),
                ),
              ];
            },
          ),
        ],
      ),
      body: tasks.isEmpty
          ? Center(child: Text('No tasks available'))
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          Color priorityColor;

          // Set the priority color based on priority
          switch (task.priority) {
            case 0:
              priorityColor = Colors.green; // Low
              break;
            case 1:
              priorityColor = Colors.yellow; // Medium
              break;
            case 2:
              priorityColor = Colors.red; // High
              break;
            default:
              priorityColor = Colors.grey;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: _getCardColor(task.priority), // Set card color based on priority
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  task.titel,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  'Priority: ${task.priority == 2 ? "High" : task.priority == 1 ? "Medium" : "Low"}',
                  style: TextStyle(color: priorityColor, fontSize: 16),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _showCustomDialog(context, task: task);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteTask(task.id!);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          _showCustomDialog(context);
        },
      ),
    );
  }
}