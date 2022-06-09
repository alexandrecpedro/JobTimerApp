import 'package:flutter/material.dart';

class ProjectDetailAppbar extends SliverAppBar {
  /** Constructor **/
  ProjectDetailAppbar({super.key})
      : super(
          expandedHeight: 100,
          pinned: true,
          toolbarHeight: 100,
          title: const Text('Project X'),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          flexibleSpace: Stack(
            children: [
              Align(
                // Alignment(x, y) => y = 1 (bottom) || y = 0 (top)
                alignment: const Alignment(0, 1.6),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    // elevating the Stack
                    elevation: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('10 tasks'),
                          _NewTasks(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
}

/** COMPONENTS **/

/// BUTTON
class _NewTasks extends StatelessWidget {
  // Constructor
  const _NewTasks({super.key});

  // Methods
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        const Text('Add Task'),
      ],
    );
  }
}
