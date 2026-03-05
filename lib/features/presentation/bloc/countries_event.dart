abstract class CountriesEvent {}

class FetchCountriesEvent extends CountriesEvent {}

class SearchCountriesEvent extends CountriesEvent {
  final String query;

  SearchCountriesEvent(this.query);
}

class FetchCountryDetailEvent extends CountriesEvent {
  final String code;

  FetchCountryDetailEvent(this.code);
}
class ToggleFavoriteEvent extends CountriesEvent {
  final String countryCode;

  ToggleFavoriteEvent(this.countryCode);
}

class LoadFavoritesEvent extends CountriesEvent {}
