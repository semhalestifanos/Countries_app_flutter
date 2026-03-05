import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import '../../countries/data/models/country_summary_model.dart';

import '../bloc/countries_bloc.dart';
import '../bloc/countries_event.dart';
import '../bloc/countries_state.dart';

import '../bloc/theme_cubit.dart';

import '../widget/app_loader.dart';
import 'country_detail_screen.dart';
import 'favorites_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController searchController = TextEditingController();
  Timer? debounce;

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    searchController.addListener(() {
      setState(() {});
    });

    Future.microtask(() {
      context.read<CountriesBloc>()
        ..add(FetchCountriesEvent())
        ..add(LoadFavoritesEvent());
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    debounce?.cancel();
    super.dispose();
  }

  void onSearchChanged(String value) {

    debounce?.cancel();

    debounce = Timer(
      const Duration(milliseconds: 500),
          () {
        context.read<CountriesBloc>()
            .add(SearchCountriesEvent(value.trim()));
      },
    );
  }

  void clearSearch() {
    searchController.clear();

    context.read<CountriesBloc>()
        .add(SearchCountriesEvent(""));

    setState(() {});
  }

  bool isFavorite(BuildContext context, String code) {
    final bloc = context.read<CountriesBloc>();
    return bloc.getFavoriteCountries()
        .any((c) => c.cca2 == code);
  }

  @override
  Widget build(BuildContext context) {

    final themeCubit = context.read<ThemeCubit>();

    return Scaffold(

      appBar: AppBar(
        title: const Text("Countries"),
        centerTitle: true,
        automaticallyImplyLeading: false,

        actions: [

          /// ⭐ Dark Mode Toggle Button
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),

          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<CountriesBloc>()
                ..add(FetchCountriesEvent())
                ..add(LoadFavoritesEvent());
            },
          )
        ],
      ),

      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: searchController,
              onChanged: onSearchChanged,

              decoration: InputDecoration(
                hintText: "Search for a country",

                prefixIcon: const Icon(Icons.search),

                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: clearSearch,
                )
                    : null,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),

          Expanded(
            child: BlocBuilder<CountriesBloc, CountriesState>(
              builder: (context, state) {

                if (state is CountriesInitial ||
                    state is CountriesLoading) {
                  return const Center(
                    child: AppLoader(),
                  );
                }

                if (state is CountriesHomeLoaded ||
                    state is CountriesSearchLoaded) {

                  final List<CountrySummary> countries =
                  state is CountriesHomeLoaded
                      ? state.countries
                      : (state as CountriesSearchLoaded).countries;

                  if (countries.isEmpty) {
                    return const Center(
                      child: Text("No countries found"),
                    );
                  }

                  return ListView.builder(
                    itemCount: countries.length,
                    itemBuilder: (context, index) {

                      final country = countries[index];

                      final fav = isFavorite(context, country.cca2);

                      return ListTile(

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
                          icon: Icon(
                            fav
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: fav ? Colors.red : Colors.black,
                          ),

                          onPressed: () {
                            context.read<CountriesBloc>().add(
                                ToggleFavoriteEvent(country.cca2));

                            context.read<CountriesBloc>()
                                .add(LoadFavoritesEvent());
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
                      );
                    },
                  );
                }

                if (state is CountriesError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(state.message),

                        const SizedBox(height: 12),

                        ElevatedButton(
                          onPressed: () {
                            context.read<CountriesBloc>()
                                .add(FetchCountriesEvent());
                          },
                          child: const Text("Retry"),
                        )
                      ],
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });

          if (index == 1) {
            Navigator.push(
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
            icon: Icon(Icons.favorite_border),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}
