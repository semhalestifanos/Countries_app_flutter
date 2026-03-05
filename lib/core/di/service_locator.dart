import 'package:get_it/get_it.dart';

import '../../features/countries/data/datasources/countries_remote_datasource.dart';
import '../../features/countries/data/repositories/countries_repository.dart';
import '../../features/countries/data/repositories/countries_repository_impl.dart';

import '../../features/presentation/bloc/countries_bloc.dart';

import '../network/api_client.dart';

final locator = GetIt.instance;

void setupLocator() {

  locator.registerLazySingleton<ApiClient>(
        () => ApiClient(),
  );

  locator.registerLazySingleton<CountriesRemoteDataSource>(
        () => CountriesRemoteDataSource(
      locator<ApiClient>(),
    ),
  );

  locator.registerLazySingleton<CountriesRepository>(
        () => CountriesRepositoryImpl(
      locator<CountriesRemoteDataSource>(),
    ),
  );

  locator.registerFactory<CountriesBloc>(
        () => CountriesBloc(
      locator<CountriesRepository>(),
    ),
  );
}
