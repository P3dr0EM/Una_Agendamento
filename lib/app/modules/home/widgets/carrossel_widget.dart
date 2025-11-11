// lib/app/modules/home/widgets/carousel_widget.dart
// (NOVO ARQUIVO)

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../home_controller.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Acessa o HomeController
    final controller = Get.find<HomeController>();

    // Constrói a lista de widgets de imagem a partir da lista de strings do controller
    final List<Widget> imageSliders = controller.bannerItems
        .map((item) => Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: Image.asset(
                  item,
                  fit: BoxFit.cover, // Preenche o espaço do banner
                  width: 1000.0,
                ),
              ),
            ))
        .toList();

    return Column(
      children: [
        // 1. O CARROSSEL EM SI
        CarouselSlider(
          items: imageSliders,
          options: CarouselOptions(
            autoPlay: true, // Inicia a reprodução automática
            autoPlayInterval: const Duration(seconds: 5), // Intervalo de 3 segundos
            aspectRatio: 16 / 9, // Proporção comum para banners
            enlargeCenterPage: true, // Destaca a página central
            viewportFraction: 0.8, // Mostra um pouco das páginas laterais
            // Função chamada quando a página muda
            onPageChanged: (index, reason) {
              controller.onCarouselPageChanged(index);
            },
          ),
        ),

        // 2. OS INDICADORES ("PONTINHOS")
        // Obx reage à mudança do carouselCurrentPage no controller
        Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: controller.bannerItems.asMap().entries.map((entry) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // Muda a cor com base no índice atual
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(
                          controller.carrosselPagina.value == entry.key
                              ? 0.9
                              : 0.4),
                ),
              );
            }).toList(),
          );
        }),
      ],
    );
  }
}