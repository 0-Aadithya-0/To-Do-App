import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Tile extends StatefulWidget {
  final String taskname;
  final bool init_touched;
  final Function(BuildContext)? delete_function;

  Tile({
    super.key,
    required this.taskname,
    required this.delete_function,
    required this.init_touched,
  });

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  late bool is_touched;
  @override
  void initState() {
    super.initState();

    is_touched = widget.init_touched;
  }

  void touch() {
    setState(() {
      is_touched = !is_touched;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
      child: GestureDetector(
        onTap: touch,
        child: Slidable(
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                borderRadius: BorderRadius.circular(12),
                onPressed: widget.delete_function,
                icon: Icons.delete,
                backgroundColor: const Color.fromARGB(255, 237, 61, 49),
              ),
            ],
          ),

          child: Container(
            width: 400,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: is_touched ? Colors.grey.shade600 : Colors.amberAccent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              widget.taskname,
              textAlign: TextAlign.center,

              style: TextStyle(
                fontSize: is_touched ? 17 : 18,
                decoration:
                    is_touched
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
