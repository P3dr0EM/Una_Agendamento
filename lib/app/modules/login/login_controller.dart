// ignore_for_file: avoid_print

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/app/routes/app_routes.dart';
import 'package:una_agendamento/conexao_bd/conexao.bd.dart';

class LoginController extends GetxController {
  TextEditingController emailInput =
      TextEditingController(); // variável de controle do campo de email
  TextEditingController senhaInput =
      TextEditingController(); // variável de controle do campo de senha
  final RxnString errorEmail = RxnString(
    null,
  ); // variável observável de erro do EmailField
  final RxnString errorPassword = RxnString(
    null,
  ); // variável observável de erro do PasswordField

  // Login fixo de admin
  static const adminEmail = "admin@admin.com";
  static const adminSenha = "admin";

  // Função de login
  Future<void> logar() async {
    // Verificar campos vazios primeiro
    if (!validateEmail() || !validatePassword()) return;

    final email = emailInput.text;
    final senha = senhaInput.text;

    bool valido = false;

    // Primeiro verifica login admin fixo
    if (email == adminEmail && senha == adminSenha) {
      valido = true;
    } else {
      // Depois verifica no banco de dados
      valido = await validarLogin(email, senha);
    }

    if (valido) {
      login(); // vai pra home
    } else {
      printError("E-mail ou senha inválidos!");
      errorEmail.value = "E-mail ou senha inválidos!";
      errorPassword.value = "E-mail ou senha inválidos!";
    }
  }

  void printError(String error) {
    print(error);
  }

  void login() {
    Get.offAllNamed(Routes.HOME);
  }

  // Verificação de campo de email vazio
  bool validateEmail() {
    if (emailInput.text.isEmpty) {
      errorEmail.value = "Preencha o E-mail!";
      return false;
    } else {
      errorEmail.value = null;
      return true;
    }
  }

  // Verificação de campo de senha vazio
  bool validatePassword() {
    if (senhaInput.text.isEmpty) {
      errorPassword.value = "Preencha sua senha!";
      return false;
    } else {
      errorPassword.value = null;
      return true;
    }
  }

  @override
  void onClose() {
    emailInput.dispose();
    senhaInput.dispose();
    super.onClose();
  }
}
