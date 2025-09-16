import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();
  bool _rememberMe = false;

  void _logar() {
    debugPrint(
      "Usuário: ${userController.text} Senha: ${passWordController.text}",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              Center(
                child: Image.asset(
                  "assets/images/una.login.png",
                  width: double.infinity,
                  height: 150,
                ),
              ),
              SizedBox(height: 100),
              Padding(
                padding: EdgeInsetsGeometry.only(left: 8, right: 8),
                child: TextField(
                  controller: userController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(label: Text("LOGIN")),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsetsGeometry.only(left: 8, right: 8),
                child: TextFormField(
                  controller: passWordController,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(label: Text("SENHA")),
                ),
              ),
              SizedBox(height: 10),
              CheckboxListTile(
                title: const Text("Lembrar de mim"),
                value: _rememberMe,
                onChanged: (newValue) {
                  setState(() {
                    _rememberMe = newValue!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),

              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _logar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 206, 1, 38),
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  ),
                  child: Text("Logar"),
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: Text(
                  "Esqueceu a senha? Clique aqui!",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 32, 106),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
