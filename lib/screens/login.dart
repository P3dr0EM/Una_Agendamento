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

  void _logar() {
    debugPrint(
      "Usuário: ${userController.text} Senha: ${passWordController.text}",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color.fromARGB(255, 221, 219, 219),

      child: Column(
        children: [
          Image.asset(
            "assets/images/login.png",
            width: double.infinity,
            height: 200,
          ),
          SizedBox(height: 150),
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
          SizedBox(height: 50),
          Center(
            child: ElevatedButton(onPressed: _logar, child: Text("Entrar")),
          ),
        ],
      ),
    );
  }
}
