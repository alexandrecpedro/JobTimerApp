import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/core/ui/button_with_loader.dart';
import 'package:job_timer/app/modules/project/task/controller/task_controller.dart';
import 'package:validatorless/validatorless.dart';

/** Controllers will be discarded, so it must be a StatefulWidget **/
class TaskPage extends StatefulWidget {
  //Attributes
  final TaskController controller;

  // Constructor
  const TaskPage({super.key, required this.controller});

  // Methods
  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  /** Attributes **/

  // Key for Form validation
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _durationEC = TextEditingController();

  /** Methods **/
  @override
  void dispose() {
    // EC = EditingController
    _nameEC.dispose();
    _durationEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskController, TaskStatus>(
      bloc: widget.controller,
      listener: (context, state) {
        if (state == TaskStatus.success) {
          // return to Detail Page
          Navigator.pop(context);
        } else if (state == TaskStatus.failure) {
          AsukaSnackbar.alert('Error while saving task').show();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add new task',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameEC,
                  decoration: const InputDecoration(
                    label: Text('Task Name'),
                  ),
                  validator: Validatorless.required('Name mandatory'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _durationEC,
                  decoration: const InputDecoration(
                    label: Text('Task Duration'),
                  ),
                  keyboardType: TextInputType.number,
                  validator: Validatorless.multiple([
                    Validatorless.required('Duration mandatory'),
                    Validatorless.number('Only numbers allowed'),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 49,
                  child: ButtonWithLoader<TaskController, TaskStatus>(
                    bloc: widget.controller,
                    selector: (state) => state == TaskStatus.loading,
                    label: 'Save',
                    onPressed: () {
                      final formValid =
                          _formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        final duration = int.parse(_durationEC.text);
                        // register
                        widget.controller.register(_nameEC.text, duration);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
