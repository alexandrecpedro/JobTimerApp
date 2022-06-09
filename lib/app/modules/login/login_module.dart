import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/modules/login/controller/login_controller.dart';
import 'package:job_timer/app/modules/login/login_page.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
    // No one needs to access (it is a bloc)
    // AuthService -> AppModule (Modular structure = i)
    BlocBind.lazySingleton((i) => LoginController(authService: i())),
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => LoginPage(controller: Modular.get(),)),
      ];
}
