import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:una_agendamento/app/modules/cadastro/cadastro_controller.dart';

//Construção do Widget do Campo de Email
class PasswordConfirmField extends GetView<CadastroController> {
  const PasswordConfirmField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Obx(
        () => TextField(
          controller: controller
              .confirmarSenhaInput, //chama o controlador do campo de texto
          obscureText: true,
          decoration: InputDecoration(
            label: const Text("CONFIRMAR SENHA"),
            errorText: controller
                .errorConfirmSenha
                .value, //chama o controlador de erro
          ),
        ),
      ),
    );
  }
}
