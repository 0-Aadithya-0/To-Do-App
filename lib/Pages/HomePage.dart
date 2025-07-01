import 'package:flutter/material.dart';
import 'package:to_do/Components/Popbox.dart';
import 'package:to_do/Components/Tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List tasks = [];
  final controller = TextEditingController();

  final Mybox = Hive.openBox("MyBox");

  void Onsave() {
    setState(() {
      tasks.add(controller.text);
    });
    controller.clear();
    Navigator.of(context).pop();
  }

  void Oncancel() {
    controller.clear();
    Navigator.of(context).pop();
  }

  void delete_tile(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 32, 32, 32),
      appBar: AppBar(
        title: Text("To-Do"),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
        elevation: 3,
        shadowColor: Colors.black,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Popbox(
                controller: controller,
                Oncancel: Oncancel,
                Onsave: Onsave,
              );
            },
          );
        },
        backgroundColor: Colors.amberAccent,
        foregroundColor: Colors.black,
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.only(top: 12),

        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return Tile(
              tasksname: tasks[index],
              delete_function: (context) => delete_tile(index),
            );
          },
        ),
      ),
    );
  }
}
