import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/app/modules/home/home_controller.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //Acessa a instância do controlador
    final controller = Get.find<HomeController>();

    //Usa um Obx para que o widget seja reconstruido quando o tabIndex for atualizado 
    return Obx(() => BottomNavigationBar(
          // Define os itens do rodapé
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Início',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favoritos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
          // Vincula o índice atual à variável de estado do controlador
          currentIndex: controller.tabIndex.value,
          // Define a cor do ícone selecionado
          selectedItemColor: Colors.blue,
          // Define a cor dos ícones não selecionados
          unselectedItemColor: Colors.grey,
          // Chama a função do controlador quando um item é tocado
          onTap: controller.changeTabIndex,
          // Efeito visual ao tocar
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ));
  }
}