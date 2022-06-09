import 'dart:js';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/modules/project/register/controller/project_register_controller.dart';
import 'package:job_timer/app/modules/project/register/project_register_page.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class ProjectRegisterModule extends Module {
  /** Methods **/
  @override
  List<Bind<Object>> get binds => [
        // ProjectService comes from AppModule
        BlocBind.lazySingleton(
            (i) => ProjectRegisterController(projectService: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => ProjectRegisterPage(
            controller: Modular.get(),
          ),
        ),
      ];
}
