import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // ListView garante que o menu seja rolável se houver muitos itens.
      child: ListView(
        // Remove qualquer preenchimento da ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Um cabeçalho bonito e padrão para o Drawer.
          const UserAccountsDrawerHeader(
            accountName: Text("Nome do Usuário"),
            accountEmail: Text("usuario@email.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                "U",
                style: TextStyle(fontSize: 40.0, color: Colors.blue),
              ),
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 206, 1, 38),
            ),
          ),
          // Item de menu "Início"
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Início'),
            onTap: () {
              // Ao ser tocado, fecha o drawer.
              Get.back();
            },
          ),
          // Item de menu "Configurações"
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () {
              // Fecha o drawer e pode navegar para outra página.
              Get.back();
              // Exemplo: Get.toNamed('/configuracoes');
              Get.snackbar('Navegação', 'Indo para Configurações!');
            },
          ),
          const Divider(), // Uma linha divisória visual
          // Item de menu "Sair"
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair'),
            onTap: () {
              // Lógica de logout aqui.
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}