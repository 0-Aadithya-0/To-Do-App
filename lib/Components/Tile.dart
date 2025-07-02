import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class Tile extends StatelessWidget{
  final String taskname;
  final bool touch;
  final Function() touch_function;
  //final bool init_touched;
  final Function(BuildContext)? delete_function;

  Tile({
    super.key,
    required this.taskname,
    required this.delete_function,
    required this.touch_function, 
    required this.touch,
    
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
      child: GestureDetector(
        onTap: touch_function,
        child: Slidable(
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                borderRadius: BorderRadius.circular(12),
                onPressed: delete_function,
                icon: Icons.delete,
                backgroundColor: const Color.fromARGB(255, 237, 61, 49),
              ),
            ],
          ),

          child: Container(
            width: 400,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: touch ? Colors.grey.shade600 : Colors.amberAccent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              taskname,
              textAlign: TextAlign.center,

              style: TextStyle(
                fontSize: touch ? 17 : 18,
                decoration:
                    touch
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                decorationThickness: 3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}