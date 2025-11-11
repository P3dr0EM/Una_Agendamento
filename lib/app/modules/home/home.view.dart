import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:una_agendamento/app/modules/home/home_controller.dart';
import 'package:una_agendamento/app/modules/home/widgets/carrossel_widget.dart';
import 'package:una_agendamento/app/modules/home/widgets/footer_widget.dart';
import 'package:una_agendamento/app/modules/home/widgets/menu_widget.dart';
import 'package:una_agendamento/app/modules/home/widgets/search_widget.dart';
import 'package:una_agendamento/app/modules/home/widgets/service_blocks_widget.dart';
import 'package:una_agendamento/app/modules/home/widgets/welcome_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(),
      drawer: MenuWidget(),
      body: ListView(
        children: [
          Obx(() {
            if (!controller.isSearching.value) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WelcomeHeaderWidget(),
                  const SizedBox(height: 10),
                  const CarouselWidget(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16.0,
                    ),
                    child: Text(
                      'Serviços Populares',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GridView.count(
                      crossAxisCount: 3, // 3 blocos por linha
                      // ESSAS DUAS LINHAS SÃO CRÍTICAS para o Grid funcionar dentro de um ListView
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),

                      crossAxisSpacing: 12, // Espaçamento horizontal
                      mainAxisSpacing: 12, // Espaçamento vertical
                      // Mapeia a lista do controller para os widgets de bloco
                      children: controller.servicosPopulares.map((servico) {
                        return ServiceBlockWidget(
                          assetPath: servico['icone']!,
                          text: servico['nome']!,
                          onTap: () => controller.navegarParaServico(
                            servico['rota']!,
                            servico['nome']!,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            }

            // 2. SE ESTIVER PESQUISANDO, MOSTRA A LISTA DE RESULTADOS
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() {
                if (controller.searchResults.isEmpty) {
                  return const Center(
                    child: Text("Nenhum resultado encontrado"),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.searchResults.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(controller.searchResults[index]),
                      ),
                    );
                  },
                );
              }),
            );
          }),
        ],
      ),
      bottomNavigationBar: const FooterWidget(),
    );
  }
}
