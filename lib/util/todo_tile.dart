import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

// ignore: must_be_immutable
class ToDoTile extends StatefulWidget {
  final String taskName;
  final bool taskCompleted;
  Color mainColor;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  Function(Color?)? onMainColorChanged;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    required this.mainColor,
    required this.onMainColorChanged,
  });

  @override
  State<ToDoTile> createState() => _ToDoTileState();
}

class _ToDoTileState extends State<ToDoTile> {
  Color? _tempMainColor;

  @override
  Widget build(BuildContext context) {
    void showColorDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return SizedBox(
                height: 50,
                child: Scaffold(
                    body: Column(
                  children: [
                    MaterialColorPicker(
                        selectedColor: widget.mainColor,
                        allowShades: false,
                        onMainColorChange: (color) =>
                            {setState(() => _tempMainColor = color)}),
                    Row(
                      children: [
                        TextButton(
                          child: const Text("Choose"),
                          onPressed: () {
                            setState(
                                () => {widget.mainColor = _tempMainColor!});
                            widget.onMainColorChanged!(widget.mainColor);
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    )
                  ],
                )));
          });
    }

    return SizedBox(
      height: 110,
      child: Scaffold(
        body: Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: widget.deleteFunction,
                icon: Icons.delete,
                backgroundColor: Colors.red.shade300,
                borderRadius: BorderRadius.circular(12),
              )
            ],
          ),
          child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: widget.mainColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      showColorDialog();
                    },
                    icon: const Icon(Icons.color_lens),
                    color: Colors.white,
                  ),
                  // checkbox
                  Checkbox(
                    value: widget.taskCompleted,
                    onChanged: widget.onChanged,
                    activeColor: Colors.black,
                  ),

                  // task name
                  Flexible(
                      child: Text(
                    widget.taskName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      decoration: widget.taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ))
                ],
              )),
        ),
      ),
    );
  }
}
