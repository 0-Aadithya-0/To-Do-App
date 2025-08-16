import 'package:hive_flutter/hive_flutter.dart';
class Database {
  final MyBox = Hive.box("MyBox");

  List dailyTasks=[];
  List weeklyTasks=[];
  List monthlyTasks=[];



  void Firsttime_init(){
    dailyTasks =[["Welcome to Daily Tasks!", false],["Long press and drag to reorder", false],["<-- Swipe to delete", false]];
    weeklyTasks =[["Weekly tasks",false]];
    monthlyTasks =[["Monthly Taks",false]];


  }

  void updateDB(){
    MyBox.put("Daily",dailyTasks);
    MyBox.put("Weekly", weeklyTasks);
    MyBox.put("Monthly", monthlyTasks);

  }
  void loadDB(){
    dailyTasks = MyBox.get("Daily");  
    weeklyTasks = MyBox.get("Weekly");  
    monthlyTasks = MyBox.get("Monthly");  
  }
}