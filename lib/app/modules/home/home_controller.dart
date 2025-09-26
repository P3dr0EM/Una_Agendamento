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

  @override
  void onClose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }
}