import 'package:get/get.dart';
import 'package:una_agendamento/app/modules/login/login_controller.dart';

class LoginBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}