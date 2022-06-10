import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/core/ui/job_timer_icons.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/modules/project/detail/controller/project_detail_controller.dart';
import 'package:job_timer/app/modules/project/detail/widgets/project_detail_appbar.dart';
import 'package:job_timer/app/modules/project/detail/widgets/project_pie_chart.dart';
import 'package:job_timer/app/modules/project/detail/widgets/project_task_tile.dart';
import 'package:job_timer/app/view_models/project_model.dart';

class ProjectDetailPage extends StatelessWidget {
  /** Attributes **/
  final ProjectDetailController controller;

  /** Constructor **/
  const ProjectDetailPage({super.key, required this.controller});

  /** Methods **/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProjectDetailController, ProjectDetailState>(
        bloc: controller,
        listener: (context, state) {
          if (state.status == ProjectDetailStatus.failure) {
            AsukaSnackbar.alert('Intern error');
          }
        },
        builder: (context, state) {
          // Variables
          final projectModel = state.projectModel;

          switch (state.status) {
            case ProjectDetailStatus.initial:
              return const Center(
                child: Text('Loading project'),
              );
            case ProjectDetailStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ProjectDetailStatus.complete:
              return _buildProjectDetail(context, projectModel!);
            case ProjectDetailStatus.failure:
              if (projectModel != null) {
                return _buildProjectDetail(context, projectModel);
              }

              return const Center(
                child: Text('Error while loading project'),
              );
          }
        },
      ),
    );
  }

  Widget _buildProjectDetail(BuildContext context, ProjectModel projectModel) {
    // Variable
    final totalTask = projectModel.tasks.fold<int>(
      0,
      (totalValue, task) {
        return totalValue += task.duration;
      },
    );

    return CustomScrollView(
      slivers: [
        ProjectDetailAppbar(
          projectModel: projectModel,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.only(
                top: 50.0,
                bottom: 50,
              ),
              child: ProjectPieChart(
                projectEstimate: projectModel.estimate,
                totalTask: totalTask,
              ),
            ),
            // Destructuring
            ...projectModel.tasks
                .map(
                  (task) => ProjectTaskTile(
                    task: task,
                  ),
                )
                .toList(),
          ]),
        ),
        // Uses the remaining screen space => create a button
        SliverFillRemaining(
          hasScrollBody: false,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Visibility(
                visible: projectModel.status != ProjectStatus.finished,
                child: ElevatedButton.icon(
                  onPressed: () {
                    controller.finishProject();
                  },
                  icon: const Icon(JobTimerIcons.ok_circled2),
                  label: const Text('Finish Project'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
