import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/core/ui/button_with_loader.dart';
import 'package:job_timer/app/modules/project/register/controller/project_register_controller.dart';
import 'package:validatorless/validatorless.dart';

// A form should be StatefulWidget
class ProjectRegisterPage extends StatefulWidget {
  /** Attributes **/
  final ProjectRegisterController controller;

  /** Constructor **/
  const ProjectRegisterPage({super.key, required this.controller});

  @override
  State<ProjectRegisterPage> createState() => _ProjectRegisterPageState();
}

/** Class **/
class _ProjectRegisterPageState extends State<ProjectRegisterPage> {
  /** Attributes  **/
  // It is necessary to make a disposal of controllers that will be used
  // formKey => validate the Form
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _estimateEC = TextEditingController();

  /** Methods **/
  @override
  void dispose() {
    // Global Key does not need _nameEC and _estimateEC
    _nameEC.dispose();
    _estimateEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectRegisterController, ProjectRegisterStatus>(
      bloc: widget.controller,
      listener: (context, state) {
        switch (state) {
          case ProjectRegisterStatus.success:
            // Return to previous page
            Navigator.pop(context);
            break;
          case ProjectRegisterStatus.failure:
            AsukaSnackbar.alert('Error while saving project').show();
            break;
          default:
            break;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Create new project',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameEC,
                  decoration: const InputDecoration(
                    label: Text('Project name'),
                  ),
                  // Form validation
                  validator: Validatorless.required("Name mandatory"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _estimateEC,
                  // Keyboard with only numbers
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Estimated hours'),
                  ),
                  // Form validation
                  validator: Validatorless.multiple([
                    Validatorless.required('Estimated hours mandatory'),
                    Validatorless.number('Only numbers allowed'),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 49,
                  child: ButtonWithLoader<ProjectRegisterController, ProjectRegisterStatus>(
                    bloc: widget.controller,
                    selector: (state) => state == ProjectRegisterStatus.loading,
                    onPressed: () async {
                      final formValid =
                          _formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        final name = _nameEC.text;
                        final estimate = int.parse(_estimateEC.text);

                        await widget.controller.register(name, estimate);
                      }
                    },
                    label: 'Save',
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
