import 'package:flutter/material.dart';

class TodoContainer extends StatelessWidget {
  const TodoContainer(
      {required this.toDoTitle, required this.onRemoveIconPressed, super.key, this.onTap});

  final String toDoTitle;
  final VoidCallback onRemoveIconPressed;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: InkWell(
        onTap: onTap,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    toDoTitle,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              IconButton(
                  onPressed: onRemoveIconPressed,
                  icon: const Icon(Icons.delete, size: 24))
            ],
          ),
        ),
      ),
    );
  }
}
