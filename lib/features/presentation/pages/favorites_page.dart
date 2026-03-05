import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/countries_bloc.dart';
import '../bloc/countries_event.dart';
import '../bloc/countries_state.dart';

import '../../countries/data/models/country_summary_model.dart';
import '../widget/app_loader.dart';
import 'country_detail_screen.dart';
import 'home_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  int selectedIndex = 1;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<CountriesBloc>().add(LoadFavoritesEvent());
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Favorites"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),

      body: BlocBuilder<CountriesBloc, CountriesState>(
        builder: (context, state) {

          if (state is FavoritesLoaded) {

            final bloc = context.read<CountriesBloc>();

            final List<CountrySummary> favorites =
            bloc.getFavoriteCountries();

            if (favorites.isEmpty) {
              return const Center(
                child: Text("No favorites yet"),
              );
            }

            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {

                final country = favorites[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),

                  child: ListTile(

                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        country.flag,
                        width: 50,
                        height: 35,
                        fit: BoxFit.cover,
                      ),
                    ),

                    title: Text(country.name),

                    trailing: IconButton(
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        context.read<CountriesBloc>().add(
                          ToggleFavoriteEvent(country.cca2),
                        );

                        context.read<CountriesBloc>().add(
                          LoadFavoritesEvent(),
                        );
                      },
                    ),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CountryDetailScreen(
                            code: country.cca2,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }

          return const Center(
            child: AppLoader(),
          );
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,

        onTap: (index) {

          setState(() {
            selectedIndex = index;
          });

          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const HomeScreen(),
              ),
            );
          }

          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const FavoritesScreen(),
              ),
            );
          }
        },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}
