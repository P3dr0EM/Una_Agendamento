import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:una_agendamento/app/modules/home/home_controller.dart';
import 'package:una_agendamento/app/modules/home/widgets/footer_widget.dart';
import 'package:una_agendamento/app/modules/home/widgets/menu_widget.dart';
import 'package:una_agendamento/app/modules/home/widgets/search_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(),
      drawer: MenuWidget(),
      body: Obx((){
        // 1. SE NÃO ESTIVER PESQUISANDO, MOSTRA UM PLACEHOLDER
        if(!controller.isSearching.value){
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search, size: 80, color: Colors.white,),
                SizedBox(height: 16,),
                Text(
                  'Toque na Lupa para Pesquisar',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                )
              ],
            ),
          );
        }

        // 2. SE ESTIVER PESQUISANDO, MOSTRA A LISTA DE RESULTADOS
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx((){
            if(controller.searchResults.isEmpty){
              return const Center(child: Text("Nenhum resultado encontrado"),);
            }
            return ListView.builder(
              itemCount: controller.searchResults.length,
              itemBuilder: (context, index){
                return Card(
                  child: ListTile(
                    title: Text(controller.searchResults[index]),
                  ),
                );
              }
              );
          }
          ),
          );
      }),

      bottomNavigationBar: const FooterWidget(),
    );
  }
}