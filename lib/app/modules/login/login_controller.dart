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

  // Login fixo de admin (Mantido como "Backdoor" ou teste local)
  static const adminEmail = "admin@admin.com";
  static const adminSenha = "admin";

  Future<void> tryToGoogleLogin() async {
    print('LOGAR COM GOOGLE!');
  }

  // --- FUNÇÃO PRINCIPAL DE LOGIN ---
  Future<void> logar() async {
    // 1. Validação básica de UI
    if (!validateEmail() || !validatePassword()) return;

    final email = emailInput.text;
    final senha = senhaInput.text;

    bool loginSucesso = false;

    // 2. Primeiro verifica se é o Admin Fixo (local)
    if (email == adminEmail && senha == adminSenha) {
      print("Logado como Admin Fixo");
      loginSucesso = true;
    } else {
      // 3. Se não for admin, chama o SPRING BOOT
      print("Tentando logar via API...");
      loginSucesso = await validarLogin(email, senha);
    }

    // 4. Redirecionamento
    if (loginSucesso) {
      login(); // Vai pra home
    } else {
      printError("E-mail ou senha inválidos!");
      errorEmail.value = "Dados incorretos";
      errorPassword.value = "Dados incorretos";
      
      // Opcional: Mostrar um SnackBar do GetX para ficar mais visível
      Get.snackbar(
        "Erro no Login", 
        "Verifique suas credenciais e tente novamente.",
        backgroundColor: const Color(0xFFFFCCCC),
        snackPosition: SnackPosition.BOTTOM
      );
    }
  }

  // --- CHAMADA HTTP AO SPRING BOOT ---
  Future<bool> validarLogin(String email, String senha) async {
    try {
      // ENDEREÇO DO EMULADOR ANDROID -> SPRING BOOT
      // Se fosse no iOS seria localhost, mas no Android é 10.0.2.2
      final url = Uri.parse('http://10.0.2.2:8080/auth/login');
      
      final body = jsonEncode({'email': email, 'senha': senha});

      print("Enviando POST para: $url");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );

      print("Resposta Status: ${response.statusCode}");
      print("Resposta Body: ${response.body}");

      if (response.statusCode == 200) {
        // SUCESSO!
        final Map<String, dynamic> dados = jsonDecode(response.body);
        String token = dados['token'];
        
        print("✅ TOKEN RECEBIDO DO JAVA: $token");
        // Futuramente salva esse token no GetStorage ou SharedPreferences
        
        return true;
      } else {
        // ERRO (401, 403, 500)
        print("❌ Falha no login: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("❌ Erro CRÍTICO de conexão: $e");
      // Dica: Verifique se o backend está rodando e se a internet do emulador funciona
      return false;
    }
  }

  void printError(String error) {
    print(error);
  }

  void login() {
    Get.offAllNamed(Routes.HOME);
  }

  bool validateEmail() {
    if (emailInput.text.isEmpty) {
      errorEmail.value = "Preencha o E-mail!";
      return false;
    } else {
      errorEmail.value = null;
      return true;
    }
  }

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
