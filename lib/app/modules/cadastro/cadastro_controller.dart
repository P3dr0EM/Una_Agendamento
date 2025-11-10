import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CadastroController extends GetxController {
  final nomeFocus = FocusNode();
  final cpfFocus = FocusNode();
  final emailFocus = FocusNode();
  final senhaFocus = FocusNode();
  final dddFocus = FocusNode();
  final telefoneFocus = FocusNode();
  // Controladores de texto para os campos de entrada

  final nomeInput = TextEditingController();
  final cpfInput = TextEditingController();
  final emailInput = TextEditingController();
  final senhaInput = TextEditingController();
  final dddInput = TextEditingController();
  final telefoneInput = TextEditingController();

  // Variáveis de erro reativas
  final RxnString errorNome = RxnString(null);
  final RxnString errorCpf = RxnString(null);
  final RxnString errorEmail = RxnString(null);
  final RxnString errorSenha = RxnString(null);
  final RxnString errorddd = RxnString(null);
  final RxnString errorTelefone = RxnString(null);

  bool _validateField({
    required String text,
    required RxnString errorRx,
    required List<String? Function(String)> validators,
  }) {
    // Itera sobre as regras de validação
    for (var validator in validators) {
      String? errorMessage = validator(text);
      if (errorMessage != null) {
        errorRx.value = errorMessage;
        return false;
      }
    }
    // Se passar por todas as regras, limpa o erro
    errorRx.value = null;
    return true;
  }

  bool validateCampos() {
    // Use o operador & (AND bit a bit) para garantir que TODOS os campos
    // sejam avaliados e seus erros sejam exibidos ANTES de retornar o resultado.

    final nomeValid = _validateField(
      text: nomeInput.text,
      errorRx: errorNome,
      validators: [(text) => text.isEmpty ? 'Preencha o nome' : null],
    );

    final dddValid = _validateField(
      text: dddInput.text,
      errorRx: errorddd,
      validators: [
        (text) => text.isEmpty ? 'Preencha o DDD' : null,
        (text) => text.length < 2 ? 'DDD inválido' : null,
      ],
    );

    final telefoneValid = _validateField(
      text: telefoneInput.text,
      errorRx: errorTelefone,
      validators: [
        (text) => text.isEmpty ? 'Preencha o telefone' : null,
        (text) => text.length < 9 ? 'Telefone inválido' : null,
      ],
    );

    // Sugestão: o CPF não formatado tem 11 dígitos. Se for formatado, 14.
    // Mantenho 12 como você tinha, mas reavalie se é o correto para sua máscara.
    final cpfValid = _validateField(
      text: cpfInput.text,
      errorRx: errorCpf,
      validators: [
        (text) => text.isEmpty ? 'Preencha o CPF' : null,
        (text) => text.length < 11 ? 'CPF inválido' : null,
      ],
    );

    final emailValid = _validateField(
      text: emailInput.text,
      errorRx: errorEmail,
      validators: [
        (text) => text.isEmpty ? 'Preencha o email' : null,
        // (text) => !GetUtils.isEmail(text) ? 'Email inválido' : null, // Sugestão: use o validador GetX
        (text) => !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(text)
            ? 'Email inválido'
            : null,
      ],
    );

    final senhaValid = _validateField(
      text: senhaInput.text,
      errorRx: errorSenha,
      validators: [
        (text) => text.isEmpty ? 'Preencha a senha' : null,
        (text) =>
            text.length < 8 ? 'A senha deve ter ao menos 8 caracteres' : null,
      ],
    );

    // Retorna true APENAS se todos forem válidos
    return nomeValid &
        dddValid &
        telefoneValid &
        cpfValid &
        emailValid &
        senhaValid;
  }

  @override
  void onClose() {
    // Disposição dos FocusNodes adicionados
    nomeFocus.dispose();
    cpfFocus.dispose();
    emailFocus.dispose();
    senhaFocus.dispose();
    dddFocus.dispose();
    telefoneFocus.dispose();

    // Disposição dos TextEditingControllers
    nomeInput.dispose();
    cpfInput.dispose();
    dddInput.dispose();
    telefoneInput.dispose();
    emailInput.dispose();
    senhaInput.dispose();
    super.onClose();
  }
}
