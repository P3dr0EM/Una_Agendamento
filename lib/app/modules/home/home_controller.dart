// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/app/modules/home/widgets/calendar_widget.dart';

class HomeController extends GetxController {
  final isSearching = false.obs;
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  final _allData = <String>[
    'Flutter', 'GetX', 'State Management', 'Dart',
    'Firebase', 'API REST', 'Clean Architecture',
    'SOLID', 'Widget', 'UI/UX'
  ].obs;

  final searchResults = <String>[].obs;

  //Variável para rastrear o índice do item selecionado no rodapé
  final tabIndex = 0.obs;

  // --- NOVO ESTADO PARA O CALENDÁRIO ---
  // Guarda a data que está atualmente em foco ou selecionada.
  var focusedDay = DateTime.now().obs;
  // Guarda a data efetivamente selecionada pelo usuário.
  var selectedDay = DateTime.now().obs;

  final carrosselPagina = 0.obs; //índice da página atual do carrossel

  //lista das imagens do carrossel
  final List<String> bannerItems =[
    'assets/images/imagemBanner01.png',
    'assets/images/imagemBanner02.png',
    'assets/images/imagemBanner03.png'
  ];

  //lista dos icones de serviços
  final List<Map<String, String>> servicosPopulares = [
    {
      "nome": "Dentista",
      "icone": "assets/icons/dentista.png",
      "rota": "/agendamento/dentista"
    },
    {
      "nome": "Psicologo",
      "icone": "assets/icons/Célebro.png",
      "rota": "/agendamento/psicologo"
    },
    {
      "nome": "Veterinária",
      "icone": "assets/icons/pet.png",
      "rota": "/agendamento/veterinaria"
    },
    {
      "nome": "Exames",
      "icone": "assets/icons/exame.png",
      "rota": "/agendamento/exames"
    },
    {
      "nome": "Financeiro",
      "icone": "assets/icons/financeiro.png",
      "rota": "/agendamento/financeiro"
    },
    {
      "nome": "Fisioterapia",
      "icone": "assets/icons/fisioterapia.png",
      "rota": "/agendamento/psicologo"
    },
  ];

  /// Função chamada ao clicar em um bloco de serviço
  void navegarParaServico(String rota, String nomeServico) {
    print("Navegando para $rota (Serviço: $nomeServico)");
    
    // Ação futura: navegar para a tela de agendamento
    // Get.toNamed(rota, arguments: {'nome': nomeServico});
    
    // Ação atual: mostrar um snackbar de feedback
    Get.snackbar(
      "Serviço Selecionado",
      "Iniciando agendamento para: $nomeServico",
      snackPosition: SnackPosition.BOTTOM
    );
  }

  void onCarouselPageChanged(int index){
    carrosselPagina.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    searchResults.assignAll(_allData);
    searchController.addListener(() {
      filterResults(searchController.text);
    });
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchController.clear();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Esta função só roda DEPOIS que a tela for redesenhada.
        // Agora, temos certeza que o TextField existe antes de focar nele.
        searchFocusNode.requestFocus();
      });
    }
  }

  void filterResults(String query) {
    if (query.isEmpty) {
      searchResults.assignAll(_allData);
    } else {
      final filtered = _allData
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
      searchResults.assignAll(filtered);
    }
  }

  void showCalendarPicker() {
    // Get.bottomSheet é a forma do GetX de chamar um ModalBottomSheet.
    Get.bottomSheet(
      CalendarWidget(),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
    );
  }

  /// Atualiza a data selecionada a partir do widget do calendário.
  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay.value = selected;
    focusedDay.value = focused;
  }

  /// Altera o índice da aba selecionada no rodapé.
  void changeTabIndex(int index) {
    tabIndex.value = index;
    // Aqui você pode adicionar lógica para mudar o conteúdo da página
    // com base no índice, se necessário.
    // Ex: if (index == 1) { carregarFavoritos(); }
    if(index == 1){
      showCalendarPicker()
;    }
  }


  @override
  void onClose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }
}