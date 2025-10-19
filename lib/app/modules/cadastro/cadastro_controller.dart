import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CadastroController extends GetxController {
  final nomeInput = TextEditingController();
  final raInput = TextEditingController();
  final emailInput = TextEditingController();
  final senhaInput = TextEditingController();
  final confirmarSenhaInput = TextEditingController();

  // Variáveis de erro reativas
  final RxnString errorNome = RxnString(null);
  final RxnString errorRA = RxnString(null);
  final RxnString errorEmail = RxnString(null);
  final RxnString errorSenha = RxnString(null);
  final RxnString errorConfirmSenha = RxnString(null);

  bool validateCampos() {
    bool isValid = true;

    if (nomeInput.text.isEmpty) {
      errorNome.value = 'Preencha o nome';
      isValid = false;
    } else {
      errorNome.value = null;
    }

    if (raInput.text.isEmpty) {
      errorRA.value = 'Preencha o RA';
      isValid = false;
    } else if (raInput.text.length != 12) {
      errorRA.value = 'O RA deve ter 12 dígitos';
      isValid = false;
    } else {
      errorRA.value = null;
    }

    if (emailInput.text.isEmpty) {
      errorEmail.value = 'Preencha o email';
      isValid = false;
    } else {
      errorEmail.value = null;
    }

    if (senhaInput.text.isEmpty) {
      errorSenha.value = 'Preencha a senha';
      isValid = false;
    } else if (senhaInput.text.length < 8) {
      errorSenha.value = 'A senha deve ter ao menos 8 caracteres';
      isValid = false;
    } else {
      errorSenha.value = null;
    }

    if (confirmarSenhaInput.text.isEmpty) {
      errorConfirmSenha.value = 'Confirme a senha';
      isValid = false;
    } else if (confirmarSenhaInput.text != senhaInput.text) {
      errorConfirmSenha.value = 'As senhas não conferem';
      isValid = false;
    } else {
      errorConfirmSenha.value = null;
    }

    return isValid;
  }

  @override
  void onClose() {
    nomeInput.dispose();
    raInput.dispose();
    emailInput.dispose();
    senhaInput.dispose();
    confirmarSenhaInput.dispose();
    super.onClose();
  }
}
