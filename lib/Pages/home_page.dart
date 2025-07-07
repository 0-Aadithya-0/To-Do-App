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

  Database db = Database();

  @override
  void initState() {
    super.initState();
    final myBox = Hive.box("MyBox");
    if (myBox.get("TO-DO") == null) {
      db.Firsttime_init();
    } else {
      db.db_load();
    }
  }

  void onReorderTiles(oldindex,newindex){
    setState(() {
      if(oldindex < newindex){
        newindex --;
      }
      final List tile = db.tasks.removeAt(oldindex);
      db.tasks.insert(newindex, tile); 
    });
    db.db_update();

  }

  void onSave() {
    setState(() {
      db.tasks.add([controller.text, false]);
    });
    db.db_update();
    controller.clear();
    Navigator.of(context).pop();
  }

  void onCancel() {
    controller.clear();
    Navigator.of(context).pop();
  }

  void deleteTile(int index) {
    setState(() {
      db.tasks.removeAt(index);
    });
    db.db_update();
  }

  void touchToggle(int index) {
    setState(() {
  db.tasks[index][1]= !db.tasks[index][1];
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
                Oncancel: onCancel,
                Onsave: onSave,
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

        child: ReorderableListView.builder(
          proxyDecorator: (Widget child, int index, Animation<double> animation) {
            return Material(
              color: Colors.transparent,
              elevation: 10.0, 
              shadowColor: Colors.black,
              child: child, // The original child is placed inside our new widget.
              );
          },
          onReorder: (oldIndex, newIndex) => onReorderTiles(oldIndex,newIndex) ,
          itemCount: db.tasks.length,
          itemBuilder: (context, index) {
            return Tile(
              key: ValueKey(db.tasks[index]),
              taskname: db.tasks[index][0],
              touch: db.tasks[index][1],
              delete_function: (context) => deleteTile(index),
              touch_function: () => touchToggle(index),
            );
          },
        ),
      ),
    );
  }
}
