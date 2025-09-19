import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bem Vindo!',
          style: TextStyle(
             color: Colors.white, // Define a cor do texto do título
             fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(
          Icons.person,
          color: Colors.white,
          size: 40,
        ),
        backgroundColor: Color.fromARGB(255, 206, 1, 38),
      ),
      body: Column(
        children: [
          Text("OLÁ!")
        ],
      ),
    );
  }
}