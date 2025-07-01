import 'package:hive_flutter/hive_flutter.dart';
class Database {
  final MyBox = Hive.openBox("MyBox");

  List tasks=[];
}
