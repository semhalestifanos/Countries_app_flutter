// import '../../countries/data/models/country_detail.dart';
// import '../../countries/data/models/country_summary_model.dart';
//
// abstract class CountriesState {}
//
// class CountriesInitial extends CountriesState {}
//
// class CountriesLoading extends CountriesState {}
//
// class CountriesLoaded extends CountriesState {
//   final List<CountrySummary> countries;
//
//   CountriesLoaded(this.countries);
// }
//
// class CountryDetailLoaded extends CountriesState {
//   final CountryDetail country;
//
//   CountryDetailLoaded(this.country);
// }
//
// class CountriesError extends CountriesState {
//   final String message;
//
//   CountriesError(this.message);
// }
// class FavoritesLoaded extends CountriesState {
//   final List<String> favorites;
//
//   FavoritesLoaded(this.favorites);
// }

import '../../countries/data/models/country_detail.dart';
import '../../countries/data/models/country_summary_model.dart';

abstract class CountriesState {}

class CountriesInitial extends CountriesState {}

class CountriesLoading extends CountriesState {}

class CountriesHomeLoaded extends CountriesState {
  final List<CountrySummary> countries;

  CountriesHomeLoaded(this.countries);
}

class CountriesSearchLoaded extends CountriesState {
  final List<CountrySummary> countries;

  CountriesSearchLoaded(this.countries);
}


class CountryDetailLoaded extends CountriesState {
  final CountryDetail country;

  CountryDetailLoaded(this.country);
}
class CountryDetailLoading extends CountriesState {}

class FavoritesLoaded extends CountriesState {
  final List<String> favorites;

  FavoritesLoaded(this.favorites);
}

class CountriesError extends CountriesState {
  final String message;

  CountriesError(this.message);
}

