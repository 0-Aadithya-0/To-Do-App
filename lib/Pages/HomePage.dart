import 'package:flutter/material.dart';
import 'package:to_do/Components/Popbox.dart';
import 'package:to_do/Components/Tile.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do/data/database.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final controller = TextEditingController();

  final Mybox = Hive.box("MyBox");
  Database db = Database();

  @override
  void initState() {
    super.initState();

    if (Mybox.get("TO-DO") == null) {
      db.Firsttime_init();
    } else {
      db.db_load();
    }
  }

  void Onsave() {
    setState(() {
      db.tasks.add([controller.text, false]);
    });
    db.db_update();
    controller.clear();
    Navigator.of(context).pop();
  }

  void Oncancel() {
    controller.clear();
    Navigator.of(context).pop();
  }

  void delete_tile(int index) {
    setState(() {
      db.tasks.removeAt(index);
    });
    db.db_update();
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
          itemCount: db.tasks.length,
          itemBuilder: (context, index) {
            return Tile(
              taskname: db.tasks[index][0],
              delete_function: (context) => delete_tile(index),
              init_touched: db.tasks[index][1],
            );
          },
        ),
      ),
    );
  }
}
