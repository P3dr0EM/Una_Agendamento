import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  /// Altera o índice da aba selecionada no rodapé.
  void changeTabIndex(int index) {
    tabIndex.value = index;
    // Aqui você pode adicionar lógica para mudar o conteúdo da página
    // com base no índice, se necessário.
    // Ex: if (index == 1) { carregarFavoritos(); }
  }

  @override
  void onClose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }
}