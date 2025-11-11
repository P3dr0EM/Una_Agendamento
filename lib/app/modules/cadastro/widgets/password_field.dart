import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Importe Getx para GetView
import 'package:una_agendamento/app/modules/cadastro/cadastro_controller.dart';

class PasswordField extends GetView<CadastroController> {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Obx(
        () => TextFormField(
          // Usando TextFormField, que é ideal para validação
          controller: controller.senhaInput,
          obscureText: true,
          keyboardType: TextInputType.text,
          focusNode: controller.senhaFocus,

          // Ação para o último campo deve ser 'done' (Concluído)
          textInputAction: TextInputAction.done,

          onFieldSubmitted: (_) {
            // Se a senha é o último campo, chame a validação e feche o teclado.
            // A chamada de foco para o DDD estava incorreta para o fluxo do formulário.

            // 1. Fecha o teclado
            FocusScope.of(context).unfocus();

            // 2. Opcional: Chama a validação imediatamente
            // controller.validateCampos();
          }, // <-- Parênteses e chaves corrigidos
          decoration: InputDecoration(
            label: const Text("SENHA"),
            errorText: controller.errorSenha.value,
            counterText: '', // Remove o contador de caracteres
          ),
        ),
      ),
    );
  }
}
