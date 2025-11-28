// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:una_agendamento/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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

  // Adicione uma variável para controlar o estado de "carregando"
  final RxBool isLoading = false.obs;

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

  // Metodo para cadastro e usuario e chamda de API
  Future<void> cadastrarUsuario() async {
    // validar os campos
    if (!validateCampos()) {
      Get.snackbar(
        'Erro',
        'Por favor, corriga os erros no formulario.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // se a validacao passou, ativa o carregando
    isLoading.value = true;

    final url = Uri.parse('http://10.0.2.2:8080/usuario');

    // aqui se cria o corpo da requisição (dados em JSON)
    try {
      final body = jsonEncode({
        'nome': nomeInput.text,
        'cpf': cpfInput.text,
        'email': emailInput.text,
        'senha': senhaInput.text,
        'telefone': dddInput.text + telefoneInput.text,
      });

      // aqui fazemos a requisicao POST
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: body,
      );

      // verifica a resposta do servidor
      if (response.statusCode == 200 || response.statusCode == 201) {
        // sucesso
        Get.snackbar(
          'Sucesso',
          'Usuario cadastrado com sucesso!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // navega para tela de login
        Get.offNamed(Routes.LOGIN);
      } else {
        // mensageem de erro com a resposta do servidor
        Get.snackbar(
          'Erro no cadastro',
          'Não foi possivel cadastrar. Erro ${response.statusCode})',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print('Erro: ${response.body}');
      }
    } catch (e) {
      // Erro de conexão (servidor desligado, sem internet, etc)
      Get.snackbar(
        'Erro na Conexao',
        'Não foi possivel conectar ao servidor. Tente mais tarde',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Erro de Conexão: $e');

      // Desliga o "Carregando"
    } finally {
      isLoading.value = false;
    }
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
