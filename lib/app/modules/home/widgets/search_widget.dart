import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/app/modules/home/home_controller.dart';


class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos Get.find() para obter a instância do HomeController
    // que já foi inicializada pelo HomeBinding.
    final controller = Get.find<HomeController>();

    return Obx(() {
      if (controller.isSearching.value) {
        // --- APPBAR NO MODO DE PESQUISA ---
        return AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: controller.toggleSearch,
          ),
          title: TextField(
            controller: controller.searchController,
            focusNode: controller.searchFocusNode,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: const InputDecoration(
              hintText: 'Pesquisar...',
              hintStyle: TextStyle(color: Colors.white60),
              border: InputBorder.none,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 206, 1, 38),
        );
      } else {
        // --- APPBAR NO MODO NORMAL ---
        return AppBar(
          centerTitle: true,
          title: const Text(
            'Página Inicial',
            style: TextStyle(
              color: Colors.white
            ),
            ),
          leading: IconButton(
            onPressed: (){
              // ignore: avoid_print
              print('Botão de menu pressionado');
            },
            icon: Icon(Icons.menu, color: Colors.white,)
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white,),
              onPressed: controller.toggleSearch,
            ),
          ],
          backgroundColor: Color.fromARGB(255, 206, 1, 38),
        );
      }
    });
  }

  // É necessário implementar este getter para o PreferredSizeWidget.
  // Ele informa ao Scaffold qual a altura que a nossa AppBar customizada deve ter.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}