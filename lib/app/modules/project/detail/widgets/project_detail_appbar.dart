import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/modules/project/detail/controller/project_detail_controller.dart';
import 'package:job_timer/app/view_models/project_model.dart';

class ProjectDetailAppbar extends SliverAppBar {
  /** Constructor **/
  ProjectDetailAppbar({required ProjectModel projectModel, super.key})
      : super(
          expandedHeight: 100,
          pinned: true,
          toolbarHeight: 100,
          title: Text(projectModel.name),
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
                        children: [
                          Text('${projectModel.tasks.length} tasks'),
                          Visibility(
                            visible:
                                projectModel.status != ProjectStatus.finished,
                            replacement: const Text('Finished Project'),
                            child: _NewTasks(projectModel: projectModel),
                          ),
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
  // Attributes
  final ProjectModel projectModel;

  // Constructor
  const _NewTasks({Key? key, required this.projectModel}) : super(key: key);

  // Methods
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // update the screen
        await Modular.to.pushNamed('/project/task/', arguments: projectModel);
        // call controller
        Modular.get<ProjectDetailController>().updateProject();
      },
      child: Row(
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
      ),
    );
  }
}
