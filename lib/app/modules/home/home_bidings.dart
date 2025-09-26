import 'package:get/get.dart';
import 'package:una_agendamento/app/modules/home/home_controller.dart';

class HomeBidings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> HomeController());
  }
}