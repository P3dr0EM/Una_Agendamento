import 'package:get/get.dart';
import 'package:una_agendamento/app/modules/cadastro/cadastro_controller.dart';

class CadastroBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CadastroController());
  }
}
