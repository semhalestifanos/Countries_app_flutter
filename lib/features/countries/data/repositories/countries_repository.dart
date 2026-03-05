import '../models/country_detail.dart';
import '../models/country_summary_model.dart';

abstract class CountriesRepository {

  Future<List<CountrySummary>> getCountries();

  Future<List<CountrySummary>> searchCountries(String query);

  Future<CountryDetail> getCountryDetail(String code);
}
