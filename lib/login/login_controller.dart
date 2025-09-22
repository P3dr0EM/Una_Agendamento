import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/home/home.view.dart';
import 'package:una_agendamento/login/widgets/email_field.dart';

class LoginController extends GetxController{
    TextEditingController emailInput = TextEditingController();
    TextEditingController senhaInput = TextEditingController();
    final RxnString errorEmail = RxnString(null);
    final RxnString errorPassword = RxnString(null);

    //bebug realizado no bando de dados
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