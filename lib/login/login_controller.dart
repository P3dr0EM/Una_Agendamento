import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/home/home.view.dart';
import 'package:una_agendamento/login/widgets/email_field.dart';

class LoginController extends GetxController{
    TextEditingController emailInput = TextEditingController(); //criação da variável de controle do campo de email
    TextEditingController senhaInput = TextEditingController(); //criação da variável de controle do campo de senha
    final RxnString errorEmail = RxnString(null); //criação da variável observável de erro do EmailField
    final RxnString errorPassword = RxnString(null);//criação da variável observável de erro do PasswordField

    //Debug de validação de email e senha. Deverá ser feito com integração do Back-End com o Banco de Dados
    static const email = "admin@admin.com";
    static const senha = "admin";

    void logar(){
      switch (emailInput.text) {
        case email:
          checkPassword();
          break;
        case '':
          printError('Insira um email.');
          EmailField();
          break;
        default:
          printError('Email Inválido!');
      }
    }

    void checkPassword(){
      switch (senhaInput.text) {
        case senha:
          login();
          break;
        case '':
          printError('Insira sua senha!');
        default:
          printError('Senha Incorreta!');
      }
    }

    void printError(String error){
      // ignore: avoid_print
      print(error);
    }

    void login(){
      Get.to(HomeView());
    }

    //criação da função de verificação de campo de email vazio
    bool validateEmail(){
      if(emailInput.text.isEmpty){
        errorEmail.value = "Preencha o E-mail!";
        return false;
      }
      else{
        errorEmail.value = null;
        return true;
      }
    }
  //criação da função de verificação de campo de senha vazio
  bool validatePassword(){
      if(senhaInput.text.isEmpty){
        errorPassword.value = "Preencha sua senha!";
        return false;
      }
      else{
        errorPassword.value = null;
        return true;
      }
    }

    @override
  void onClose() {
    emailInput.dispose();
    super.onClose();
  }
}