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

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  final controller = TextEditingController();
  late TabController _tabController;
  Database db = Database();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    final myBox = Hive.box("MyBox");
    if (myBox.get("Daily") == null) {
      db.Firsttime_init();
    } else {
      db.loadDB();
    }
  }

  void onReorderTiles(oldindex, newindex, List list) {
    setState(() {
      if (oldindex < newindex) {
        newindex--;
      }
      final List tile = list.removeAt(oldindex);
      list.insert(newindex, tile);
    });
    db.updateDB();
  }

  void onSave() {
    setState(() {
      int currentIndex = _tabController.index;
      if (currentIndex == 0) {
        db.dailyTasks.add([controller.text, false]);
      } else if (currentIndex == 1) {
        db.weeklyTasks.add([controller.text, false]);
      } else {
        db.monthlyTasks.add([controller.text, false]);
      }
    });
    db.updateDB();
    controller.clear();
    Navigator.of(context).pop();
  }

  void onCancel() {
    controller.clear();
    Navigator.of(context).pop();
  }

  void deleteTile(int index, List list) {
    setState(() {
      list.removeAt(index);
    });
    db.updateDB();
  }

  void touchToggle(int index, List list) {
    setState(() {
      list[index][1] = !list[index][1];
    });
    db.updateDB();
  }

  Widget buildReorderableList(List taskList) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: ReorderableListView.builder(
        proxyDecorator: (
                    Widget child,
                    int index,
                    Animation<double> animation,
                  ) {
                    return Material(
                      color: Colors.transparent,
                      elevation: 10.0,
                      shadowColor: Colors.black,
                      child: child,
                    );
                  },
        onReorder: (oldIndex, newIndex) => onReorderTiles(oldIndex, newIndex, taskList),
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          return Tile(
            key: ValueKey(taskList[index]),
            taskname: taskList[index][0],
            touch: taskList[index][1],
            delete_function: (context) => deleteTile(index, taskList),
            touch_function: () => touchToggle(index, taskList),
          );
        },
      ),
    );
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
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black54,
          tabs: const [
            Tab(text: "Daily"),
            Tab(text: "Weekly"),
            Tab(text: "Monthly"),
          ],
        ),
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

      body: TabBarView(
        controller: _tabController,
        children: [
          
      buildReorderableList(db.dailyTasks),
               
      buildReorderableList(db.weeklyTasks),
      
      buildReorderableList(db.monthlyTasks),
        ]
      ),
    );
  }
}
