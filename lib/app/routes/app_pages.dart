import 'package:get/get_navigation/get_navigation.dart';
import 'package:una_agendamento/app/modules/home/home.view.dart';
import 'package:una_agendamento/app/modules/home/home_bidings.dart';
import 'package:una_agendamento/app/modules/login/login.view.dart';
import 'package:una_agendamento/app/modules/login/login_bidings.dart';
import 'package:una_agendamento/app/routes/app_routes.dart';

class AppPages {
  //Define a rota inicial do app
  // ignore: constant_identifier_names
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: LoginBidings()
    ),

    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBidings()
    )
  ];
}
