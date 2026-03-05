import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/service_locator.dart';
import 'features/presentation/bloc/countries_bloc.dart';
import 'features/presentation/bloc/countries_event.dart';
import 'features/presentation/bloc/theme_cubit.dart';
import 'features/presentation/pages/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [


        BlocProvider<CountriesBloc>(
          create: (_) => locator<CountriesBloc>()
            ..add(FetchCountriesEvent())
            ..add(LoadFavoritesEvent()),
        ),


        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),
      ],

      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Countries App',

            theme: theme,

            themeAnimationDuration:
            const Duration(milliseconds: 350),

            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
