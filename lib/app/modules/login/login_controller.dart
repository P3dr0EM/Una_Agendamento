// ignore_for_file: avoid_print

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/app/routes/app_routes.dart';
import 'dart:convert'; // Importe para usar o jsonEncode
import 'package:http/http.dart' as http; // Importe o http

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

  Future<void> tryToGoogleLogin() async{
    print('LOGAR COM GOOGLE!');
  }

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
      print('Error');
    }

    if (valido) {
      login(); // vai pra home
    } else {
      printError("E-mail ou senha inválidos!");
      errorEmail.value = "E-mail ou senha inválidos!";
      errorPassword.value = "E-mail ou senha inválidos!";
    }
  }

  Future<bool> validarLogin(String email, String senha) async {
    // implementar a chamada HTTP para o seu Spring Boot aqui.

    try {
      final url = Uri.parse('http://10.0.2.2:8080/login'); // Exemplo de URL
      final body = jsonEncode({'email': email, 'senha': senha});

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      // Se o login for sucesso (ex: status 200), retorne true
      if (response.statusCode == 200) {
        return true;
      } else {
        // Se o back-end disser que o login falhou, retorne false
        return false;
      }
    } catch (e) {
      // Se houver um erro (sem internet, API desligada), retorne false
      print("Erro ao conectar com a API: $e");
      return false;
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
