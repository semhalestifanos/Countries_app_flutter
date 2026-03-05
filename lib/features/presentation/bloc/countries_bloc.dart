import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../countries/data/models/country_detail.dart';
import '../../countries/data/models/country_summary_model.dart';
import '../../countries/data/repositories/countries_repository.dart';

import 'countries_event.dart';
import 'countries_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {

  static const String favoriteKey = "favorites";

  final CountriesRepository repository;

  List<CountrySummary> _allCountries = [];
  List<String> _favoriteCodes = [];

  CountriesBloc(this.repository) : super(CountriesInitial()) {

    on<FetchCountriesEvent>(_onFetchCountries);
    on<SearchCountriesEvent>(_onSearchCountries);
    on<FetchCountryDetailEvent>(_onFetchDetail);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<LoadFavoritesEvent>(_onLoadFavorites);
  }

  Future<void> _onFetchCountries(
      FetchCountriesEvent event,
      Emitter<CountriesState> emit) async {

    emit(CountriesLoading());

    try {

      final countries = await repository.getCountries();

      _allCountries = countries;
      _allCountries.sort((a, b) => a.name.compareTo(b.name));

      await _loadFavoritesInternal();

      emit(CountriesHomeLoaded(List.from(_allCountries)));

    } catch (e) {
      emit(CountriesError("Failed to load countries"));
    }
  }

  Future<void> _onSearchCountries(
      SearchCountriesEvent event,
      Emitter<CountriesState> emit) async {

    try {

      if (event.query.trim().isEmpty) {
        emit(CountriesHomeLoaded(List.from(_allCountries)));
        return;
      }

      final result = _allCountries.where((country) =>
          country.name.toLowerCase()
              .contains(event.query.toLowerCase())).toList();

      emit(CountriesSearchLoaded(result));

    } catch (_) {
      emit(CountriesError("Search failed"));
    }
  }

  Future<void> _onFetchDetail(
      FetchCountryDetailEvent event,
      Emitter<CountriesState> emit) async {

    emit(CountryDetailLoading());

    try {

      final country =
      await repository.getCountryDetail(event.code);

      emit(CountryDetailLoaded(country));

    } catch (_) {
      emit(CountriesError("Detail load failed"));
    }
  }

  Future<void> _onLoadFavorites(
      LoadFavoritesEvent event,
      Emitter<CountriesState> emit) async {

    await _loadFavoritesInternal();

    emit(FavoritesLoaded(List.from(_favoriteCodes)));
  }

  Future<void> _onToggleFavorite(
      ToggleFavoriteEvent event,
      Emitter<CountriesState> emit) async {

    if (_favoriteCodes.contains(event.countryCode)) {
      _favoriteCodes.remove(event.countryCode);
    } else {
      _favoriteCodes.add(event.countryCode);
    }

    emit(FavoritesLoaded(List.from(_favoriteCodes)));

    SharedPreferences.getInstance().then((prefs) {
      prefs.setStringList(favoriteKey, _favoriteCodes);
    });

    emit(CountriesHomeLoaded(List.from(_allCountries)));
  }

  Future<void> _loadFavoritesInternal() async {
    final prefs = await SharedPreferences.getInstance();
    _favoriteCodes = prefs.getStringList(favoriteKey) ?? [];
  }

  List<CountrySummary> getFavoriteCountries() {
    return _allCountries
        .where((c) => _favoriteCodes.contains(c.cca2))
        .toList();
  }
}
