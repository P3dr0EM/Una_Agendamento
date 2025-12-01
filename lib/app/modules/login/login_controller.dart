// ignore_for_file: avoid_print

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/app/routes/app_routes.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  TextEditingController emailInput = TextEditingController();
  TextEditingController senhaInput = TextEditingController();

  final RxnString errorEmail = RxnString(null);
  final RxnString errorPassword = RxnString(null);

  static const adminEmail = "admin@admin.com";
  static const adminSenha = "admin";

  // ------------------ GOOGLE LOGIN ------------------
  Future<void> tryToGoogleLogin() async {
    print("LOGAR COM GOOGLE!");
    // Aqui futuramente entra a lógica do Firebase Auth
  }

  // ------------------ LOGIN PRINCIPAL ------------------

  Future<void> logar() async {
    if (!validateEmail() || !validatePassword()) return;

    final email = emailInput.text;
    final senha = senhaInput.text;

    bool isValid = false;

    // Login ADMIN local
    if (email == adminEmail && senha == adminSenha) {
      isValid = true;
    } else {
      // Login via API
      isValid = await validarLogin(email, senha);
    }

    if (isValid) {
      login();
    } else {
      printError("E-mail ou senha inválidos!");
      errorEmail.value = "E-mail ou senha inválidos!";
      errorPassword.value = "E-mail ou senha inválidos!";
    }
  }

  // ------------------ BACK-END ------------------

  Future<bool> validarLogin(String email, String senha) async {
    try {
      final url = Uri.parse('http://10.0.2.2:8080/login');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'email': email, 'senha': senha}),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Erro ao conectar com a API: $e");
      return false;
    }
  }

  // ------------------ AUXILIARES ------------------

  void login() {
    Get.offAllNamed(Routes.HOME);
  }

  void printError(String error) {
    print('ERRO: $error');
  }

  bool validateEmail() {
    return _validateField(
      text: emailInput.text,
      errorRx: errorEmail,
      validators: [
        (t) => t.isEmpty ? "Preencha o email" : null,
        (t) => !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(t)
            ? "Email inválido"
            : null,
      ],
    );
  }

  bool validatePassword() {
    final email = emailInput.text;
    final senha = senhaInput.text;

    // Permite admin com senha curta
    if (email == adminEmail && senha == adminSenha) {
      return _validateField(
        text: senha,
        errorRx: errorPassword,
        validators: [(t) => t.isEmpty ? "Preencha a senha" : null],
      );
    }

    return _validateField(
      text: senha,
      errorRx: errorPassword,
      validators: [
        (t) => t.isEmpty ? "Preencha a senha" : null,
        (t) => t.length < 8 ? "A senha deve ter pelo menos 8 caracteres" : null,
      ],
    );
  }

  bool _validateField({
    required String text,
    required RxnString errorRx,
    required List<String? Function(String)> validators,
  }) {
    for (var validator in validators) {
      final result = validator(text);
      if (result != null) {
        errorRx.value = result;
        return false;
      }
    }
    errorRx.value = null;
    return true;
  }

  @override
  void onClose() {
    emailInput.dispose();
    senhaInput.dispose();
    super.onClose();
  }
}
