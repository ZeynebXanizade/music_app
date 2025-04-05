import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/src/presentation/cubit/post_list/post_list_cubit.dart';
import 'package:music_app/src/screens/home_page_top_card_widgets_details.dart';

class HomePageTopCardWidgets extends StatefulWidget {
  const HomePageTopCardWidgets({super.key});

  @override
  State<HomePageTopCardWidgets> createState() => _HomePageTopCardWidgetsState();
}

class _HomePageTopCardWidgetsState extends State<HomePageTopCardWidgets> {
  final List<String> categories = ["Rock", "Pop", "Jazz", "Classical"];

  @override
  void initState() {
    super.initState();
    context.read<PostListCubit>().fetchSongsByCategory("Rock");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Trigger the fetch in the background
              context.read<PostListCubit>().fetchSongsByCategory(
                categories[index],
              );

              // Navigate to the details page immediately
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => BlocProvider.value(
                        value: context.read<PostListCubit>(),
                        child: const HomePageTopCardWidgetsDetails(),
                      ),
                ),
              );
            },
            child: Container(
              width: 150,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/${categories[index].toLowerCase()}.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
