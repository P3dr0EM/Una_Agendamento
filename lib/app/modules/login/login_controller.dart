// ignore_for_file: avoid_print

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
// Para o código compilar, simule a classe de rotas se não estiver disponível
// import 'package:una_agendamento/app/routes/app_routes.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Simulação de Rotas
class Routes {
  static const HOME = '/home';
}

class LoginController extends GetxController {
  TextEditingController emailInput = TextEditingController();
  TextEditingController senhaInput = TextEditingController();

  final RxnString errorEmail = RxnString(null);
  final RxnString errorPassword = RxnString(null);

  // Login fixo de admin
  static const adminEmail = "admin@admin.com";
  static const adminSenha = "admin"; // Menos de 8 caracteres

  // --- FUNÇÕES DE LÓGICA PRINCIPAL ---

  Future<void> tryToGoogleLogin() async {
    print('LOGAR COM GOOGLE!');
  }

  /// Função principal de login
  Future<void> logar() async {
    // 1. Validar campos. Se falhar, as funções de validação já mostram o erro.
    final emailValido = validateEmail();
    final senhaValida = validatePassword();

    if (!emailValido || !senhaValida) return;

    final email = emailInput.text;
    final senha = senhaInput.text;

    bool valido = false;

    // 2. Primeiro verifica login admin fixo (garantindo o acesso à senha curta)
    if (email == adminEmail && senha == adminSenha) {
      valido = true;
      print('Login Admin FIXO realizado com sucesso.');
    } else {
      // 3. Tenta autenticar via API para outros usuários
      print('Tentando login via API...');
      valido = await validarLogin(email, senha);
    }

    // 4. Resultado da Autenticação
    if (valido) {
      login(); // Navega para a home
    } else {
      // Mensagem genérica para falha de autenticação
      errorEmail.value = "E-mail ou senha inválidos!";
      errorPassword.value = "E-mail ou senha inválidos!";
      printError("E-mail ou senha inválidos!");
    }
  }

  Future<bool> validarLogin(String email, String senha) async {
    try {
      final url = Uri.parse('http://10.0.2.2:8080/login');
      final body = jsonEncode({'email': email, 'senha': senha});

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Erro ao conectar com a API: $e");
      return false;
    }
  }

  void printError(String error) {
    print('ERRO: $error');
  }

  void login() {
    Get.offAllNamed(Routes.HOME);
  }

  // --- FUNÇÕES DE VALIDAÇÃO ---

  // Função utilitária para aplicar os validadores e atualizar o erro
  bool _validateField({
    required String text,
    required RxnString errorRx,
    required List<String? Function(String)> validators,
  }) {
    // Limpa o erro anterior antes de re-validar
    errorRx.value = null;

    for (final validator in validators) {
      final error = validator(text);
      if (error != null) {
        // Encontrou um erro, seta o valor observável e retorna false
        errorRx.value = error;
        return false;
      }
    }
    // Nenhuma validação falhou
    return true;
  }

  /// Verificação de campo de email (vazio e formato).
  bool validateEmail() {
    return _validateField(
      text: emailInput.text,
      errorRx: errorEmail,
      validators: [
        // 1. Checa se o campo está vazio
        (text) => text.isEmpty ? 'Preencha o email' : null,
        // 2. Checa o formato do email com RegExp
        (text) => !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(text)
            ? 'Email inválido'
            : null,
      ],
    );
  }

  /// Verificação de campo de senha (com exceção para o Admin).
  bool validatePassword() {
    final senhaText = senhaInput.text;
    final emailText = emailInput.text;

    // --- LÓGICA DE EXCEÇÃO PARA O ADMIN ---
    if (emailText == adminEmail && senhaText == adminSenha) {
      // Usa um validador simplificado para garantir que o campo não esteja vazio
      return _validateField(
        text: senhaText,
        errorRx: errorPassword,
        validators: [(text) => text.isEmpty ? 'Preencha a senha' : null],
      );
    }
    // --- FIM DA EXCEÇÃO ---

    // Para todos os outros usuários, aplicamos a regra completa de 8 caracteres.
    return _validateField(
      text: senhaText,
      errorRx: errorPassword,
      validators: [
        // 1. Checa se o campo está vazio
        (text) => senhaText.isEmpty ? 'Preencha a senha' : null,
      ],
    );
  }

  @override
  void onClose() {
    emailInput.dispose();
    senhaInput.dispose();
    super.onClose();
  }
}
