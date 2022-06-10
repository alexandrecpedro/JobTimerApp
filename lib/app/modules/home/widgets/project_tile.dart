import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/core/ui/job_timer_icons.dart';
import 'package:job_timer/app/modules/home/controller/home_controller.dart';
import 'package:job_timer/app/view_models/project_model.dart';

class ProjectTile extends StatelessWidget {
  /** Attributes **/
  final ProjectModel projectModel;

  /** Constructor **/
  const ProjectTile({super.key, required this.projectModel});

  /** Methods **/
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Modular.to.pushNamed('project/detail', arguments: projectModel);
        Modular.get<HomeController>().updateList();
      },
      child: Container(
        // set a min/max value
        constraints: const BoxConstraints(maxHeight: 90),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            // forced color (no null)
            color: Colors.grey[300]!,
            width: 4,
          ),
        ),
        child: Column(
          children: [
            _ProjectName(projectModel: projectModel),
            // expand component to all screen
            Expanded(child: _ProjectProgress(projectModel: projectModel)),
          ],
        ),
      ),
    );
  }
}

/** COMPONENTS **/

/** ProjectName Component **/
class _ProjectName extends StatelessWidget {
  // Attributes
  final ProjectModel projectModel;

  // Constructor
  const _ProjectName({required this.projectModel});

  // Methods
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        // space-between elements
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(projectModel.name),
          Icon(
            JobTimerIcons.angle_double_right,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}

/** ProjectProgress Component **/
class _ProjectProgress extends StatelessWidget {
  // Attributes
  final ProjectModel projectModel;

  // Constructor
  const _ProjectProgress({required this.projectModel});

  // Methods
  @override
  Widget build(BuildContext context) {
    // Creating variables
    // Obs.: Reduce (JavaScript) = Fold (Dart)
    final totalTasks = projectModel.tasks
        .fold<int>(0, (previousValue, task) => previousValue += task.duration);
    var percent = 0.0;

    if (totalTasks > 0) {
      percent = totalTasks / projectModel.estimate;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300]!,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          // LinearProgressIndicator has an inifinite size. Should be involved with Expanded
          Expanded(
            child: LinearProgressIndicator(
              value: percent,
              backgroundColor: Colors.grey[400]!,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text('${projectModel.estimate}h'),
          ),
        ],
      ),
    );
  }
}
