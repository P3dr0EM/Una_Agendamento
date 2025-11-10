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
      Future.delayed(const Duration(milliseconds: 100), () {
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