import 'package:flutter/material.dart';
import 'package:music_app/src/widgets/home_page_bottom_card_widgets.dart';
import 'package:music_app/src/widgets/home_page_top_card_widgets.dart';
import 'package:music_app/src/widgets/search_bar_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SearchBarWidgets(),
              const SizedBox(height: 30),
              HomePageTopCardWidgets(),
              const SizedBox(height: 30),
              Flexible(
                child: HomePageBottomCardWidgets(), // Daha esnek hale getirildi
              ),
            ],
          ),
        ),
      ),
    );
  }
}
