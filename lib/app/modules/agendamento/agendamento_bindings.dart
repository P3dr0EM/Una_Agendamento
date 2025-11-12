import 'package:get/get.dart';
import 'package:una_agendamento/app/modules/agendamento/agendamento_controller.dart';

class AgendamentoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AgendamentoController>(() => AgendamentoController());
  }
}