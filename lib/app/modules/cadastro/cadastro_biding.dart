import 'package:get/get.dart';
import 'package:una_agendamento/app/modules/cadastro/cadastro_controller.dart';

class CadastroBiding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CadastroController());
  }
}
